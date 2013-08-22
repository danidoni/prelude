(add-to-list 'load-path "~/.emacs.d/personal/helm-cmd-t/")
(require 'helm-config)
(require 'helm-cmd-t)
(global-set-key (kbd "C-c C-p") 'helm-cmd-t)
(global-set-key (kbd "C-c C-r") 'helm-recentf)
;; Selection face customization
(custom-set-faces
 '(helm-selection ((t (:background "gold" :underline nil :foreground "black")))))
(setq helm-cmd-t-cache-threshold nil)
