# My `~/.config/nix`

Install [Determinate Nix](https://docs.determinate.systems/determinate-nix/):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
```

Clone repository:

```bash
mkdir -p ~/.config && git clone git@github.com:messense/nix-config.git ~/.config/nix
```

Activating `nix-darwin` config on first time use:

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix
```

Rebuild system configuration after making changes:

```
darwin-rebuild switch --flake ~/.config/nix
```
