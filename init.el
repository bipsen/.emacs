(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (poet)))
 '(custom-safe-themes
   (quote
    ("28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" "f490984d405f1a97418a92f478218b8e4bcc188cf353e5dd5d5acd2f8efd0790" "2d035eb93f92384d11f18ed00930e5cc9964281915689fa035719cab71766a15" "35c096aa0975d104688a9e59e28860f5af6bb4459fd692ed47557727848e6dfe" default)))
 '(fci-rule-color "#dedede")
 '(inhibit-startup-buffer-menu nil)
 '(inhibit-startup-screen t)
 '(line-spacing 0.2)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (magit poet-theme helm-swoop org-superstar org-brain org use-package tidal py-autopep8 org-bullets flycheck elpy)))
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans" :foundry "PfEd" :slant normal :weight normal :height 83 :width normal)))))

;; -------------------------------------------------------------
;; globals
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; -------------------------------------------------------------
;; org
(require 'org)

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(setq org-special-ctrl-a/e t)

;; -------------------------------------------------------------
;; latex
(require 'ox-latex)

(add-to-list 'org-latex-classes
      '("mimosis"
         "\\documentclass{mimosis}
         [NO-DEFAULT-PACKAGES]
         [PACKAGES]
         [EXTRA]"
     ("\\chapter{%s}" . "\\chapter*{%s}")
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\mboxparagraph{%s}" . "\\mboxparagraph*{%s}")
     ("\\mboxsubparagraph{%s}" . "\\mboxsubparagraph*{%s}")))

(require 'ox-extra)

(ox-extras-activate '(ignore-headlines))

(setq org-latex-logfiles-extensions (quote ("alg" "acn" "acr" "alg" "glg" "glo" "gls" "ist" "lof" "lot" "tex" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))

;; -------------------------------------------------------------
;; org-ref
(require 'org-ref)

(setq reftex-default-bibliography '("~/speciale/manuscript.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/speciale/notes.org"
      org-ref-default-bibliography '("~/speciale/manuscript.bib")
      org-ref-pdf-directory "~/speciale/papers")

(setq bibtex-completion-bibliography "~/speciale/manuscript.bib"
      bibtex-completion-library-path "~/speciale/papers"
      bibtex-completion-notes-path "~/speciale/helm-bibtex-notes")

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

;; -------------------------------------------------------------
;; helm
(require 'helm)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)

;; helm-swoop
(require 'helm-swoop)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
(setq helm-multi-swoop-edit-save t)
(setq helm-swoop-use-fuzzy-match t)

;; -------------------------------------------------------------
;; text
;; visual line mode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; poet-theme
(add-hook 'text-mode-hook
           (lambda ()
	     (variable-pitch-mode 1)))
(set-face-attribute 'default nil :family "Ubuntu Mono" :height 130)
(set-face-attribute 'fixed-pitch nil :family "Ubuntu Mono")
(set-face-attribute 'variable-pitch nil :family "Ubuntu" :height 120 :weight 'light)

;; -------------------------------------------------------------
;; magit
(global-set-key (kbd "C-x g") 'magit-status)
