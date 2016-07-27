(require-package 'mmm-mode)

(require 'mmm-auto)
(setq mmm-global-mode 'maybe)

(mmm-add-classes
 '((markdown-php
    :submode php-mode
    :face mmm-declaration-submode-face
    :front "^```php[\n\r]+"
    :back "^```$")))

(mmm-add-mode-ext-class 'markdown-mode nil 'markdown-php)

(provide 'init-mmm)
