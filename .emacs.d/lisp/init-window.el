;; -*- lexical-binding: t no-byte-compile: t -*-

;; --------------------------------------------------------------------------------
;; popper POP Window
;; --------------------------------------------------------------------------------


(use-package popper
   :defines popper-echo-dispatch-actions
   :commands popper-group-by-directory
   :bind (:map popper-mode-map
               ("C-`" . popper-toggle)
               ("s-o"   . popper-cycle)
               ("M-`" . popper-toggle-type))
   :hook (emacs-startup . popper-mode)
   :init
   (setq popper-reference-buffers
         '("\\*Messages\\*"
           "Output\\*$" "\\*Pp Eval Output\\*$"
           "\\*Compile-Log\\*"
           "\\*Completions\\*"
           "\\*Warnings\\*"
           "\\*Flymake diagnostics.*\\*"
           "\\*Async Shell Command\\*"
           "\\*Apropos\\*"
           "\\*Backtrace\\*"
           "\\*prodigy\\*"
           "\\*Calendar\\*"
           "\\*Embark Actions\\*"
           "\\*Finder\\*"
           "\\*Kill Ring\\*"
           "\\*Embark Export:.*\\*"
           "\\*Edit Annotation.*\\*"
           "\\*Flutter\\*"
           bookmark-bmenu-mode
           lsp-bridge-ref-mode
           comint-mode
           compilation-mode
           help-mode helpful-mode
           tabulated-list-mode
           Buffer-menu-mode
           occur-mode
           gnus-article-mode devdocs-mode
           grep-mode occur-mode rg-mode deadgrep-mode ag-mode pt-mode
           ivy-occur-mode ivy-occur-grep-mode
           process-menu-mode list-environment-mode cargo-process-mode
           youdao-dictionary-mode osx-dictionary-mode fanyi-mode

           "^\\*eshell.*\\*.*$" eshell-mode
           "^\\*shell.*\\*.*$"  shell-mode
           "^\\*terminal.*\\*.*$" term-mode
           "^\\*vterm.*\\*.*$"  vterm-mode
           "^\\*R.*\\*.*$"  ess-R-mode


           "\\*DAP Templates\\*$" dap-server-log-mode
           "\\*ELP Profiling Restuls\\*" profiler-report-mode
           "\\*Flycheck errors\\*$" " \\*Flycheck checker\\*$"
           "\\*Paradox Report\\*$" "\\*package update results\\*$" "\\*Package-Lint\\*$"
           "\\*[Wo]*Man.*\\*$"
           "\\*ert\\*$" overseer-buffer-mode
           "\\*gud-debug\\*$"
           "\\*lsp-help\\*$" "\\*lsp session\\*$"
           "\\*quickrun\\*$"
           "\\*tldr\\*$"
           "\\*vc-.*\\*$"
           "\\*eldoc\\*"
           "^\\*elfeed-entry\\*$"
           "^\\*macro expansion\\**"

           "\\*Agenda Commands\\*" "\\*Org Select\\*" "\\*Capture\\*" "^CAPTURE-.*\\.org*"
           "\\*Gofmt Errors\\*$" "\\*Go Test\\*$" godoc-mode
           "\\*docker-containers\\*" "\\*docker-images\\*" "\\*docker-networks\\*" "\\*docker-volumes\\*"
           "\\*prolog\\*" inferior-python-mode inf-ruby-mode swift-repl-mode
           "\\*rustfmt\\*$" rustic-compilation-mode rustic-cargo-clippy-mode
           rustic-cargo-outdated-mode rustic-cargo-test-mode))

   ;; (when (display-grayscale-p)
   ;;   (setq popper-mode-line
   ;;         '(:eval
   ;;           (concat
   ;;            (propertize " " 'face 'mode-line-emphasis)
   ;;            'mode-line-emphasis)
   ;;            (propertize " " 'face 'mode-line-emphasis))))

   (setq popper-echo-dispatch-actions t)
   (setq popper-group-function nil)
   :config
   (popper-echo-mode 1)

   (with-no-warnings
     (defun my-popper-fit-window-height (win)
       "Determine the height of popup window WIN by fitting it to the buffer's content."
       (fit-window-to-buffer
        win
        (floor (frame-height) 3)
        (floor (frame-height) 3)))
     (setq popper-window-height #'my-popper-fit-window-height)

     (defun popper-close-window-hack (&rest _)
       "Close popper window via `C-g'."
       ;; `C-g' can deactivate region
       (when (and (called-interactively-p 'interactive)
                  (not (region-active-p))
                  popper-open-popup-alist)
         (let ((window (caar popper-open-popup-alist)))
           (when (window-live-p window)
             (delete-window window)))))
     (advice-add #'keyboard-quit :before #'popper-close-window-hack)))


(use-package ace-window
  :bind ("M-o" . ace-window))


(provide 'init-window)
