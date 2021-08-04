{
  description = "A flake for DosBox 0.73";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "dosbox73_sk4zuzu";
        version = "svn/RELEASE_0_73";

        src = fetchFromGitHub {
          owner = "dosbox-staging";
          repo = "dosbox-staging";
          rev = version;
          sha256 = "sha256-MAo2MXkXxdlQBCcRe/W58elxu6KgWZqR0+IYNr1/fHM=";
        };

        nativeBuildInputs = [ autoconf automake ];

        buildInputs = [ SDL SDL_net SDL_sound ];

        preConfigure = ''
          ./autogen.sh
        '';

        NIX_CFLAGS_COMPILE = [ "-Wno-error=format-security" ];
      };
  };
}
