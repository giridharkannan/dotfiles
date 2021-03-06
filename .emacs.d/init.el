(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      color-theme
                      clojure-mode
                      evil
                      evil-leader
                      undo-tree
                      nrepl
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;Use Molokai color-scheme
(require 'color-theme)
(color-theme-molokai)

;Activate Evil mode at start up
(require 'evil)
(evil-mode 1)
(add-to-list 'load-path "~/.emacs.d/evil-surround")

(require 'surround)
(global-surround-mode 1)

; Keybindings
(global-set-key (kbd "C-c j") 'nrepl-jack-in)
(global-set-key (kbd "C-f") 'find-file-in-project)

;4-clojure plugin
;(add-to-list 'load-path "~/.emacs.d/4clj-el/")
;(require 'four-clj)

;switch between split-windows
(define-key evil-normal-state-map (kbd "C-l") 'other-window)

;;; esc quits

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
