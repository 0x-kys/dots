{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.fish;
    users = { 
      syk = {
        isNormalUser = true;
        description = "okay sure";
        extraGroups = [ "networkmanager" "wheel" "video" ];
      };
    };
  };
}
