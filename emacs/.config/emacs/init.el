(require 'org)
(org-babel-load-file "~/.config/emacs/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-selected-packages
   '(evil evil-mode magit web-mode nix-mode company-ghci flycheck company-posframe uniquify minions dap-mode lsp-treemacs lsp-ivy helm-lsp lsp-ui lsp-mode dired org-bullets multiple-cursors auctex treemacs all-the-icons-dired all-the-icons company counsel ivy hydra doom-themes which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch-serif ((t (:family "Consolas")))))

(put 'dired-find-alternate-file 'disabled nil) ; disables warning
(require 'dired )
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file

(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
