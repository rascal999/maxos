{ config, pkgs, lib, ... }: {
  services.syncthing = {
    enable = true;

    folders = {
      "Camera" = {
        id = "gm1920_16jh-photos";
        devices = [
          "blueboy"
          "GM1920"
          "rig"
          "rog"
        ];
      };

      "Data" = {
        id = "kwfru-wgejw";
        devices = [
          "blueboy"
          "GM1920"
          "rig"
          "rog"
        ];
      };
    };

    devices = {
      "blueboy" = {
        autoAcceptFolders = true;
        id = "3YBMQYS-46IZSTQ-HLIP3O2-E22P3GJ-OS2PFCY-GTINZAF-PMH6HTN-2GDV4Q3";
        introducer = false;
      };
      "GM1920" = {
        id = "UAULTZS-JD7M5HI-E2BDK34-KOVLIGV-JZO357W-I2GGN25-IKOFLB7-B5SGRQD";
        introducer = true;
      };
      "rig" = {
        autoAcceptFolders = true;
        id = "JI3WBOJ-OCPX2PC-YBWPNJJ-WHHPMG3-LTHUN57-2PWLZUU-VMFA32S-TP7MPAN";
        introducer = false;
      };
      "rog" = {
        autoAcceptFolders = true;
        id = "NDXASQ4-A36OLGF-2OYABLJ-MZCPDIA-TDZR56X-4L4X6O3-4E5KSEY-3MVKTA2";
        introducer = false;
      };
    };

    dataDir = "/home/user/syncthing";
    extraOptions = {
      gui = {
        theme = "black";
        tls = true;
      };
    };
    user = "user";
  };
}
