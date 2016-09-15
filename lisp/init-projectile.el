(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-global-mode)

  ;; Shorter modeline
  (after-load 'projectile
    (setq-default
     projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Pr"
         (format " Pr[%s]" (projectile-project-name)))))))

(require-package 'helm-projectile)

(global-set-key (kbd "M-p") 'helm-projectile)
(global-set-key (kbd "M-P") 'helm-projectile-find-file-dwim)

(provide 'init-projectile)
