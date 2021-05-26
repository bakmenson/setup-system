;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "bakmenson"
      user-mail-address "bakmenson@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Source Code Pro" :size 9.5 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 9.5))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
;;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

(setq evil-normal-state-cursor '(box "medium sea green")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))

;; fill-column indicator
(setq-default fill-column nil)
(add-hook 'prog-mode-hook '(lambda () (setq fill-column 120)))
(add-hook 'python-mode-hook '(lambda () (setq fill-column 80)))

;; disable highlight current line
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(setq treemacs-git-mode 'deferred)

(after! flycheck
        (add-to-list 'flycheck-check-syntax-automatically 'idle-change))

;; similar vim-easymotion
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

;; Capitalize keywords in SQL mode
(add-hook 'sql-mode-hook 'sqlup-mode)
;; Capitalize keywords in an interactive session (e.g. psql)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)
;; Set a global keyword to use sqlup on a region
;; (global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)
(global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-buffer)
;;(add-to-list 'sqlup-blacklist "name")

;; Image previews in dired
(global-set-key (kbd "C-x i") 'peep-dired)
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

;; Pomidor
(global-set-key (kbd "<f12>") #'pomidor)
(global-set-key (kbd "C-c b") 'pomidor-break)
(setq pomidor-sound-tick nil
      pomidor-sound-tack nil)
(setq pomidor-seconds (* 25 60)) ; 25 minutes for the work period
(setq pomidor-break-seconds (* 5 60)) ; 5 minutes break time
(setq pomidor-breaks-before-long 4) ; wait 4 short breaks before long break
(setq pomidor-long-break-seconds (* 20 60)) ; 20 minutes long break time
(setq alert-default-style 'libnotify)

;; Auto-refresh dired on file change
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode)

;; for lsp: M-x lsp-install-server

(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            (local-set-key (kbd "<f7>") 'meghanada-compile-project)
            (local-set-key (kbd "<f8>") 'meghanada-compile-file)
            (local-set-key (kbd "<f9>") 'meghanada-exec-main)
            (local-set-key (kbd "C-c d") 'meghanada-jump-declaration)
            (local-set-key (kbd "C-c m") 'meghanada-mode)
            (local-set-key (kbd "C-c k") 'meghanada-server-kill)
            (local-set-key (kbd "C-c s") 'meghanada-server-start)
            (local-set-key (kbd "C-c r") 'meghanada-restart)
            ;; (setq c-basic-offset 4)
            ;; (setq-default tab-width 4)
            ;; meghanada-mode on
            (meghanada-mode t)
            (setq c-basic-offset 4)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(cond
   ((eq system-type 'windows-nt)
    (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
    (setq meghanada-maven-path "mvn.cmd"))
   (t
    (setq meghanada-java-path "java")
    (setq meghanada-maven-path "mvn")))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; -----------------------------------------------------------------------------
