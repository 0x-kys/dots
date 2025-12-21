;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; Set font to JetBrainsMono Nerd Font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'kanagawa-dragon)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Custom dashboard banner and quotes
(setq fancy-splash-image (concat doom-user-dir "banner.txt"))

(defun doom-dashboard-draw-ascii-banner-fn ()
  (let* ((banner '("                    "
                   "  //  M O N O       "
                   "  //  L I T H       "
                   "                    "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-banner-fn)

;; Custom minimal quotes
(setq +doom-dashboard-menu-sections
      '(("Recently opened files"
         :icon (nerd-icons-faicon "nf-fa-file_text_o" :face 'doom-dashboard-menu-title)
         :action recentf-open-files)
        ("Open project"
         :icon (nerd-icons-octicon "nf-oct-briefcase" :face 'doom-dashboard-menu-title)
         :action projectile-switch-project)
        ("Jump to bookmark"
         :icon (nerd-icons-octicon "nf-oct-bookmark" :face 'doom-dashboard-menu-title)
         :action bookmark-jump)))

;; Minimal custom quotes
(setq +doom-dashboard-functions
      '(doom-dashboard-widget-banner
        doom-dashboard-widget-shortmenu
        doom-dashboard-widget-loaded))

;; Custom minimal quotes for startup
(defvar monolith-quotes
  '("simplicity is the ultimate sophistication"
    "less is more"
    "form follows function"
    "perfection is achieved not when there is nothing more to add"
    "but when there is nothing left to take away"
    "clarity above all"
    "minimal by design"
    "focus on what matters"
    "eliminate the unnecessary"
    "pure function, zero decoration"))

(defun monolith-random-quote ()
  (nth (random (length monolith-quotes)) monolith-quotes))

(defun doom-dashboard-widget-footer ()
  (insert
   "\n"
   (+doom-dashboard--center
    +doom-dashboard--width
    (propertize (monolith-random-quote) 'face 'doom-dashboard-footer-icon))
   "\n"))

(add-hook! '+doom-dashboard-mode-hook
  (setq-local mode-line-format nil)
  (add-hook 'doom-dashboard-widget-functions #'doom-dashboard-widget-footer 100))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; PERFORMANCE OPTIMIZATIONS - Load first
(setq gc-cons-threshold 100000000)           ;; 100MB GC threshold
(setq read-process-output-max (* 3 1024 1024)) ;; 3MB read buffer for LSP
(setq process-adaptive-read-buffering nil)   ;; Disable adaptive read buffering
(setq inhibit-compacting-font-caches t)      ;; Don't compact font caches during GC

;; File handling performance
(setq auto-save-default nil)                 ;; Disable auto-save
(setq make-backup-files nil)                 ;; Disable backup files
(setq create-lockfiles nil)                  ;; Disable lockfiles

;; UI performance
(setq fast-but-imprecise-scrolling t)        ;; Faster scrolling
(setq jit-lock-defer-time 0)                 ;; Immediate syntax highlighting

;; Eglot configuration for JavaScript/TypeScript
(after! eglot
  (setq eglot-sync-connect nil)              ;; Async connection
  (setq eglot-events-buffer-size 0)          ;; Disable event logging
  (setq eglot-autoshutdown t)                ;; Shutdown when buffer killed
  (setq eglot-send-changes-idle-time 0.5)    ;; Send changes after 0.5s idle
  
  ;; Show inline diagnostics
  (setq eglot-report-progress t)
  
  ;; Register language servers
  (add-to-list 'eglot-server-programs
               '((js-mode typescript-mode tsx-ts-mode typescript-ts-mode)
                 . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((web-mode) . ("tailwindcss-language-server" "--stdio")))
  
  ;; Auto-start eglot for JS/TS files
  (add-hook 'js-mode-hook 'eglot-ensure)
  (add-hook 'typescript-mode-hook 'eglot-ensure)
  (add-hook 'tsx-ts-mode-hook 'eglot-ensure)
  (add-hook 'typescript-ts-mode-hook 'eglot-ensure))

;; Flymake configuration
(after! flymake
  ;; Show diagnostics in echo area
  (setq flymake-no-changes-timeout 0.5)
  (setq flymake-start-on-flymake-mode t)
  (setq flymake-start-on-save-buffer t)
  
  ;; Show more context in error messages
  (setq flymake-mode-line-counter-format '(" [" flymake-mode-line-error-counter
                                            flymake-mode-line-warning-counter
                                            flymake-mode-line-note-counter "]"))
  
  ;; Enable fringe indicators
  (setq flymake-fringe-indicator-position 'left-fringe))

;; ESLint integration with flymake
(use-package! flymake-eslint
  :after flymake
  :config
  ;; Prefer JSON diagnostics if available
  (setq flymake-eslint-prefer-json-diagnostics t)
  
  ;; Use project-local eslint
  (defun my/use-local-eslint ()
    "Set project's `node_modules' binary eslint as first priority."
    (interactive)
    (let* ((root (locate-dominating-file (buffer-file-name) "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/.bin/eslint" root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flymake-eslint-executable-name eslint)
        (message (format "Found local ESLint: %s" eslint))
        (flymake-eslint-enable))))
  
  ;; Enable for JS/TS modes
  (defun my/configure-eslint-with-flymake ()
    (when (derived-mode-p 'js-mode 'typescript-mode 'tsx-ts-mode 'typescript-ts-mode 'js-ts-mode)
      (my/use-local-eslint)))
  
  ;; Hooks
  (add-hook 'eglot-managed-mode-hook #'my/use-local-eslint)
  (add-hook 'js-mode-hook #'my/use-local-eslint)
  (add-hook 'typescript-mode-hook #'my/use-local-eslint)
  (add-hook 'tsx-ts-mode-hook #'my/use-local-eslint)
  (add-hook 'typescript-ts-mode-hook #'my/use-local-eslint))

;; Show diagnostics in echo area on cursor hover
(setq eldoc-idle-delay 0.3)
(setq eldoc-echo-area-use-multiline-p 3)

;; Better diagnostic display in echo area
(defun my/flymake-diagnostic-at-point ()
  "Display flymake diagnostic at point in echo area."
  (when-let* ((diags (flymake-diagnostics (point)))
              (diag (car diags)))
    (message "%s: %s" 
             (propertize (symbol-name (flymake-diagnostic-type diag))
                        'face (flymake-diagnostic-type diag))
             (flymake-diagnostic-text diag))))

;; Show diagnostic when cursor moves
(defvar my/flymake-display-timer nil)

(defun my/flymake-display-diagnostic-delayed ()
  "Display diagnostic after a short delay."
  (when my/flymake-display-timer
    (cancel-timer my/flymake-display-timer))
  (setq my/flymake-display-timer
        (run-with-idle-timer 0.5 nil #'my/flymake-diagnostic-at-point)))

(add-hook 'flymake-mode-hook
          (lambda ()
            (add-hook 'post-command-hook #'my/flymake-display-diagnostic-delayed nil t)))

;; Corfu (completion) performance
(after! corfu
  (setq corfu-auto-delay 0.2)
  (setq corfu-auto-prefix 2))

;; Tab bar for open buffers
(setq +workspaces-on-switch-project-behavior nil)
(after! centaur-tabs
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "●")
  (setq centaur-tabs-close-button "×")
  (setq centaur-tabs-cycle-scope 'tabs))

;; Disable heavy features for performance
(setq doom-modeline-buffer-file-name-style 'relative-from-project)
(setq doom-modeline-modal-icon nil)
(setq which-key-idle-delay 0.5)

;; Line numbers performance (disable in some modes)
(add-hook 'prog-mode-hook
          (lambda ()
            (when (> (buffer-size) 100000)
              (display-line-numbers-mode -1))))

;; ESLint format on save
(defun my/eslint-fix-file ()
  "Format current buffer with ESLint --fix."
  (interactive)
  (when (and buffer-file-name
             (derived-mode-p 'js-mode 'typescript-mode 'tsx-ts-mode 'typescript-ts-mode 'js-ts-mode))
    (let* ((root (locate-dominating-file buffer-file-name "node_modules"))
           (eslint (and root (expand-file-name "node_modules/.bin/eslint" root))))
      (when (and eslint (file-executable-p eslint))
        (let ((current-line (line-number-at-pos))
              (current-column (current-column)))
          (call-process eslint nil "*eslint-output*" nil "--fix" buffer-file-name)
          (revert-buffer t t t)
          (goto-char (point-min))
          (forward-line (1- current-line))
          (move-to-column current-column))))))

;; Add format on save
(defun my/eslint-fix-on-save ()
  "Run ESLint --fix before saving."
  (add-hook 'before-save-hook #'my/eslint-fix-file nil t))

;; Enable format on save for JS/TS modes
(add-hook 'js-mode-hook #'my/eslint-fix-on-save)
(add-hook 'typescript-mode-hook #'my/eslint-fix-on-save)
(add-hook 'tsx-ts-mode-hook #'my/eslint-fix-on-save)
(add-hook 'typescript-ts-mode-hook #'my/eslint-fix-on-save)

;; Custom keybindings for LSP/diagnostics
(map! :leader
      :desc "List diagnostics" "c x" #'consult-flymake
      :desc "Next diagnostic" "c n" #'flymake-goto-next-error
      :desc "Prev diagnostic" "c p" #'flymake-goto-prev-error
      :desc "Show diagnostic" "c d" #'flymake-show-diagnostic)

(map! :leader
      :desc "Format with ESLint" "c f" #'my/eslint-fix-file
      :desc "Rename symbol" "c r" #'eglot-rename
      :desc "Code actions" "c a" #'eglot-code-actions
      :desc "Organize imports" "c o" #'eglot-code-action-organize-imports)
