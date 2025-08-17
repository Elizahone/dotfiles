;; -*- lexical-binding: t no-byte-compile: t -*-


;; for more details : https://github.com/renzmann/treesit-auto


(use-package treesit
  :ensure nil
  :config
  (setq treesit-auto-install 'prompt)
  (setq treesit-font-lock-level 4)
  :init
  (setq treesit-language-source-alist
      '((awk        . ("https://github.com/Beaglefoot/tree-sitter-awk"))
        (bash       . ("https://github.com/tree-sitter/tree-sitter-bash"))
        (bibtex     . ("https://github.com/latex-lsp/tree-sitter-bibtex"))
        (blueprint  . ("https://github.com/huanie/tree-sitter-blueprint"))
        (c          . ("https://github.com/tree-sitter/tree-sitter-c"))
        (c-sharp    . ("https://github.com/tree-sitter/tree-sitter-c-sharp"))
        (clojure    . ("https://github.com/sogaiu/tree-sitter-clojure"))
        (cmake      . ("https://github.com/uyha/tree-sitter-cmake"))
        (commonlisp . ("https://github.com/tree-sitter-grammars/tree-sitter-commonlisp"))
        (cpp        . ("https://github.com/tree-sitter/tree-sitter-cpp"))
        (css        . ("https://github.com/tree-sitter/tree-sitter-css"))
        (dart       . ("https://github.com/ast-grep/tree-sitter-dart"))
        (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
        (elixir     . ("https://github.com/elixir-lang/tree-sitter-elixir"))
        (glsl       . ("https://github.com/tree-sitter-grammars/tree-sitter-glsl"))
        (go         . ("https://github.com/tree-sitter/tree-sitter-go"))
        (gomod      . ("https://github.com/camdencheek/tree-sitter-go-mod"))
        (heex       . ("https://github.com/phoenixframework/tree-sitter-heex"))
        (html       . ("https://github.com/tree-sitter/tree-sitter-html"))
        (java       . ("https://github.com/tree-sitter/tree-sitter-java"))
        (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
        (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
        (julia      . ("https://github.com/tree-sitter/tree-sitter-julia"))
        (kotlin     . ("https://github.com/fwcd/tree-sitter-kotlin"))
        (latex      . ("https://github.com/latex-lsp/tree-sitter-latex"))
        (lua        . ("https://github.com/tree-sitter-grammars/tree-sitter-lua"))
        (make       . ("https://github.com/tree-sitter-grammars/tree-sitter-make"))
        (markdown   . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown"))
        (nix        . ("https://github.com/nix-community/tree-sitter-nix"))
        (org        . ("https://github.com/milisims/tree-sitter-org"))
        (python     . ("https://github.com/tree-sitter/tree-sitter-python"))
        (ruby       . ("https://github.com/tree-sitter/tree-sitter-ruby"))
        (rust       . ("https://github.com/tree-sitter/tree-sitter-rust"))
        (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))
        (tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
        (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
        (yaml       . ("https://github.com/tree-sitter-grammars/tree-sitter-yaml"))
        (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
        (toml       . ("https://github.com/tree-sitter/tree-sitter-toml"))))
  (setq major-mode-remap-alist '((c++-mode . c++-ts-mode)
				 (c-mode . c-ts-mode)
				 (python-mode . python-ts-mode)))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode)))



(provide 'init-treesit)
