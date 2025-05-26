.PHONY: link, unlink

link:
	@stow -t ~/.config/nvim setup

unlink:
	@stow -D -t ~/.config/nvim setup
