;;
;; Customize
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 3)
 '(c-default-style
   (quote
    ((java-mode . "java")
     (awk-mode . "awk")
     (other . "bsd"))))
 '(c-offsets-alist (quote ((arglist-intro . +) (arglist-close . 0))))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (misterioso)))
 '(electric-indent-mode t)
 '(fill-column 110)
 '(global-auto-complete-mode t)
 '(global-subword-mode t)
 '(indent-tabs-mode nil)
 '(keyboard-coding-system (quote utf-8))
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 5) ((control)))))
 '(ns-alternate-modifier (quote alt))
 '(ns-command-modifier (quote meta))
 '(nxml-attribute-indent 3)
 '(nxml-child-indent 3)
 '(nxml-outline-child-indent 3)
 '(scroll-conservatively 1000)
 '(sgml-basic-offset 3)
 '(show-paren-mode t)
 '(tabbar-mode t nil (tabbar))
 '(truncate-lines t)
 '(visible-bell t))

;; Customize a few key bind
(setq-default tab-width 4)
(setq default-tab-width 4)

(define-key global-map (kbd "C-m") 'newline-and-indent)
(define-key global-map (kbd "C-^") 'help-command)
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
(define-key global-map (kbd "M-n") (kbd "C-u 5 C-n"))
(define-key global-map (kbd "M-p") (kbd "C-u 5 C-p"))
(define-key global-map (kbd "M-[ 5 c") (kbd "M-f"))
(define-key global-map (kbd "M-[ 5 D") (kbd "M-b"))
(define-key global-map (kbd "C-t") 'other-window)
(define-key global-map (kbd "C-t") 'other-window)

;; Collect backup files and auto-save files in ~/.emacs.d/backups/
(add-to-list 'backup-directory-alist
	     (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "dark cyan" :distant-foreground "white")))))
