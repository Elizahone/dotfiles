;; -*- lexical-binding: t no-byte-compile: t -*-

;; --------------------------------------------------------------------------------
;; Speed up startup.
;;---------------------------------------------------------------------------------

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)

;; Prevent flashing of unstyled modeline at startup
;; (setq-default mode-line-format nil)

;; Don't pass case-insensitive to `auto-mode-alist'
(setq auto-mode-case-fold nil)

(unless (or (daemonp) noninteractive init-file-debug)
  ;; Suppress file handlers operations at startup
  ;; `file-name-handler-alist' is consulted on each call to `require' and `load'
  (let ((old-value file-name-handler-alist))
    (setq file-name-handler-alist nil)
    (set-default-toplevel-value 'file-name-handler-alist file-name-handler-alist)
    (add-hook 'emacs-startup-hook
              (lambda ()
                "Recover file name handlers."
                (setq file-name-handler-alist
                      (delete-dups (append file-name-handler-alist old-value))))
              101)))
;; --------------------------------------------------------------------------------
;; load custom file in external file.
;; --------------------------------------------------------------------------------
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))

(load custom-file 'no-error 'no-message)

;; --------------------------------------------------------------------------------
;; require other module files
;; --------------------------------------------------------------------------------

;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'.

Don't put large files in `site-lisp' directory, e.g. EAF.
Otherwise the startup will be very slow."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
;; (advice-add #'package-initialize :after #'add-subdirs-to-load-path)
(update-load-path)



(require 'init-package)

(require 'init-completion)

(require 'init-base)

(require 'init-orgmode)

(require 'init-appearance)

(require 'init-treesit)

(require 'init-edit)

(require 'init-window)

(require 'init-rime)

(require 'init-vterm)
