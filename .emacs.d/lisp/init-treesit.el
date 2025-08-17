;; -*- lexical-binding: t no-byte-compile: t -*-

(use-package treesit
  :ensure nil
  :config
  (setq treesit-auto-install 'prompt)
  (setq treesit-font-lock-level 4)
  :init
  (setq treesit-language-source-alist
	'((elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
	  (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
	  (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))))
  (setq major-mode-remap-alist '((c++-mode . c++-ts-mode)
				 (c-mode . c-ts-mode)
				 (python-mode . python-ts-mode)))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode)))



(provide 'init-treesit)
