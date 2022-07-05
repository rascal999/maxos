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
        path = "/home/user/Camera";
      };

      "Data" = {
        id = "kwfru-wgejw";
        devices = [
          "blueboy"
          "GM1920"
          "rig"
          "rog"
        ];
        path = "/home/user/Data";
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
        id = "TTM76HX-M6H5JG7-KZ2YHMG-UPT5HQZ-OEPQFNX-FOMAWGB-GPTYPG6-QS7DHA4";
        introducer = false;
      };
      "rog" = {
        autoAcceptFolders = true;
        id = "JI3WBOJ-OCPX2PC-YBWPNJJ-WHHPMG3-LTHUN57-2PWLZUU-VMFA32S-TP7MPAN";
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
