{ stdenv, fetchgit, zig }:

let
  ghosttySrc = builtins.fetchGit {
    url = "git@github.com:ghostty-org/ghostty.git";
    rev = "HEAD";  # or any specific commit or branch
    ref = "master";  # or the branch you want to fetch
  };
in
stdenv.mkDerivation rec {
  pname = "ghostty";
  version = "latest";

  src = ghosttySrc;

  nativeBuildInputs = [ zig ];

  buildPhase = ''
    zig build -Doptimize=ReleaseFast
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./zig-out/bin/ghostty $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "Ghostty - A modern terminal emulator";
    homepage = "https://github.com/ghostty-org/ghostty";
    license = licenses.mit;  # Replace with the actual license
    platforms = platforms.linux;
  };
}
