{ stdenv
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "coff";
  version = "0.0.8";

  src = fetchPypi {
    inherit pname version;
    sha256="5f552840db2f0e643f7b4353b290fc0c5712410a05c969dfee83d7ee009a2046";
  };

  meta = with stdenv.lib; {
    description = "common object file format parser";
    homepage = "https://github.com/jeppeter/py-coff";
    license = licenses.publicDomain;
    maintainers = [ ];
  };
}
