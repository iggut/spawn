{
  config,
  lib,
  pkgs,
  ...
}: {

      xdg.configFile."nwg-drawer/drawer.css".text = ''
        window {
            background-color: transparent;
        }

        /* search entry */
        entry {
            box-shadow: 0 0 6px 5px #2e3440;
            background-color: rgba (0, 0, 0, 0.2)
        }

        button, image {
            background-color: #FF2222;
            background: none;
            border: none;
            margin: 4px;

        }

        button:hover {
            background-color: rgba (0, 0, 0, 0.2)
        }

        button:focus {
            background-color: rgba (0, 0, 0, 0.3);
        }

        /* in case you wanted to give category buttons a different look */
        category-button {
            margin: 0 10px 0 10px
        }

        pinned-box {
            padding-bottom: 5px;
            border-bottom: 1px dotted gray
        }

        files-box {
            padding: 5px;
            border: 1px dotted gray;
            border-radius: 15px
        }

      '';
  
}
