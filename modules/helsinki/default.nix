{
  # These are modules that are from helsinki and used by the BigBlueButton modules.
  # Since helsinki is not open-source, we provide the needed modules (and module stubs) here.
  imports = [
    ./apparmor-confinement.nix
    ./systemd-sandbox.nix
  ];
}