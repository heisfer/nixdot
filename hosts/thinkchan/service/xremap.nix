{
  services.xremap = {
    withHypr = true;
    userName = "heisfer";
    serviceMode = "user";
    deviceName = "AT Translated Set 2 keyboard";
    yamlConfig = ''
      virtual_modifiers:
        - CapsLock
      keymap:
        - name: Global
          remap:            

            # Programmer-colemak layout for third layer
            CAPSLOCK-A: LEFTBRACE
            CAPSLOCK-S: SHIFT-LEFTBRACE
            CAPSLOCK-D: EQUAL
            CAPSLOCK-F: SHIFT-9
            CAPSLOCK-G: SHIFT-8
            CAPSLOCK-H: MINUS
            CAPSLOCK-J: SHIFT-0
            CAPSLOCK-K: SHIFT-MINUS
            CAPSLOCK-L: SHIFT-RIGHTBRACE
            CAPSLOCK-SEMICOLON: RIGHTBRACE
            
    '';
  };
}
