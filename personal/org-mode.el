;;; --------
;;; ORG MODE
;;; --------
(require 'org)

;; Prevents tasks from changing to DONE if any subtasks are still open
(setq org-enforce-todo-dependencies t)

;; Org mode
                                        ; Configure agenda files
(setq org-directory "~/Dropbox/Org")

(defun agenda-files-in-org-directory ()
  (file-expand-wildcards (concat org-directory "/*.org")))

(setq org-agenda-files (quote ("~/Dropbox/Org/casaasia.org"
                               "~/Dropbox/Org/fcb.org"
                               "~/Dropbox/Org/icv.org"
                               "~/Dropbox/Org/manteniments.org"
                               "~/Dropbox/Org/minoria.org"
                               "~/Dropbox/Org/netip.org"
                               "~/Dropbox/Org/plataforma.org"
                               "~/Dropbox/Org/redmine.org"
                               "~/Dropbox/Org/sportsemotions-web.org"
                               "~/Dropbox/Org/pluginitzacio.org"
                               "~/Dropbox/Org/xal-espaimercat.org")))

                                        ; Configure clockreport for agenda view
(setq org-agenda-clockreport-parameter-plist '(:link t :maxlevel 4 :fileskip0 t))
;(setq org-agenda-start-with-clockreport-mode t)
(setq org-agenda-start-with-log-mode t)
(setq org-deadline-warning-days 14)
(setq org-agenda-show-all-dates t)
(setq org-agenda-span 'day)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-todo-keywords
      '((sequence "TODO" "SCHEDULED" "WAITING" "|" "DONE")))
                                        ; Custom agenda view with agenda for current day, next todo items,
                                        ; stuck projects and all other
                                        ; todo items
(setq org-todo-keyword-faces
           '(("TODO" . (:foreground "orange" :weight bold))
             ("DONE" . (:foreground "green" :weight bold))))
(setq org-stuck-projects '("+LEVEL=1/-DONE" ("TODO" "WAITING" "NEXT") nil ""))
(setq org-agenda-custom-commands
      '(("A" "Gnuine tasks"
         ((agenda "" ((org-agenda-ndays 1)))
          (tags-todo "0inbox")
          (tags-todo "6waiting")
          (tags-todo "1now")
          (tags-todo "2next")
          (tags-todo "3soon")
          (tags-todo "4later")
          (tags-todo "5someday")
          (todo "TODO")))
        ("a" "Gnuine tasks"
         ((agenda "" ((org-agenda-ndays 1)))
          (tags-todo "+PRIORITY=\"A\"")
          (tags-todo "+PRIORITY=\"B\"")
          (tags-todo "+PRIORITY=\"C\"")
          (tags-todo "+PRIORITY=\"\"")))
        ("d" "All done tasks"
         ((todo "DONE")))
        ("P" "Planner"
         ((agenda ""  ((org-agenda-ndays 1)))
          (tags-todo "dilluns")
          (tags-todo "dimarts")
          (tags-todo "dimecres")
          (tags-todo "dijous")
          (tags-todo "divendres")
          (tags-todo "setmana1")
          (tags-todo "setmana2")
          (tags-todo "setmana3")
          (tags-todo "setmana4")
          (tags-todo "setmana5")
          (tags-todo "novembre")
          (tags-todo "desembre")
          (todo "TODO")))
        ("T" "Timeline"
         ((agenda "" ((org-agenda-ndays 14)))
          (todo "TODO")))))

(setq org-refile-targets `((org-agenda-files . (:level . 1))))
(setq org-default-notes-file "~/Dropbox/Org/inbox.org")


; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00"))))
                                        ; Start indented
(setq org-startup-indented t)

                                        ; Set up for mobile org
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-inbox-for-pull "~/Dropbox/MobileOrg/inbox.org")

(define-key global-map "\C-cc" 'org-capture)
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates
      (quote (("c" "Todo" entry (file+headline "~/Dropbox/Org/inbox.org" "Tasks")
               "* TODO %^{Action oriented description} %?\n:%U\n"))))
(define-key global-map "\C-cc"
  (lambda () (interactive) (org-capture nil "c")))

(setq org-deadline-warning-days 14)
(setq org-agenda-show-all-dates t)

(defun org-column-view-uses-fixed-width-face ()
  ;; copy from org-faces.el
  (when (fboundp 'set-face-attribute)
    ;; Make sure that a fixed-width face is used when we have a column
    ;; table.
    (set-face-attribute 'org-column nil
                        :height (face-attribute 'default :height)
                        :family (face-attribute 'default :family))))

(when (and (fboundp 'daemonp) (daemonp))
  (add-hook 'org-mode-hook 'org-column-view-uses-fixed-width-face))

;; Org mode notifications
;; the appointment notification facility
(setq
  appt-message-warning-time 15 ;; warn 15 min in advance

  appt-display-mode-line t     ;; show in the modeline
  appt-display-format 'window) ;; use our func
(appt-activate 1)              ;; active appt (appointment notification)
(display-time)                 ;; time display is required for this...

 ;; update appt each time agenda opened

(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

;; our little façade-function for djcb-popup
(defun djcb-appt-display (min-to-app new-time msg)
  (djcb-popup (format "Appointment in %s minute(s)" min-to-app) msg))
(setq appt-disp-window-function (function djcb-appt-display))
