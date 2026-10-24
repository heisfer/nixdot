{ self, inputs, ... }:
{
  perSystem =
    {
      inputs',
      system,
      lib,
      ...
    }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;

      eval = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.nixosModules.losfelt
          { nixpkgs.hostPlatform = system; }
        ];
      };

      optionsDoc = pkgs.nixosOptionsDoc {
        options = { inherit (eval.options) losfelt; };
        warningsAreErrors = false;

        transformOptions =
          opt:
          opt
          // {
            declarations = map (
              d:
              let
                rel = builtins.head (
                  lib.splitString ", via option" (lib.removePrefix "${toString self}/" (toString d))
                );
              in
              {
                name = rel;
                url = "https://github.com/heisfer/nixdot/blob/revision/${rel}";
              }
            ) opt.declarations;
          };
      };

      gen = pkgs.writeText "gen-docs.py" ''
        import json, re, sys

        src, out = sys.argv[1], sys.argv[2]
        opts = json.load(open(src))
        DEPTH = 3  # losfelt.networking.ssh -> one page; use 2 for fewer, bigger pages


        def text(v):
            if isinstance(v, dict):
                return v.get("text", "")
            return "" if v is None else str(v)


        def slug(s):
            return re.sub(r"[^A-Za-z0-9_-]+", "-", s).strip("-")


        def code(v):
            t = text(v)
            return "\n```nix\n" + t + "\n```" if "\n" in t else " `" + t + "`"


        def render(name, o, node):
            prefix = ".".join(node) + "."
            short = name[len(prefix):] if name.startswith(prefix) else name
            lines = ["### `" + short + "`", ""]
            desc = text(o.get("description"))
            if desc:
                lines += [desc, ""]
            lines.append("- **Type:** `" + str(o.get("type", "")) + "`")
            if "default" in o:
                lines.append("- **Default:**" + code(o["default"]))
            if "example" in o:
                lines.append("- **Example:**" + code(o["example"]))
            if o.get("readOnly"):
                lines.append("- **Read-only**")
            decls = []
            for d in o.get("declarations", []):
                if isinstance(d, dict):
                    decls.append("[" + d["name"] + "](" + d["url"] + ")")
                else:
                    decls.append("`" + str(d) + "`")
            if decls:
                lines.append("- **Declared by:** " + ", ".join(decls))
            return "\n".join(lines) + "\n"


        def group_key(name):
            parts = name.split(".")
            key = []
            for p in parts[: max(1, min(DEPTH, len(parts) - 1))]:
                if p.startswith("<"):
                    break
                key.append(p)
            return tuple(key) or ("misc",)


        groups = {}
        for name, o in sorted(opts.items()):
            groups.setdefault(group_key(name), []).append((name, o))

        # every prefix of every group becomes a page
        nodes = set()
        for key in groups:
            for i in range(1, len(key) + 1):
                nodes.add(key[:i])


        def under(node):
            items = []
            for key, entries in groups.items():
                if key[: len(node)] == node:
                    items += entries
            return sorted(items, key=lambda e: e[0])


        for node in nodes:
            body = ["# " + ".".join(node), ""]
            body += [render(n, o, node) for n, o in under(node)]
            with open(out + "/" + slug("-".join(node)) + ".md", "w") as f:
                f.write("\n".join(body))

        with open(out + "/index.md", "w") as f:
            f.write("# losfelt options\n\nPick a module from the sidebar.\n")

        summary = ["# Summary", "", "[Overview](index.md)", ""]
        for node in sorted(nodes):
            indent = "    " * (len(node) - 1)
            summary.append(indent + "- [" + node[-1] + "](" + slug("-".join(node)) + ".md)")

        with open(out + "/SUMMARY.md", "w") as f:
            f.write("\n".join(summary) + "\n")
      '';
    in
    {
      packages.docs-site =
        pkgs.runCommand "losfelt-docs"
          {
            nativeBuildInputs = [
              pkgs.mdbook
              pkgs.python3
            ];
          }
          ''
            mkdir -p book/src
            python3 ${gen} ${optionsDoc.optionsJSON}/share/doc/nixos/options.json book/src

            cat > book/book.toml <<'EOF'
            [book]
            title = "losfelt"
            src = "src"

            [output.html.fold]
            enable = true
            level = 1
            EOF

            mdbook build book --dest-dir $out
          '';
    };
}
