{...}: {
  programs.thunderbird = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      settings = {
        "calander.timezone.local" = "Europe/Tallinn";
        "calander.timezone.useSystemTimezone" = true;
        "mail.markAsReadOnSpam" = true;
      };
    };
  };
}
