{ ... }:

{
  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };
}
