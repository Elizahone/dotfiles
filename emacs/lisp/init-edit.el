;; -*- lexical-binding: t no-byte-compile: t -*-

(delete-selection-mode t)

;; --------------------------------------------------------------------------------
;; expand-region
;; --------------------------------------------------------------------------------

(use-package expand-region
  :bind ("C-=" . er/expand-region)
  :config
  (when (treesit-available-p)
    (defun treesit-mark-bigger-node ()
      "Use tree-sitter to mark regions."
      (let* ((root (treesit-buffer-root-node))
             (node (treesit-node-descendant-for-range root (region-beginning) (region-end)))
             (node-start (treesit-node-start node))
             (node-end (treesit-node-end node)))
        ;; Node fits the region exactly. Try its parent node instead.
        (when (and (= (region-beginning) node-start) (= (region-end) node-end))
          (when-let* ((node (treesit-node-parent node)))
            (setq node-start (treesit-node-start node)
                  node-end (treesit-node-end node))))
        (set-mark node-end)
        (goto-char node-start)))
    (add-to-list 'er/try-expand-list 'treesit-mark-bigger-node)))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



(provide 'init-edit)
