# save as sd-image.nix somewhere
{ ... }: {
  # nixpkgs.crossSystem.system = "aarch64-linux";
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  time.timeZone = "NZ";
  i18n.defaultLocale = "en_US.UTF-8";

  sdImage.compressImage = false;

  system = {
    stateVersion = "22.05";
  };

  nixpkgs.config.allowUnfree = true;
  hardware.opengl.enable = true;

  boot.loader.raspberryPi = {
    enable = true;
    version = 3;
    firmwareConfig = ''
      core_freq=250
    '';
  };

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  # put your own configuration here, for example ssh keys:
  users.users.edeetee.openssh.authorizedKeys.keys = [
     "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCfIZH1o0ayWQGxhzJONFGTWTN1Gzw7G3ONHlELaYPgvjthQSIwpIsfa/YU/eS+guWE4NJJqOrY9M9O8VpDFq2eSTUssM9IFS3aXhU6V7dI7ywzdBNncsXMoJNBfakmqUtPU2eltIpANR/pjzxsJQ7cnuCeEvCTChjxvBQPFy3pcYdELaVKHm8w6tJ+fyR7wms69bbypubQIcIHUqfnrLo6DsHdDQaWBgo207bRY1Q1MoJEtTghu3HAgmslcWI23uMo4voJ7F7NXwGsNzvH9KckBzGHBDL3t/cwtNQm4xa0kvvEOAwJAdy+bnp0lnlqN6B5Hyy7zRdPuAlkSnqnEl1CqOZ1f9lvnC+gRjv/QO0F01DFGuTfhp/0GFjn1plsRie45eOtfcxB2JeVwZoTZXIjr/iM04WURgJJPvm/RyoBjp1NLcZDUunBon+L6CWVfCk8Qntlo6pXI9PdHtXoAQQTexB1rPPzGkpWZ6MffNfzpFIZ/ZsHGmyaloA9i9ALEGU= edwardtaylor@edwards-mbp.lan"
  ];

  users.users.edeetee = {
  isNormalUser = true;
  extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
  packages = with pkgs; [];

  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

    # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.autoSuspend = false;  

  hardware.enableRedistributableFirmware = true;
  networking.wireless.enable = true;

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "nixos-rpi3b";
}