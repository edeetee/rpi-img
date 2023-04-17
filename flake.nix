{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux = {
      rpi = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          "./rpi-sdcard.nix'
        ];
        format = "sd-aarch64";
        
      };
    };
  };
}