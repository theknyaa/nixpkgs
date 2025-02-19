{ lib
, buildPythonPackage
, fetchFromGitHub
, parameterized
, ply
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "pyomo";
  version = "6.4.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    repo = "pyomo";
    owner = "pyomo";
    rev = version;
    hash = "sha256-FdUhne5Dn5hTIXMce1G6Zu6nx+AuP/JdK0a5fCE3hg8=";
  };

  propagatedBuildInputs = [
    ply
  ];

  checkInputs = [
    parameterized
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "pyomo"
  ];

  preCheck = ''
    export HOME=$(mktemp -d);
  '';

  disabledTestPaths = [
    # Don't test the documentation and the examples
    "doc/"
    "examples/"
    # Tests don't work properly in the sandbox
    "pyomo/environ/tests/test_environ.py"
  ];

  disabledTests = [
    # Test requires lsb_release
    "test_get_os_version"
  ];

  meta = with lib; {
    description = "Python Optimization Modeling Objects";
    homepage = "http://pyomo.org";
    license = licenses.bsd3;
    maintainers = with maintainers; [ costrouc ];
  };
}
