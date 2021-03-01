{ lib, stdenv, fetchFromGitHub, nasm, static ? false }:

stdenv.mkDerivation rec {
  pname = "ipsec-mb";
  version = "0.55";

  src = fetchFromGitHub {
    owner = "intel";
    repo = "intel-ipsec-mb";
    rev = "843938bfaedd6ed055de6dce2517cfb3f43aa509";
    sha256 = "sha256-ztNDaEJOnlC2Rin23yCrEnCK9zjwKBEDbCiu/Dn8VX0=";
  };

  nativeBuildInputs = [ nasm ];
  makeFlags = [ "PREFIX=$(out)" "NOLDCONFIG=y" ]
    ++ lib.optionals static [ "SHARED=n" ];
  enableParallelBuilding = true;
}
