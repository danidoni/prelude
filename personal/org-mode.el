;;; --------
;;; ORG MODE
;;; --------
(require 'org)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key mode-specific-map [?a] 'org-agenda)

(eval-after-load "org-agenda"
  '(progn
     (define-prefix-command 'org-todo-state-map)

     (define-key org-mode-map "\C-cx" 'org-todo-state-map)

     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "m"
       #'(lambda nil (interactive) (org-todo "MAYBE")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "SOON")))
     (define-key org-todo-state-map "n"
       #'(lambda nil (interactive) (org-todo "NEXT")))
     (define-key org-todo-state-map "i"
       #'(lambda nil (interactive) (org-todo "IN-PROGRESS")))
     (define-key org-todo-state-map "t"
       #'(lambda nil (interactive) (org-todo "TODO")))

     (define-key org-agenda-mode-map "\C-n" 'next-line)
     (define-key org-agenda-keymap "\C-n" 'next-line)
     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     (define-key org-agenda-keymap "\C-p" 'previous-line)))

(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control meta ?r)] 'remember)

(custom-set-variables
 '(org-agenda-files (file-expand-wildcards "~/Dropbox/Org/*.org"))
 '(org-default-notes-file "~/Dropbox/Org/refile.org")

 ;; Refiling config
 '(org-refile-targets (quote ((nil :maxlevel . 9)
                              (org-agenda-files :maxlevel . 9))))
 '(org-refile-use-outline-path nil)
 '(org-outline-path-complete-in-steps nil)
 '(org-clock-out-remove-zero-time-clocks t)
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-todo-keywords '((sequence "TODO" "SOMEDAY" "SOON" "NEXT" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELLED" "DEFERRED" "DELEGATED")))
 '(org-todo-keyword-faces
       '(("NEXT" . (:foreground "red" :weight bold))
         ("SOON" . (:foreground "orange" :weight bold))
         ("SOMEDAY" . (:foreground "yellow" :weight bold))
         ))
 '(org-agenda-clocking ((t (:background "yellow green" :foreground "black"))) t)
 '(org-clock-report-include-clocking-task t)
 ;; Prevents tasks from changing to DONE if any subtasks are still open
 '(org-agenda-clockreport-parameter-plist (quote (:maxlevel 3 :scope file :fileskip0 t :narrow 120!)))
 '(org-enforce-todo-dependencies t)
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
           ("c" todo "DONE|DEFERRED|CANCELLED" nil)
           ("t" todo "TODO" nil)
           ("n" "Next tasks and agenda"
            ((agenda "")
             (todo "NEXT|IN-PROGRESS|DELEGATED")
             (todo "SOON")
             (todo "SOMEDAY")))
           ("s" todo "SOON" nil)
           ("S" todo "SOMEDAY" nil)
           ("r" agenda ""
            ((org-agenda-ndays 1)
             (org-agenda-start-with-log-mode t)
             (org-agenda-start-with-clockreport-mode t)))
           ("W" agenda "" ((org-agenda-ndays 21)))
           ("u" alltodo ""
            ((org-agenda-skip-function
              (lambda nil
                (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                          (quote regexp) "\n]+>")))
             (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   (quote ((116 "* TODO %?\n  %u" "~/Dropbox/Org/refile.org" "Tasks"))))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler))))

(global-set-key (kbd "C-M-r") 'org-remember)
