;; -*- lexical-binding: t no-byte-compile: t -*-

(fset 'yes-or-no-p 'y-or-n-p)
;; 关闭自动保存 #
(setq auto-save-default nil)
;; 关闭备份 ~
(setq  make-backup-files nil)
;; 换行的自动缩进
;; (setq electric-indent-mode nil)
(setq default-frame-alist '((undecorated . t)))

;; --------------------------------------------------------------------------------
;;
;; --------------------------------------------------------------------------------
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))
(use-package autorevert
  :ensure nil
  :diminish
  :hook (after-init . global-auto-revert-mode))

;; --------------------------------------------------------------------------------
;;
;; --------------------------------------------------------------------------------

(use-package simple
  :ensure nil
  :hook ((after-init . size-indication-mode)
         (text-mode . visual-line-mode))
  :init
  (setq column-number-mode t
        line-number-mode t
        ;; kill-whole-line t               ; Kill line including '\n'
        line-move-visual nil
        track-eol t                     ; Keep cursor at end of lines. Require line-move-visual is nil.
        set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again

  ;; Visualize TAB, (HARD) SPACE, NEWLINE
  (setq-default show-trailing-whitespace nil) ; Don't show trailing whitespace by default
  (defun enable-trailing-whitespace ()
    "Show trailing spaces and delete on saving."
    (setq show-trailing-whitespace t)
    (add-hook 'before-save-hook #'delete-trailing-whitespace nil t))

  ;; Prettify the process list
  (with-no-warnings
    (defun my-list-processes--prettify ()
      "Prettify process list."
      (when-let* ((entries tabulated-list-entries))
        (setq tabulated-list-entries nil)
        (dolist (p (process-list))
          (when-let* ((val (cadr (assoc p entries)))
                      (name (aref val 0))
                      (pid (aref val 1))
                      (status (aref val 2))
                      (status (list status
                                    'face
                                    (if (memq status '(stop exit closed failed))
                                        'error
                                      'success)))
                      (buf-label (aref val 3))
                      (tty (list (aref val 4) 'face 'font-lock-doc-face))
                      (thread (list (aref val 5) 'face 'font-lock-doc-face))
                      (cmd (list (aref val 6) 'face 'completions-annotations)))
            (push (list p (vector name pid status buf-label tty thread cmd))
                  tabulated-list-entries)))))
    (advice-add #'list-processes--refresh :after #'my-list-processes--prettify)))


(use-package exec-path-from-shell
  :ensure t)

;; [[https://www.emacswiki.org/emacs/CopyAndPaste][Copy and Paste]] : Although Emacs 29 has an option to build with pure GTK and therefore is supposed to support Wayland clipboard natively, that support does not work if emacs is run in a tty, or when run inside multiple displays. For that to work,
;; the wl-clipboard program is needed (you need to install =wl-clipboard= first):

(when 'pgtk-initialized
  (setq wl-copy-process nil)
  (defun wl-copy (text)
    (setq wl-copy-process (make-process :name "wl-copy"
                                        :buffer nil
                                        :command '("wl-copy" "-f" "-n")
                                        :connection-type 'pipe
                                        :noquery t))
    (process-send-string wl-copy-process text)
    (process-send-eof wl-copy-process))
  (defun wl-paste ()
    (if (and wl-copy-process (process-live-p wl-copy-process))
        nil ; should return nil if we're the current paste owner
      (shell-command-to-string "wl-paste -n | tr -d \r")))
  (setq interprogram-cut-function 'wl-copy)
  (setq interprogram-paste-function 'wl-paste))


;; --------------------------------------------------------------------------------
;; open config files quickly
;; --------------------------------------------------------------------------------

(defun elzh/open-config-directory ()
  (interactive)
  (let ((default-directory "~/.emacs.d/lisp/"))
    (call-interactively #'find-file)))

(provide 'init-base)
