# AstroNvim

My [AstroNvim](https://github.com/AstroNvim/AstroNvim) configuration Based on
the user configuration template.

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Clone AstroNvim

```shell
git clone https://github.com/AstroNvim/AstroNvim "${XDG_CONFIG_HOME:-~/.config}/nvim"
```

#### Clone my configuration

```shell
git clone https://github.com/manuuurino/astronvim_config "${XDG_CONFIG_HOME:-~/.config}/nvim/lua/user"
```

#### Try my config in a docker container

<!-- credits: https://github.com/AstroNvim/docs/blob/8646dd525c476fdb7429c310f4ff8018bf2f285f/src/content/docs/index.mdx#L106-L114 -->

```shell
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add bash git lua nodejs npm lazygit bottom python3 go neovim ripgrep alpine-sdk --update
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  git clone https://github.com/manuuurino/astronvim_config ~/.config/nvim/lua/user
  bash
'
```
