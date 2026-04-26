# dotfiles

`chezmoi` で導入できる dotfiles リポジトリです。

このリポジトリ自身は GitHub に置き、ホームディレクトリへ反映したいファイルだけを `chezmoi` の source state として管理します。

## 構成

- `dot_zshrc`: `~/.zshrc`
- `dot_config/fish/config.fish`: `~/.config/fish/config.fish`
- `dot_gitconfig.tmpl`: `~/.gitconfig`
- `dot_config/git/ignore`: `~/.config/git/ignore`
- `dot_config/shell/aliases.sh`: `~/.config/shell/aliases.sh`
- `dot_config/atuin/config.toml`: `~/.config/atuin/config.toml`
- `dot_config/starship.toml`: `~/.config/starship.toml`
- `dot_config/mise/config.toml`: `~/.config/mise/config.toml`
- `dot_config/yazi/{yazi,keymap,theme}.toml`: `~/.config/yazi/`
- `dot_config/zellij/config.kdl`: `~/.config/zellij/config.kdl`
- `dot_config/topgrade.toml`: `~/.config/topgrade.toml`
- `dot_config/lazygit/config.yml`: `~/.config/lazygit/config.yml`
- `dot_config/ghostty/config.ghostty`: `~/.config/ghostty/config.ghostty`
- `dot_config/MangoHud/MangoHud.conf`: `~/.config/MangoHud/MangoHud.conf`
- `dot_config/mozc/ibus_config.textproto`: `~/.config/mozc/ibus_config.textproto`
- `dot_local/share/nautilus/scripts/executable_Open in Ghostty`: Nautilus スクリプト
- `cog.toml`: Cocogitto 設定
- `CHANGELOG.md`: `cog changelog` の出力先

`dot_`, `private_`, `dot_config/` などの名前は `chezmoi` の命名規則です。

## 前提

- Git
- `chezmoi`

## chezmoi のインストール

### macOS

```bash
brew install chezmoi
```

### Arch Linux

```bash
sudo pacman -S chezmoi
```

### Debian / Ubuntu

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
```

必要なら `~/.local/bin` を `PATH` に追加してください。

## GitHub から導入する

`YOUR_GITHUB_NAME` を自分の GitHub ユーザー名または `owner/repo` に置き換えてください。

```bash
chezmoi init --apply YOUR_GITHUB_NAME
```

リポジトリ名を明示したい場合:

```bash
chezmoi init --apply https://github.com/YOUR_GITHUB_NAME/dotfiles.git
```

反映前に差分だけ確認する場合:

```bash
chezmoi init YOUR_GITHUB_NAME
chezmoi diff
chezmoi apply
```

更新を取り込む場合:

```bash
chezmoi update
```

## 含めてあるツール設定

- shell: `zsh`, `fish`, `atuin`, `starship`, `mise`
- terminal / multiplexer: `ghostty`, `zellij`
- file manager: `yazi`, Nautilus script
- dev tools: `lazygit`, `topgrade`
- desktop / input: `mozc`
- gaming overlay: `MangoHud`

必要に応じて `chezmoi edit <path>` でローカル調整してください。

## このリポジトリを育てる手順

既存の設定ファイルを `chezmoi` 管理下へ取り込む例:

```bash
chezmoi add ~/.zshrc
chezmoi add ~/.config/fish/config.fish
chezmoi add ~/.gitconfig
chezmoi add ~/.config/git/ignore
chezmoi add ~/.config/ghostty/config.ghostty
chezmoi add ~/.config/yazi/yazi.toml
chezmoi add ~/.config/zellij/config.kdl
```

変更後は通常の Git ワークフローでコミットして GitHub へ push します。

```bash
git add .
git commit -m "Initial dotfiles"
git push -u origin main
```

## テンプレートについて

`dot_gitconfig.tmpl` は `chezmoi` テンプレートです。環境ごとに値を変えたい場合は `chezmoi data` や `if eq .chezmoi.os` などを使えます。

例:

```tmpl
{{ if eq .chezmoi.os "linux" }}
[core]
	editor = nvim
{{ end }}
```

## Cocogitto

このリポジトリには `cog.toml` を入れてあるので、Conventional Commits で運用すると `CHANGELOG.md` を生成できます。

```bash
cog check
cog changelog
```

まだコミットが 1 つもない空リポジトリでは changelog は生成されません。最初の Conventional Commit を作ってから実行してください。

タグ込みで運用する場合は:

```bash
git tag 0.1.0
cog changelog
```
