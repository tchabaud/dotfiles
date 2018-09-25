;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Begin file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)

;; Add MELPA repository
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Add Marmalade repository
;;(add-to-list 'package-archives
;;    '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
(require 'use-package))

;; Check and install missing packages if needed
(setq use-package-always-ensure t)

;; Checks for package update
(use-package auto-package-update
  :config
  (auto-package-update-maybe)
  (setq auto-package-update-delete-old-versions t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN - Theme / Look'n'feel settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Nice mode line, with nice theme
(use-package smart-mode-line-powerline-theme
  :config (setq sml/theme 'powerline)
          (setq sml/no-confirm-load-theme t))
(use-package smart-mode-line
  :config (sml/setup))

;; Use custom theme
(use-package zenburn-theme
  :config (load-theme 'zenburn t))

;; No toolbar / menubar
(tool-bar-mode -1)
(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Theme / Look'n'feel settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN - Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Everywhere completion
(use-package counsel
  :config (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-extra-directories nil)
  (setq ivy-use-selectable-prompt t)
  (setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (global-set-key (kbd "C-c s") 'counsel-tramp)
  (global-set-key (kbd "C-c C-r") 'ivy-resume))

(use-package counsel-tramp)
(use-package all-the-icons)
(use-package all-the-icons-dired
  :config (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
(use-package all-the-icons-ivy
  :config (all-the-icons-ivy-setup))

;; Code completion
(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t))

;; Additional completion packages
(use-package company-flx
  :config (company-flx-mode +1))
(use-package company-ansible)
(use-package company-dict)
(use-package company-edbi)
(use-package company-emoji)
(use-package company-jedi)
(use-package company-lua)
;(use-package company-lsp)
(use-package company-nixos-options)
(use-package company-quickhelp)
(use-package company-restclient)
(use-package company-shell)
(use-package company-statistics)
(use-package company-tern)
(use-package company-try-hard)
(use-package company-web)

;; Gtags
(use-package ggtags
  :config (setq ggtags-executable-directory "/usr/bin")
  (setq ggtags-use-idutils t)
  (setq ggtags-use-project-gtagsconf nil)
  (setq ggtags-global-mode 1)
  (setq ggtags-oversize-limit 104857600) ;; Allow very large database files
  (setq ggtags-sort-by-nearness t))

(use-package docker-tramp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Displays key binding for current mode
(use-package discover-my-major
  :bind (("C-h C-m" . discover-my-major)
         ("C-h M-m" . discover-my-mode)))

;; Org mode
(use-package org
  :bind (("\C-cl" . org-store-link)
         ("\C-cl" . org-agenda))
  :config (setq org-log-done t))

;; Git integration
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

;; Nice package to automatically disassemble java .class files
(use-package autodisass-java-bytecode)

;; Other useful modes
(use-package markdown-mode+)
(use-package markdown-preview-mode)
(use-package markdown-toc)
(use-package json-mode)
(use-package nix-mode)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package yaml-mode)

(use-package pdf-tools)
(pdf-tools-install)

(use-package indium)

(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Custom packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Maximize frame at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Smart buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Remember place in file when reopening
(save-place-mode 1)

;; Change default font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 90
                    :weight 'normal
                    :width 'normal)
;;(set-default-font "-*-Hack-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

;; Check TLS certs
(setq tls-checktrust t)
(setq gnutls-verify-error t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nice keyboard shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Kill current buffer by default (without asking)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Complete shortcut
(global-set-key (kbd "M-/") 'hippie-expand)

;; Nice buffer search
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Regexp searches by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; Always display column number in status line
(setq column-number-mode t)

;; Display line numbers in left margin
;; (global-linum-mode nil)

;; Disable startup screens
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; Encoding and line endings
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8-unix)

;; Show matching parenthesis
(show-paren-mode 1)

;; No fucking tabs for indent
(setq-default indent-tabs-mode nil)

;; Indent with 4 spaces
(setq-default tab-width 4)

;; Backups goes to one directory
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")))
(setq backup-by-copying t)

;; Fix path for NixOS
(setq exec-path (append exec-path '("/run/current-system/sw/bin")))

;; Fix clipboard integration
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      ;; Save whatever’s in the current (system) clipboard before
      ;; replacing it with the Emacs’ text.
      ;; https://github.com/dakrone/eos/blob/master/eos.org
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; Tramp

;; SSH by default for remote host access
(setq tramp-default-method "ssh")

(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)

;; Dired

;; Try to guess destination path using splitted window
(setq dired-dwim-target t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END - Custom settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(package-selected-packages
   (quote
    (json-mode markdown-toc markdown-preview-mode markdown-mode+ autodisass-java-bytecode discover-my-major multi-term zenburn-theme company-web company-try-hard company-shell company-restclient company-quickhelp company-lua company-emoji company-dict company-ansible company ivy smart-mode-line-powerline-theme auto-package-update use-package)))
 '(tramp-default-method "ssh"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
