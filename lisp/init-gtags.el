(require-package 'helm-gtags)

(setq helm-gtags-fuzzy-match t)

(when (and (maybe-require-package 'gtags)
           (maybe-require-package 'bpr))
  ;; Bind some useful keys in the gtags select buffer that evil overrides.
  (add-hook 'gtags-select-mode-hook
            (lambda ()
              (evil-define-key 'normal gtags-select-mode-map (kbd "RET") 'gtags-select-tag)
              (evil-define-key 'normal gtags-select-mode-map (kbd "q") 'kill-buffer-and-window)))

  (defun gtags-reindex ()
    "Kick off gtags reindexing."
    (interactive)
    (let* ((root-path (expand-file-name (vc-git-root (buffer-file-name))))
           (gtags-filename (expand-file-name "GTAGS" root-path)))
      (if (file-exists-p gtags-filename)
          (gtags-index-update root-path)
        (gtags-index-initial root-path))))

  (defun gtags-index-initial (path)
    "Generate initial GTAGS files for PATH."
    (let ((bpr-process-directory path))
      (bpr-spawn "gtags -v")))

  (defun gtags-index-update (path)
    "Update GTAGS in PATH."
    (let ((bpr-process-directory path))
      (bpr-spawn "global -uv"))))

(when (memq window-system '(mac ns))
  (progn
    (require-package 'exec-path-from-shell)
    (exec-path-from-shell-initialize)))

(provide 'init-gtags)
;;; init-gtags.el ends here
