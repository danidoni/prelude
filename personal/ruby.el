;; Do not set file coding header automatically
(setq ruby-insert-encoding-magic-comment nil)

(defun my-ruby-mode-hooks ()
  (linum-mode)
  (local-set-key (kbd "C-c C-c") 'comment-or-uncomment-region))

(add-hook 'ruby-mode-hook
          (lambda ()
            (my-ruby-mode-hooks)))
