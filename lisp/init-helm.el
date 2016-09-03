(require-package 'helm)
(helm-mode 1)

(setq helm-buffers-fuzzy-matching t
      helm-M-x-fuzzy-match t
      helm-autoresize-mode t
      helm-buffer-max-length 40)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level)

;; Make easy to call helm-buffers-list
(global-set-key (kbd "M-b") 'helm-mini)
(defalias 'list-buffers 'helm-mini)	; make helm-buffers-list default

(provide 'init-helm)
