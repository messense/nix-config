{ ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "snazzy";
      editor = {
        true-color = true;
        mouse = true;
        bufferline = "multiple";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        indent-guides = {
          render = true;
          character = "┆";
        };
      };
    };

    languages = {
      language = [
        {
          name = "python";
          roots = [ "pyproject.toml" ];
          language-servers = [
            "pyright"
            "ruff"
          ];
        }
      ];

      language-server.pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
      };

      language-server.ruff = {
        command = "ruff";
        args = [ "server" ];
      };
    };
  };
}
