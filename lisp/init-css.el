;;; Colourise CSS colour literals
(when (maybe-require-package 'rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
    (add-hook hook 'rainbow-mode)))

;;; SASS and SCSS
(require-package 'sass-mode)
(require-package 'scss-mode)
(setq-default scss-compile-at-save nil)

;;; LESS
(require-package 'less-css-mode)
(when (featurep 'js2-mode)
  (require-package 'skewer-less))

;;; Use eldoc for syntax hints
(require-package 'css-eldoc)
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

(provide 'init-css)
