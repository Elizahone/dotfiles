  (use-package rime
    :defer t
    :ensure t
    :config
    (setq rime-disable-predicates
          '(rime-predicate-current-uppercase-letter-p)) ;; normal 模式自动进入临时英文模式
    (setq rime-user-data-dir "~/.local/share/fcitx5/rime")
    :custom
    (default-input-method "rime"))


(provide 'init-rime)
