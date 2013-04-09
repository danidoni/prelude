;; IDO config
;; Display completions vertically
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched" " [Not readable]" " [Too big]" " [Confirm]")))

;; Use C-p and C-n to scroll up and down
(defun ido-define-keys ()
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;; Fuzzy matching
(setq ido-enable-flex-matching t)
