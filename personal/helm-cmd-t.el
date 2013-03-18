(add-to-list 'load-path "~/.emacs.d/personal/helm-cmd-t/")
(require 'helm-config)
(require 'helm-cmd-t)
(global-set-key (kbd "C-c C-o") 'helm-cmd-t)
