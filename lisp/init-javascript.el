(maybe-require-package 'json-mode)
(maybe-require-package 'js2-mode)

(defcustom preferred-javascript-mode
  (first (remove-if-not #'fboundp '(js2-mode js-mode)))
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js2-mode js-mode))

(defconst preferred-javascript-indent-level 2)

;; Need to first remove from list if present, since elpa adds entries too, which
;; may be in an arbitrary order
(eval-when-compile (require 'cl))
(setq auto-mode-alist (cons `("\\.\\(js\\|es6\\)\\(\\.erb\\)?\\'" . ,preferred-javascript-mode)
                            (loop for entry in auto-mode-alist
                                  unless (eq preferred-javascript-mode (cdr entry))
                                  collect entry)))

;; js2-mode

;; Change some defaults: customize them to override
(setq-default js2-basic-offset 2
              js2-bounce-indent-p nil)

(after-load 'js2-mode
  ;; Disable js2 mode's syntax error highlighting by default...
  ;; (setq-default js2-mode-show-parse-errors nil
  ;;               js2-mode-show-strict-warnings nil)

  ;; ... but enable it if flycheck can't handle javascript
  ;; (autoload 'flycheck-get-checker-for-buffer "flycheck")

  (defun sanityinc/disable-js2-checks-if-flycheck-active ()
    (unless (flycheck-get-checker-for-buffer)
      (set (make-local-variable 'js2-mode-show-parse-errors) t)
      (set (make-local-variable 'js2-mode-show-strict-warnings) t)))
  (add-hook 'js2-mode-hook 'sanityinc/disable-js2-checks-if-flycheck-active)

  (add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2"))))

;; js-mode
(setq-default js-indent-level preferred-javascript-indent-level)

(add-to-list 'interpreter-mode-alist (cons "node" preferred-javascript-mode))

(defun rzani/js2-config()
  "Configure js2-mode-hook"
  (linum-mode)
  (smartparens-mode))

(add-hook 'js2-mode-hook 'rzani/js2-config)
(dolist (hook '(js2-mode-hook js-mode-hook json-mode-hook)) (add-hook hook 'rainbow-delimiters-mode))

;; ---------------------------------------------------------------------------
;; Alternatively, use skewer-mode
;; ---------------------------------------------------------------------------
(when (maybe-require-package 'skewer-mode)
  (after-load 'skewer-mode
    (add-hook 'skewer-mode-hook
              (lambda () (inferior-js-keys-mode -1)))))


(provide 'init-javascript)
