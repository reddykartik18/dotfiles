(package-initialize)
(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc-rc.el")

(global-display-line-numbers-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(line-number-mode 1)

;; ido
(rc/require 'smex 'ido-completing-read+)
(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
;; (ido-ubiquitous-mode 1)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; c-mode
(setq-default c-basic-offset 2
	      c-default-style '((java-mode . "java")
				(awk-mode . "awk")
				(other . "bsd")))
(add-hook 'c-mode-hook (lambda() (interactive) (c-toggle-comment-style -1)))

;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit () (interactive) (paredit-mode 1))
(add-hook 'emacs-lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook           'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook              'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook       'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook            'rc/turn-on-paredit)
(add-hook 'racket-mode-hook            'rc/turn-on-paredit)

;; Emacs-lisp
(add-hook 'emacs-lisp-mode-hook '(lambda() (local-set-key (kbd "C-c C-j") (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;; magit
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)
(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;; swap file disabled
(setq make-backup-files nil)

;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")	    'mc/mark-next-like-this)
(global-set-key (kbd "C-<")	    'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")	    'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")	    'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")	    'mc/skip-to-previous-like-this)

;; dired
(require 'dired-x)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;; helm
(rc/require 'helm 'helm-git-grep 'helm-ls-git)
(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-c h t")   'helm-cmd-t)
(global-set-key (kbd "C-c h g g") 'helm-git-grep)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f")   'helm-find)
(global-set-key (kbd "C-c h a")   'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h ")	  'helm-recentf)

;; word-wrap
(defun rc/enable-word-wrap () (interative) (toggle-word-wrap 1))
(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;; company
(rc/require 'company)
(require 'company)

(global-company-mode)
(add-hook 'tuareg-mode-hook (lambda () (interactive) (company-mode 0)))

(require 'compile)
compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))
