;; -*- lexical-binding: t no-byte-compile: t -*-

;; --------------------------------------------------------------------------------
;; org-mode
;; --------------------------------------------------------------------------------
(require 'org-tempo) ;; 增加模板

(use-package org
  :ensure nil
  :hook
  (org-mode-hook . yas-minor-mode)
  :init
  (add-hook 'org-mode-hook 'org-appear-mode)
  :config
  (setq org-image-actual-width nil))
(use-package org-modern
  :ensure t
  :custom
  (org-modern-star 'replace)
  :init
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'org-modern-mode)
  :config
  (setq org-hide-emphasis-markers t))

;; (use-package ob-R)
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((R . t)))

;; --------------------------------------------------------------------------------
;; org prettify
;; --------------------------------------------------------------------------------
(use-package org-appear
  :config
  (setq org-appear-autolinks t) ;; auto expand links
  (setq org-appear-autoentities t)
  (setq org-appear-autokeywords t)
  (setq org-appear-inside-latex t)
  (setq org-appear-autosubmarkers t)
  (setq org-appear-delay 0.3))


(use-package org-modern
  :ensure t
  :custom
  (org-modern-star 'replace)
  :init
  (add-hook 'org-mode-hook #'org-indent-mode)
  :config
  (with-eval-after-load 'org (global-org-modern-mode))
  (setq org-hide-emphasis-markers t))

;; org-mode 可以像markdown一样内嵌latex代码，使用 =org-latex-preview= (C-c C-x C-l) 即可打开预览，默认生成图片格式，路径在当前目录，可以更改路径 （customize-group org-latex）
;; 需要依赖系统的Tex环境，安装TexLive dvipng 或 dvisvg

;; _fragtog_ 可以如同org-appear一样


(use-package org-fragtog
  :config
  (setq org-latex-preview-ltxpng-directory "/tmp/ltximg"))

(provide 'init-orgmode)
