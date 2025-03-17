{
  lib,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "hl-tricky-floaty";
  version = "0.1.0";

  src = ./src;

  useFetchCargoVendor = true;

  cargoHash = "sha256-dOTQku8dlan9iktVq2F+O9OAQkg10Yf2OwSYmh6rFlE=";

  meta = {
    description = "Rust implementation ";
    homepage = "https://github.com/euclio/mdpls";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ heisfer ];
    mainProgram = "hl-tricky-floaty";
  };
}
