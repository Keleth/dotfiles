(tool-bar-mode -1)
;;(menu-bar-mode -1)

(set-frame-font "JetBrainsMonoNL Nerd Font 14" nil t)
(load-theme 'tango-dark)
(display-line-numbers-mode 1)

;; включить поддержку melpa
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; включить поддержку use-package, если ее вдруг нет
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; try
;; установить пакет try для тестирования пакетов
(use-package try
  :ensure t)
;; использование: M-x try
;; ввести название пакета, например 2048-game
;; запустить установленный пакет: M-x 2048-game
;; после перезапуска emacs пакет будет удален

;; which-key - подсказка хоткеев
(use-package which-key
  :ensure t
  :config (which-key-mode))
;;навигация: n / p - страница вперед / назад

;; org-mode штуки
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode))
;;(add-to-list 'load-path "~/.emacs.d/")

;; ido (подстановка имен файлов)
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; hideshow (folding)
(require 'hideshow)
(global-set-key (kbd "<f9>") 'hs-toggle-hiding)
(global-set-key (kbd "C-<f9>") 'hs-hide-all)
(global-set-key (kbd "C-S-<f9>") 'hs-show-all)
;; turn-on M-x hs-minor-mode

;; default tab behaviour
;;(global-set-key (kbd "<tab>") 'indent-for-tab-command)
;;(global-set-key (kbd "TAB") 'self-insert-command)

;; turn-off corfu
;;(define-key corfu-map [tab] nil)
;;(define-key corfu-map "\t" nil)

;; autocomplete
(use-package corfu
  :custom
  (corfu-auto t)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  ;;(tab-always-indent 'complete)

;;  :bind
;;  (:map corfu-map ("C-<tab>" . corfu-insert-separator))

  :init
  (global-corfu-mode)
  )

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (yas-load-directory "~/.emacs.d/snippets")
  )

(use-package yasnippet-snippets
  :ensure t
  )
;; 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-bullets which-key try yasnippet-snippets yasnippet corfu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
