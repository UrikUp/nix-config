{ pkgs, ... }:
{
  # stylix.targets.firefox.profileNames = [ "urik" ];
  programs.firefox = {
    enable = true;

    profiles.urik = {
      isDefault = true;

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          vimium
          bitwarden
          darkreader
        ];
      };

    
      # userChrome = ''
      #   /* Hide native tab bar when Sidebery is active */
      #   #main-window[titlepreface="."] #TabsToolbar > * { display: none !important; }
      #   #main-window[titlepreface="."] #nav-bar { border-color: transparent !important; }

      #   /* Hide Firefox's new sidebar UI, keep Sidebery's */
      #   #sidebar-main,
      #   #sidebar-launcher-splitter { display: none !important; }
      #   #sidebar-panel-header        { display: none; }
      #   #sidebar-box                 { padding: 0 !important; }
      #   #sidebar-box #sidebar {
      #     box-shadow:    none !important;
      #     border:        none !important;
      #     outline:       none !important;
      #     border-radius: 0    !important;
      #   }
      # '';

  
      settings = {
        # --- userChrome.css ---
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # --- sync ---
        "identity.fxaccounts.enabled"        = true;
        "services.sync.engine.passwords"     = true;
        "services.sync.engine.bookmarks"     = true;
        "services.sync.engine.history"       = true;
        "services.sync.engine.extensions"    = false; # managed by home-manager

        # --- performance ---
        "gfx.webrender.all"                  = true;   # GPU compositing
        "media.ffmpeg.vaapi.enabled"         = true;   # VA-API hardware decode
        "media.hardware-video-decoding.force-enabled" = true;
        "browser.cache.disk.enable"          = false;
        "browser.cache.memory.enable"        = true;
        "browser.cache.memory.capacity"      = 524288; # 512 MB

        # --- Wayland / XDG portals ---
        # "widget.use-xdg-desktop-portal.file-picker"   = 1;
        # "widget.use-xdg-desktop-portal.mime-handler"  = 1;
        # "widget.wayland.fractional-scale.enabled" = false;

        # --- new tab / startup ---
        "browser.startup.homepage"                        = "about:blank";
        "browser.newtabpage.enabled"                      = false;
        "browser.shell.checkDefaultBrowser"               = false;
        "browser.sessionstore.resume_previous_session"    = false;
        "browser.tabs.warnOnClose"                        = false;
      };

      search = {
        force   = true;
        default = "google";
        order   = [ "Searx" "Nix Packages" "NixOS Wiki" "google" ];

        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type";  value = "packages";      }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            icon           = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nw" ];
          };

          "Searx" = {
            urls = [{ template = "https://priv.au/?q={searchTerms}"; }];
            definedAliases = [ "@sx" ];
          };
          "google".metaData.alias = "@g";
          "bing".metaData.hidden  = true;
          };
        };
      };
    };
}
