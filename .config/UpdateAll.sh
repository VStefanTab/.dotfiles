#!/bin/bash

set -e # Exit immediately if a command fails

DOTFILES_DIR="$HOME/personal/dotfiles"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$DOTFILES_DIR/backup"
EXCLUDE_FILE="$DOTFILES_DIR/.backupignore" # File to list exclusions

#TODO: Delete backup files older than 5 days
deleteOldBackups() {
  echo "Deleting backups older than 5 days..."
  find "$BACKUP_DIR" -mindepth 1 -mtime +5 -exec rm -r "{}" \;
}

updateI3() {
  #i3 config file
  local I3Config="$CONFIG_DIR/i3"
  rsync -av --update "$I3Config/config" "$DOTFILES_DIR/i3/i3config"

  #i3 status bar config file
  local I3StatusBarConf="/etc/i3status.conf"
  rsync -av --update "$I3StatusBarConf" "$DOTFILES_DIR/i3/i3satusBar.conf"
}

updateKitty() {
  local KittyConfig="$CONFIG_DIR/kitty"
  rsync -av --update "$KittyConfig/kitty.conf" "$DOTFILES_DIR/kity/kitty.conf"
  rsync -av --update "$KittyConfig/theme.conf" "$DOTFILES_DIR/kity/theme.conf"
}

updateSourceList() {
  local SourceList="/etc/apt/"
  rsync -av --update "$SourceList/sources.list" "$DOTFILES_DIR/sources.list.dup"
}

updateTmuxConf() {
  rsync -av --update "$HOME/.tmux.conf" "$DOTFILES_DIR/tmuxConf/tmux.conf"
}

updateClangFormat() {
  rsync -av --update "$HOME/.clang-format" "$DOTFILES_DIR/.clang-format"
}

updateZshConfig() {
  rsync -av --update "$HOME/.zshrc" "$DOTFILES_DIR/.zshrc"
}

updateStarShip() {
  rsync -av --update "$HOME/.config/starship.toml" "$DOTFILES_DIR/starshipConf.toml"
}

BackUp() {
  local timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
  local backup_target="$BACKUP_DIR/backup_$timestamp"
  mkdir -p "$backup_target"

  # Exclude UpdateAll and any other files listed in .backupignore
  if [ -f "$EXCLUDE_FILE" ]; then
    rsync -av --exclude='UpdateAll' --exclude-from="$EXCLUDE_FILE" "$DOTFILES_DIR/" "$backup_target/"
  else
    rsync -av --exclude='UpdateAll' "$DOTFILES_DIR/" "$backup_target/"
  fi

  echo "Backup completed at $backup_target"
}

echo "Status before updating..."
git status
git diff

BackUp

if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles..."

  update_functions=("updateI3" "updateKitty" "updateSourceList" "updateTmuxConf" "updateClangFormat" "updateZshConfig" "updateStarShip")

  for func in "${update_functions[@]}"; do
    echo "Running $func..."
    $func
  done

else
  echo "The Directory $DOTFILES_DIR does not exist"
fi

#deleteOldBackups

echo "Status after updating..."
git status
git diff
