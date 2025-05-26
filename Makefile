.PHONY: link, unlink, help

link:
	@echo "🔗 Linking 'setup' to $(HOME)/.config/nvim..."
	@stow -t ~/.config/nvim setup

unlink:
	@echo "❌ Unlinking 'setup' from $(HOME)/.config/nvim..."
	@stow -D -t ~/.config/nvim setup

help:
	@echo "📦 Usage:"
	@echo "  make link    - Symlink 'setup' to ~/.config/nvim using stow"
	@echo "  make unlink  - Remove symlink from ~/.config/nvim using stow --delete"
