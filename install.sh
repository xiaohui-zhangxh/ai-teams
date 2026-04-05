#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$(cd "$(dirname "$0")" && pwd)/bin"
EXPORT_LINE="export PATH=\"$BIN_DIR:\$PATH\""

detect_shell_config() {
  local shell_name
  shell_name="$(basename "$SHELL")"
  case "$shell_name" in
    zsh)  echo "$HOME/.zshrc" ;;
    bash)
      if [[ -f "$HOME/.bash_profile" ]]; then
        echo "$HOME/.bash_profile"
      else
        echo "$HOME/.bashrc"
      fi
      ;;
    fish) echo "$HOME/.config/fish/config.fish" ;;
    *)    echo "$HOME/.profile" ;;
  esac
}

SHELL_CONFIG="$(detect_shell_config)"

if grep -qF "$BIN_DIR" "$SHELL_CONFIG" 2>/dev/null; then
  echo "✓ PATH 已配置，无需重复安装"
else
  echo "$EXPORT_LINE" >> "$SHELL_CONFIG"
  echo "✓ 已将 $BIN_DIR 添加到 $SHELL_CONFIG"
fi

echo ""
echo "请执行以下命令使配置生效："
echo ""
echo "  source $SHELL_CONFIG"
echo ""
echo "之后即可直接使用选择器，例如："
echo ""
echo "  cursor-agent-as"
