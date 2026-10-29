{ ... }:

{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        homes.id = "T5BKMJ7-HDWMNUI-DYP7VR6-QKW4456-7CIB5FJ-KU3NRTB-O7EPYD2-7AABJAH";
        s24s.id = "OS672XH-TUBGY6O-FHCDXXJ-DZJDMJB-JKIO5UM-O63CLBD-LDSX46K-PE5PWQC";
      };
      folders = {
        secrets = {
          id = "secrets";
          enable = true;
          devices = [ "homes" "s24s" ];
          path = "~/secrets";
        };
        obsidian-vault = {
          id = "obsidian-vault";
          enable = true;
          devices = [ "homes" "s24s" ];
          path = "~/obsidian-vault";
        };
        working-directory = {
          id = "working-directory";
          enable = true;
          devices = [ "homes" "s24s" ];
          path = "~/working-directory";
        };
      };
    };
  };
}
