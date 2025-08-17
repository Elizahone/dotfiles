;; -*- lexical-binding: t no-byte-compile: t -*-


;; --------------------------------------------------------------------------------
;; fonts & misc
;; --------------------------------------------------------------------------------

(global-hl-line-mode 1)

(global-display-line-numbers-mode 1)

(set-face-attribute 'default nil :font (font-spec :family "Source Code Pro" :size 20))
  ;; 修改中文字体  设置 :size 值就无法调整大小
(set-fontset-font "fontset-default" 'unicode (font-spec :family "LXGW WenKai Mono GB Screen") nil 'prepend)

;; --------------------------------------------------------------------------------
;; theme
;; --------------------------------------------------------------------------------
(use-package ef-themes
  :init (load-theme 'ef-elea-dark :no-confirm)
  :config
  (setq ef-themes-to-toggle '(ef-elea-dark ef-spring)))
(use-package all-the-icons
  :if (display-graphic-p)) ;; 第一次运行时, M-x all-the-icon-install-fonts 安装字体.

(use-package all-the-icons-nerd-fonts)

;; --------------------------------------------------------------------------------
;; indent-bar
;; --------------------------------------------------------------------------------


(use-package indent-bars
  :custom
  (indent-bars-no-descend-string t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  (indent-bars-prefer-character t)
  (indent-bars-treesit-scope '((python function_definition class_definition for_statement
				       if_statement with_statement while_statement)))
  :hook ((prog-mode yaml-mode) . indent-bars-mode)
  :config (require 'indent-bars-ts))


;; --------------------------------------------------------------------------------
;; doom-modeline
;; --------------------------------------------------------------------------------

;; (use-package minions
;;   :defer t
;;   :hook doom-modeline-mode)
;; (use-package doom-modeline
;;   :hook (after-init . doom-modeline-mode)
;;   :custom
;;   (doom-modeline-unicode-fallback t)
;;   :config
;;   (setq doom-modeline-height 1) ; optional
;;   (custom-set-faces
;;    '(mode-line ((t (:height 1.2))))
;;    '(mode-line-active ((t (:height 0.85)))) ; For 29+
;;    '(mode-line-inactive ((t (:height 0.85))))))


(provide 'init-appearance)
