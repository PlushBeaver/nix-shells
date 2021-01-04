{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";

  outputs = { nixpkgs, ... }: {
    packages.x86_64-linux = with nixpkgs.legacyPackages.x86_64-linux;
      let
        pythonVersion =
          with python3.sourceVersion; "${major}.${minor}";

        linuxScripts =
          "${linux.dev}/lib/modules/${linux.dev.version}/source/scripts";

        commonPackages = [
          codespell
          linux.dev
          meson
          ninja
          shellcheck
          (with python3Packages; [
            black
            pip
            pyelftools
            rope
            sphinx
            yapf
          ])
        ];

        commonEnv = {
          DPDK_CHECKPATCH_PATH =
            "${linuxScripts}/checkpatch.pl";
          DPDK_CHECKPATCH_CODESPELL =
            "${codespell.out}/lib/python${pythonVersion}/site-packages/codespell_lib/data/dictionary.txt";
          DPDK_GETMAINTAINER_PATH =
            "${linuxScripts}/get_maintainer.pl";
        };

      in {
        windows = pkgsCross.mingwW64.mkShell (commonEnv // {
          nativeBuildInputs = [ commonPackages binutils-unwrapped ];

          CC = "";
          LD = "";
          STRIP = "";
        });

        linux = mkShell (commonEnv // {
          nativeBuildInputs = [ commonPackages clang ];

          buildInputs = [ numactl pkgconfig ];
        });
      };
  };
}
