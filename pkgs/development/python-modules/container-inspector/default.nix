{ lib
, attrs
, buildPythonPackage
, click
, commoncode
, dockerfile-parse
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "container-inspector";
  version = "31.0.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "nexB";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-YwtyNZsTMb8iFXo/rojvjkKUbMNRCXVamzFykpwYCOk=";
  };

  dontConfigure = true;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    attrs
    click
    dockerfile-parse
    commoncode
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "container_inspector"
  ];

  meta = with lib; {
    description = "Suite of analysis utilities and command line tools for container images";
    homepage = "https://github.com/nexB/container-inspector";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
