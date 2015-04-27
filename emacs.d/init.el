(require `package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives )
(push '("melpha" . "http://melpa.milkbox.net/packages/")
      package-archives )

(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))


(add-to-list 'load-path "~/.emacs.d/elpa/evil-leader-0.4.3")
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "\\")

(add-to-list 'load-path "~/.emacs.d/elpa/evil-1.0.8")
(require 'evil)
(evil-mode 1)
(setq evil-leader/in-all-states 1)

(add-to-list 'load-path "~/.emacs.d/elpa/evil-tabs-20150127.1346")
(require 'evil-tabs)
(global-evil-tabs-mode t)

;;(add-to-list 'load-path "~/.emacs.d/elpa/powerline")
;;(require 'powerline)
;;(powerline-evil-vim-color-theme)
;;(display-time-mode t)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/elpa/project-explorer-0.13")
(require 'project-explorer)


(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "t" 'project-explorer-open
  "q" 'helm-M-x
  "f" 'fiplr-find-file
  )

(add-to-list 'load-path "~/.emacs.d/elpa/flycheck-20150412.242")
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-to-list 'load-path "~/.emacs.d/elpa/helm-20150425.218")
(require 'helm-config)
(helm-mode 1)

(helm-recentf-fuzzy-match t)
(helm-buffers-fuzzy-matching t)
(helm-recentf-fuzzy-match t)
(helm-buffers-fuzzy-matching t)
(helm-locate-fuzzy-match t)
(helm-M-x-fuzzy-match t)
(helm-semantic-fuzzy-match t)
(helm-imenu-fuzzy-match t)
(helm-apropos-fuzzy-match t)
(helm-lisp-fuzzy-completion t)

(add-to-list 'load-path "~/.emacs.d/elpa/autopair-20140825.427")
(require 'autopair)
(show-paren-mode t)
(autopair-global-mode)

(add-to-list 'load-path "~/.emacs.d/elpa/fiplr")
(require 'fiplr)
(setq fiplr-root-markers '(".git"))
(setq fiplr-ignored-globs '((directories (".git" ".rope"))
                            (files ("*.jpg" "*.png" "*.zip" "*~" "*.pyc"))))

;; convinience
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)
(setq make-backup-files nil)

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; apearense
(load-theme `gotham t)

(setq evil-emacs-state-cursor '("blue" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("yellow" box))
(setq evil-insert-state-cursor '("blue" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(set-frame-font "firamono")

(custom-set-variables
 
 '(custom-safe-themes
   (quote
    ("2258c76e10cd14e83f842cd83735b2ad4cbadd7a62ac4b4792fa61b104517ea0" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide `init.el)
;;; init.el ends here
