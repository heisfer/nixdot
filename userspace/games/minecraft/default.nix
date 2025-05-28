{ pkgs, ... }:
{

  environment.systemPackages = [
    # (pr389902.modrinth-app.override {
    #   jdks = with pkgs; [
    #     temurin-jre-bin-21
    #     temurin-jre-bin-8
    #     temurin-jre-bin-17
    #   ];
    # })
    # pkgs.modrinth-app
    pkgs.prismlauncher
  ];
}
