.PHONY: help brew-export brew-install brew-cleanup-dry brew-cleanup

help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

brew-export: ## Export currently installed brew packages to Brewfile
	@echo "Exporting installed packages to Brewfile..."
	@brew bundle dump --all --describe --force
	@echo "✓ Brewfile updated successfully"

brew-install: ## Install packages from Brewfile
	@echo "Installing packages from Brewfile..."
	@brew bundle install
	@echo "✓ Packages installed successfully"

brew-cleanup-dry: ## Dry run: show packages that would be uninstalled (not in Brewfile)
	@echo "Checking for packages not in Brewfile (dry run)..."
	@brew bundle cleanup

brew-cleanup: ## Uninstall packages not in Brewfile
	@echo "⚠️  WARNING: This will uninstall packages not in Brewfile"
	@echo "Press Ctrl+C to cancel, or Enter to continue..."
	@read _
	@echo "Cleaning up packages not in Brewfile..."
	@brew bundle cleanup --force
	@echo "✓ Cleanup completed"
