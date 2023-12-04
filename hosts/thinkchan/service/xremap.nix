{
  services.xremap = {
    serviceMode = "user";
    withWlroots = true;
    userName = "heisfer";
    config = {
      keymap = [
        {
          remap = {
            C-h = "Backspace";
          };
        }
      ];
    };
  };
}
