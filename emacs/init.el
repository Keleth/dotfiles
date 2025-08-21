;(setq inhibit-startup-message t)

(scroll-bar-mode -1) ;убрать скролл бар
(tool-bar-mode -1)   ;убрать панель инструментов
;(tooltip-mode -1)    ;убрать подсказки
(set-fringe-mode 10)  ;отступ от края
;(menu-bar-mode -1)   ;убрать главное меню

(setq visible-bell t) ;визульное оповещение

;; По ESC вываливаемся отовсюду
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)

(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 120) ;шрифт

(load-theme 'doom-palenight t)

;; Номера строк 
(column-number-mode)
(global-display-line-numbers-mode t)
;; отключить номера строк для некоторых режимов
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Настройки для пакетов
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-intstall 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;(use-package all-the-icons)

;;ivy - завершение
(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ;;	 ("C-j" . ivy-next-line)
	 ;;	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-l" . ivy-done))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x) ;; по нажатию M-o в списке функций можно получить доп. меню и перейти к определению той или иной функции
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; don't start searches with ^


;; modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes)

;; rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; helpful - расширенный формат помощи
;;(use-package helpful)


	 

