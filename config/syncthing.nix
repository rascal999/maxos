{ config, pkgs, lib, ... }: {
  services.syncthing = {
    enable = true;

    dataDir = "/home/user/syncthing";
    settings = {
      devices = {
        "blueboy" = {
          id = "3YBMQYS-46IZSTQ-HLIP3O2-E22P3GJ-OS2PFCY-GTINZAF-PMH6HTN-2GDV4Q3";
          introducer = false;
        };
        "fold4" = {
          id = "PLY3QVN-3NQYXXB-PJO6KJ3-3MJ3H6B-QVQKRWI-CNX6PNS-VDADBY2-2J4VFA5";
          introducer = false;
        };
        "galaxy" = {
          id = "SJF4JGR-DGCWKNR-UKMZOKZ-C6QRU3G-6TOU2CW-X2DSNPG-2HCOZ6K-PTQBUQO";
          introducer = false;
        };
        "nas" = {
          id = "DCL3E6N-GIZIFEM-Z4ADAKR-IY2WT5M-G4ADVCI-LANSWO5-VIVH4H4-JDF6WAI";
          introducer = true;
        };
        "rig" = {
          id = "SNF65KI-OYAEUQI-ORP7UGO-DC5YB24-4OVTHXG-V3VHIXR-GJEVTCZ-LFEFHQD";
          introducer = false;
        };
        "GM1920" = {
          id = "UAULTZS-JD7M5HI-E2BDK34-KOVLIGV-JZO357W-I2GGN25-IKOFLB7-B5SGRQD";
          introducer = false;
        };
        "A35" = {
          id = "QPHCTOZ-J4MWXDR-E27PP2W-4PGWJW6-K2KK4GG-BCH3CI4-QTBS45I-53XD3AF";
          introducer = false;
        };
      };

      folders = {
        "Phone" = {
          id = "phone";
          devices = [
            "blueboy"
            "galaxy"
            "nas"
            "rig"
            "fold4"
            #"GM1920"
          ];
          path = "/home/user/Phone";
        };

        "Data" = {
          id = "data";
          devices = [
            "blueboy"
            "galaxy"
            "nas"
            "rig"
            "fold4"
            "A35"
            #"GM1920"
          ];
          path = "/home/user/Data";
        };
      };

      gui = {
        theme = "black";
        tls = true;
      };
    };
    user = "user";
  };
}
