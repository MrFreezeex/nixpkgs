{ lib
, aiohttp
, asyncio-throttle
, awesomeversion
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "aiohue";
  version = "4.6.1";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "home-assistant-libs";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-ATM4s2W1Gw98TysfqHVA/McerZStHaUK5eMrSU9+uOI=";
  };

  propagatedBuildInputs = [
    awesomeversion
    aiohttp
    asyncio-throttle
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "aiohue"
    "aiohue.discovery"
  ];

  disabledTestPaths = [
    # File are prefixed with test_
    "examples/"
  ];

  meta = with lib; {
    description = "Python package to talk to Philips Hue";
    homepage = "https://github.com/home-assistant-libs/aiohue";
    changelog = "https://github.com/home-assistant-libs/aiohue/releases/tag/${version}";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
