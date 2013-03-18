(require 'helm-files)
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0.1)
;; (setq helm-c-locate-command "locate-with-mdfind %.0s %s")
(loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
      do (add-to-list 'helm-c-boring-file-regexp-list ext))
; (global-set-key (kbd "C-c C-o") 'helm-for-files)

(add-to-list 'load-path "~/.emacs.d/personal/helm-cmd-t/")
(require 'helm-config)
(require 'helm-cmd-t)
(setq helm-cmd-t-repo-types '(("dir-locals" ".dir-locals.el" helm-cmd-t-get-find)
                              ;("git" ".git" "cd %d && git --no-pager ls-files --full-name")
                              ("" "" helm-cmd-t-get-find)))
(global-set-key (kbd "C-c C-o") 'helm-cmd-t)

;; Selection face customization
(custom-set-faces
 '(helm-selection ((t (:background "gold" :underline nil :foreground "black")))))
