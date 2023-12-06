{
  services.xremap = {
    withHypr = true;
    userName = "heisfer";
    serviceMode = "user";
    deviceName = "AT Translated Set 2 keyboard";
    yamlConfig = ''

      keymap:
        - name: Global
          remap:            

            # Programmer-colemak layout for third layer
            KEY_RIGHTALT-E: SHIFT-4
            KEY_RIGHTALT-A: LEFTBRACE
            KEY_RIGHTALT-S: SHIFT-LEFTBRACE
            KEY_RIGHTALT-D: EQUAL
            KEY_RIGHTALT-F: SHIFT-9
            KEY_RIGHTALT-G: SHIFT-8
            KEY_RIGHTALT-H: MINUS
            KEY_RIGHTALT-J: SHIFT-0
            KEY_RIGHTALT-K: SHIFT-MINUS
            KEY_RIGHTALT-L: SHIFT-RIGHTBRACE
            KEY_RIGHTALT-SEMICOLON: RIGHTBRACE
            
            
    '';
  };
}
