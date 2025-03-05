{
  hjem.users.heisfer.files.".config/helix/config.toml".text # toml
    =
      ''
        theme = "rose_pine"

        [editor]
        completion-timeout = 5
        completion-trigger-len = 1
        color-modes = true
        end-of-line-diagnostics = "hint"


        [editor.cursor-shape]
        insert = "bar"
        normal = "block"
        select = "underline"

        [editor.file-picker]
        ignore = true

      ''; # not gonna add languages for now. Gonna make separate module later
}
