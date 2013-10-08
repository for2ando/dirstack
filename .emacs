;;;;; This file is copyed from wpc2 at 2 Aug. 1997.
;;;;; Add some lines for Meadow-2.00 at 28 Dec. 2004 on JMA Nagoya-LMO
;;;;; karge modification from that of npc2.

;;; 環境の識別方法一覧
;; OS(もしくはOSに準ずる環境): 変数 system-type (可能な値はC-h vで確認)
;; Meadowかどうか: (featurep 'meadow)
;; Carbon Emacsかどうか: (boundp 'carbon-emacs-package-version)
;; ウィンドウシステムで実行されているかどうか: (not (null window-system))



;;; 日本語環境設定
(cond ((featurep 'meadow)
       ;; ;;; Mule-UCS の設定
       ;; ;; ftp://ftp.m17n.org/pub/mule/Mule-UCS/
       ;; ;; (set-language-environment) の前に設定します
       (require 'un-define)	; for use of Unicode
       (require 'jisx0213)	; for use of JIS X 0213
       ))
(set-language-environment "Japanese")



;;; coding systems
(cond ((equal system-type 'windows-nt)	;; This includes meadow
       )
      ((boundp 'carbon-emacs-package-version)
       (set-default-coding-systems 'utf-8-unix)
       (set-keyboard-coding-system 'sjis-mac)
       (set-terminal-coding-system 'utf-8-unix)
       (set-clipboard-coding-system 'sjis-mac)
       (setq-default buffer-file-coding-system 'utf-8)
       (prefer-coding-system 'utf-8))
      ((equal system-type 'darwin)
       (set-default-coding-systems 'utf-8-unix)
       (set-keyboard-coding-system 'sjis-mac)
       (set-terminal-coding-system 'utf-8-unix)
       (set-clipboard-coding-system 'sjis-mac)
       (setq-default buffer-file-coding-system 'utf-8)
       (prefer-coding-system 'utf-8))
      (t
       ;;; obsoleted ?
       (set-display-coding-system '*sjis*)))



;;; Emacs22 specific settings
;;; ファイル名補完に従来(〜Emacs21)どおりスペースを使えるようにする．
(cond
 ((string= "22" (substring emacs-version 0 2))
  (define-key minibuffer-local-filename-completion-map
    " " 'minibuffer-complete-word)
  (define-key minibuffer-local-must-match-filename-map
    " " 'minibuffer-complete-word)))



;;; meadow-specific functions
(if (featurep 'meadow)
    (let ((curframe ()))
      ;;; IMEの設定
      (mw32-ime-initialize)
      (setq default-input-method "MW32-IME")
      (setq-default mw32-ime-mode-line-state-indicator "[--]")
      (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
      (add-hook 'mw32-ime-on-hook
		(function (lambda () (set-cursor-height 2))))
      (add-hook 'mw32-ime-off-hook
		(function (lambda () (set-cursor-height 4))))
  

      ;;; マウスカーソルを消す設定
      (setq w32-hide-mouse-on-key t)
      (setq w32-hide-mouse-timeout 5000)
  

      ;;; font-lockの設定
;      (if window-system
;	  (progn
;	    (setq font-lock-support-mode 'lazy-lock-mode)
;	    (global-font-lock-mode t)))
  
  
      ;; ;;; TrueType フォント設定
      (create-fontset-from-request "private-fontset"
				   '((width . 8)
				     (height . 16)
				     (fixed . t)
				     (italic . nil))
				   '((family . "ＭＳ ゴシック")
				     (family . "Courier New")))
      ;; (change-fontset-from-request "private-fontset"
      ;; 			     '((width . 8)
      ;; 			       (height . 16)
      ;; 			       (fixed . t)
      ;; 			       (weight . 700)
      ;; 			       (italic . nil))
      ;; 			     '((family . "ＭＳ ゴシック")
      ;; 			       (family . "Courier New"))
      ;; 			     1)
  
  
      ;; ;;; BDF フォント設定
      ;; ;; intlfonts-1.2.tar.gz が必要です
      ;; ;;   http://www.ring.gr.jp/archives/GNU/intlfonts/intlfonts-1.2.tar.gz
      ;; ;;   http://ring.asahi-net.or.jp/archives/GNU/intlfonts/intlfonts-1.2.tar.gz
      ;; ;;   ftp://ftp.m17n.org/pub/mule/intlfonts-1.2.tar.gz
      ;; ;;   ftp://ftp.gnu.org/pub/gnu/intlfonts/intlfonts-1.2.tar.gz
      ;; ;; などから入手してください
      ;; ;; c:/MEADOW/intlfonts-1.2 と展開した場合の設定例となっています。
      ;; (defvar bdf-font-directory "c:/MEADOW/intlfonts-1.2")
      ;; (defvar bdf-font-name-prefix "bdffont16-")
      ;;
      ;; (defvar bdf-font-file-alist
      ;;   '((ascii "European/lt1-16-etl.bdf" 0)
      ;;     (latin-iso8859-1 "European/lt1-16-etl.bdf" 1)   ; ISO8859-1
      ;;     (latin-iso8859-2 "European/lt2-16-etl.bdf" 1)   ; ISO8859-2
      ;;     (latin-iso8859-3 "European/lt3-16-etl.bdf" 1)   ; ISO8859-3
      ;;     (latin-iso8859-4 "European/lt4-16-etl.bdf" 1)   ; ISO8859-4
      ;;     (cyrillic-iso8859-5 "European/cyr16-etl.bdf" 1) ; ISO8859-5
      ;;     (arabic-iso8859-6 "Misc/arab16-0-etl.bdf" 0)    ; ISO8859-6 ???
      ;;     (greek-iso8859-7 "European/grk16-etl.bdf" 1)    ; ISO8859-7
      ;;     (hebrew-iso8859-8 "Misc/heb16-etl.bdf" 1)       ; ISO8859-8
      ;;     (latin-iso8859-9 "European/lt5-16-etl.bdf" 1)   ; ISO8859-9
      ;;     (thai-tis620 "Asian/thai16.bdf" 1)              ; TIS620
      ;;     (katakana-jisx0201 "japanese.X/8x16rk.bdf" 1)   ; JISX0201
      ;;     (latin-jisx0201 "japanese.X/8x16rk.bdf" 0)      ; JISX0201
      ;;     (japanese-jisx0212 "japanese/jksp16.bdf" 0)     ; JISX0212
      ;;     (japanese-jisx0208-1978 "japanese/j78-16.bdf" 0); JISX0208.1978
      ;;     (japanese-jisx0208 "japanese.X/jiskan16.bdf" 0) ; JISX0208.1983
      ;; ;;    (japanese-jisx0213-1 "Japanese.X/jiskan16-2000-1.bdf" 0)   ; JISX0213-2000(Plane 1) * Mule-UCS が必要です
      ;; ;;    (japanese-jisx0213-2 "Japanese.X/jiskan16-2000-2.bdf" 0)   ; JISX0213-2000(Plane 2) * Mule-UCS が必要です
      ;;     (korean-ksc5601 "Korean.X/hanglm16.bdf" 0)      ; KSC5601   mincho
      ;; ;;    (korean-ksc5601 "Korean.X/hanglg16.bdf" 0)    ; KSC5601   gothic
      ;;     (chinese-gb2312 "Chinese.X/gb16fs.bdf" 0 )      ; GB2312  ???
      ;;     (chinese-cns11643-1 "Chinese/cns1-16.bdf" 0)    ; CNS11643.1992-1
      ;;     (chinese-cns11643-2 "Chinese/cns2-16.bdf" 0)    ; CNS11643.1992-2
      ;;     (chinese-cns11643-3 "Chinese/cns3-16.bdf" 0)    ; CNS11643.1992-3
      ;;     (chinese-cns11643-4 "Chinese/cns4-16.bdf" 0)    ; CNS11643.1992-4
      ;;     (chinese-cns11643-5 "Chinese/cns5-16.bdf" 0)    ; CNS11643.1992-5
      ;;     (chinese-cns11643-6 "Chinese/cns6-16.bdf" 0)    ; CNS11643.1992-6
      ;;     (chinese-cns11643-7 "Chinese/cns7-16.bdf" 0)    ; CNS11643.1992-7
      ;;     (chinese-big5-1 "Chinese/taipei16.bdf" encode-big5-font) ; Big5
      ;;     (chinese-big5-2 "Chinese/taipei16.bdf" encode-big5-font) ; Big5
      ;;     (chinese-sisheng "Chinese/sish16-etl.bdf" 0)    ; sisheng_cwnn ???
      ;;     (vietnamese-viscii-lower "Asian/visc16-etl.bdf" encode-viscii-font) ; VISCII1.1
      ;;     (vietnamese-viscii-upper "Asian/visc16-etl.bdf" encode-viscii-font) ; VISCII1.1
      ;;     (arabic-digit "Misc/arab16-0-etl.bdf" 0)        ; MuleArabic-0
      ;;     (arabic-1-column "Misc/arab16-1-etl.bdf" 0)     ; MuleArabic-1
      ;;     (arabic-2-column "Misc/arab16-2-etl.bdf" 0)     ; MuleArabic-2
      ;;     (ipa "Misc/ipa16-etl.bdf" 1)                    ; MuleIPA
      ;;     (ethiopic "Ethiopic/ethio16f-uni.bdf" encode-ethio-font) ; Ethiopic-Unicode
      ;; ;;    (ascii-right-to-left "European/lt1-16-etl.bdf" 0) ; ISO8859-1 ;; ???
      ;;     (indian-is13194 "Asian/isci16-mule.bdf" 0)      ; IS13194-Devanagari
      ;;     (indian-2-column "Asian/ind16-mule.bdf" 0)      ; MuleIndian-2
      ;;     (indian-1-column "Asian/ind1c16-mule.bdf" 0)    ; MuleIndian-1
      ;;     (lao "Asian/lao16-mule.bdf" 1)                  ; MuleLao-1
      ;;     (tibetan "Asian/tib16-mule.bdf" 0)              ; MuleTibetan-0
      ;;     (tibetan-1-column "Asian/tib1c16-mule.bdf" 0)   ; MuleTibetan-1
      ;;     ))
      ;;
      ;; (defun w32-configure-bdf-font (fontset)
      ;;   (new-fontset fontset
      ;; 	       (mapcar 
      ;; 		(lambda (x)
      ;; 		  (let* ((charset (car x))
      ;; 			 (filename (nth 1 x))
      ;; 			 (encoding (nth 2 x))
      ;; 			 (fontname 
      ;; 			  (concat bdf-font-name-prefix
      ;; 				  (symbol-name charset))))
      ;; 		    (w32-auto-regist-bdf-font
      ;; 		     fontname
      ;; 		     (expand-file-name filename bdf-font-directory)
      ;; 		     encoding)
      ;; 		    (cons charset fontname)))
      ;; 		bdf-font-file-alist)))
      ;;
      ;; (w32-configure-bdf-font "bdf-fontset")
      ;;
      ;; ;; bold, italic, bold itaric を追加。
      ;; ;; Bold
      ;; (w32-change-font-logfont "bdffont16-ascii" 1 
      ;;     (list 'bdf-font (expand-file-name "European/lt1-16b-etl.bdf" bdf-font-directory )))
      ;; ;; italic
      ;; (w32-change-font-logfont "bdffont16-ascii" 2 
      ;;     (list 'bdf-font (expand-file-name "European/lt1-16i-etl.bdf" bdf-font-directory )))
      ;; ;; Bold itaric
      ;; (w32-change-font-logfont "bdffont16-ascii" 3 
      ;;     (list 'bdf-font (expand-file-name "European/lt1-16bi-etl.bdf" bdf-font-directory )))
  

      ;;; shell の設定

      ;;; Cygwin の bash を使う場合
      (setq explicit-shell-file-name "bash.exe") 
      (setq shell-file-name "sh.exe") 
      (setq shell-command-switch "-c") 
      (modify-coding-system-alist 'process ".*sh\\.exe" 'japanese-shift-jis-unix)
  
      ;; ;;; Virtually UN*X!にある tcsh.exe を使う場合
      ;; (setq explicit-shell-file-name "tcsh.exe") 
      ;; (setq shell-file-name "tcsh.exe") 
      ;; (setq shell-command-switch "-c") 
  
      ;; ;;; WindowsNT に付属の CMD.EXE を使う場合。
      ;; (setq explicit-shell-file-name "CMD.EXE") 
      ;; (setq shell-file-name "CMD.EXE") 
      ;; (setq shell-command-switch "\\/c") 
  

      ;;; argument-editing の設定
      (require 'mw32script)
      (mw32script-init)
  
  
      ;; ;;; browse-url の設定
      ;; (require 'browse-url)
      ;; (global-set-key [S-mouse-2] 'browse-url-at-mouse)
  
  
      ;; ;;; 印刷の設定
      ;; ;; この設定で M-x print-buffer RET などでの印刷ができるようになります
      ;; ;;
      ;; ;;  notepad に与えるパラメータの形式の設定
      ;; (define-process-argument-editing "notepad"
      ;;   (lambda (x) (general-process-argument-editing-function x nil t)))
      ;;
      ;; (defun w32-print-region (start end
      ;; 			       &optional lpr-prog delete-text buf display
      ;; 			       &rest rest)
      ;;   (interactive)
      ;;   (let ((tmpfile (expand-file-name (make-temp-name "w32-print-")
      ;; 				   temporary-file-directory))
      ;; 	(coding-system-for-write w32-system-coding-system))
      ;;     (write-region start end tmpfile nil 'nomsg)
      ;;     (call-process "notepad" nil nil nil "/p" tmpfile)
      ;;     (and (file-writable-p tmpfile) (delete-file tmpfile))))
      ;;
      ;; (setq print-region-function 'w32-print-region)
  
      (setq load-path
	    (append '("C:/appli/meadow/site-lisp/mule-ucs") load-path))
      ))
;;; end of meadow-specific functions



;;; carbon-emacs-specific functions
(if (boundp 'carbon-emacs-package-version)
    (progn
      (mac-key-mode 1)
      (setq mac-option-modifier 'meta)
      ))



;; 初期フレームの設定
;(if window-system
;    (tool-bar-mode nil)
;  )
(if window-system
    (cond ((featurep 'meadow)
	   (setq default-frame-alist
		 (append (list '(foreground-color . "black")
			       '(background-color . "LemonChiffon")
			       '(border-color . "black")
			       '(mouse-color . "white")
			       '(cursor-color . "black")
			       ;;'(ime-font . "Nihongo-12") ; TrueType のみ
			       ;;'(font . "bdf-fontset")    ; BDF
			       '(font . "private-fontset")  ; TrueType
			       )
			 default-frame-alist))
	   (cond ((equal (system-name) "TKNG-KY019")
		  (setq default-frame-alist
			(append (list '(top . 0)
				      '(left . 0)
				      '(width . 154)
				      '(height . 42))
				default-frame-alist)))
		 (t
		  (setq default-frame-alist
			(append (list '(top . 0)
				      '(left . 0)
				      '(width . 114)
				      '(height . 45))
				default-frame-alist)))
		 ))
	  ((boundp 'carbon-emacs-package-version)
	   (setq default-frame-alist
		 (append (list '(foreground-color . "black")
			       '(background-color . "LemonChiffon")
			       '(border-color . "black")
			       '(mouse-color . "white")
			       '(cursor-color . "black")
			       ;;'(ime-font . "Nihongo-12") ; TrueType のみ
			       ;;'(font . "bdf-fontset")    ; BDF
			       ;;'(font . "private-fontset"); TrueType
			       '(width . 177)
			       '(height . 61)
			       '(top . 0)
			       '(left . 0))
			 default-frame-alist)))
	  ))



;;; emacs server
(if (not (featurep 'meadow))
    (server-start)
  )



;;; for my hands
;(define-key global-map "\e\C-?" 'backward-kill-word)	; Carbon-emacs requires this.
;(define-key global-map "\C-?" 'backward-delete-char)
;(define-key global-map [delete] 'delete-char)
;(define-key emacs-lisp-mode-map [delete] 'delete-char)
;(define-key lisp-interaction-mode-map [delete] 'delete-char)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)
(define-key lisp-interaction-mode-map "\C-m" 'eval-print-last-sexp-at-eol)
(define-key emacs-lisp-mode-map "\e\C-m" 'eval-last-sexp)
;(define-key lisp-interaction-mode-map "\e\C-m" 'newline-and-indent)
(define-key lisp-interaction-mode-map "\C-j" nil)
;(define-key lisp-interaction-mode-map [return] "\C-e\C-m")
(global-set-key "\C-z" 'shell)
(global-set-key "\C-xg" 'goto-line)
(global-set-key "\eg" 'goto-line)
(global-set-key "\e&" 'query-replace-regexp)
;(define-key global-map "\e " 'just-one-space)	; Carbon-emacs requires this.
;(define-key global-map "\C-x_" 'shrink-window) 

(defun shell-command-on-region-to-current-buffer (start end command)
  "wrapper for shell-command-on-region: command output is inserted to current buffer"
  (interactive "*r\nsShell command on region: ")
  (shell-command-on-region start end command t nil))
;(define-key global-map "\e|" 'shell-command-on-region-to-current-buffer)

(defun set-tab-width (w) "changes variable: tab-width's value"
  (interactive "Ntab-width: ")
  (setq tab-width w)
  (princ (concat "tab-width set to: " tab-width) t))
(defun set-default-tab-width (w) "changes variable: default-tab-width's value"
  (interactive "Ndefault-tab-width: ")
  (setq default-tab-width w)
  (princ (concat "default-tab-width set to: " default-tab-width) t))
;(define-key global-map "\C-x\C-mt" 'set-tab-width)
;(define-key global-map "\C-x\C-mT" 'set-default-tab-width)
(defun toggle-tab-width ()
  "toggles a value of variable: tab-width between 8 and 4"
  (interactive)
  (setq tab-width (cond ((eq tab-width 8) 4)
			(t 8)))
  (redraw-display)
  (princ (concat "tab-width: " tab-width)))
;(define-key global-map "\C-x\C-m\C-t" 'toggle-tab-width)

(if (featurep 'meadow)
  (define-key global-map "\C-^" 'call-last-kbd-macro)
  (define-key global-map [?\C-=] 'call-last-kbd-macro)
)

(defun toggle-truncate-buffer ()
  "toggles a value of variable: truncate-lines"
  (interactive)
  (setq truncate-lines (not truncate-lines))
  (recenter))
;(define-key global-map "\C-x\C-m\C-e" 'toggle-truncate-buffer)



;;; new assignments
;(define-key emacs-lisp-mode-map "\e\C-m" 'eval-last-sexp)
;(define-key lisp-interaction-mode-map "\e\C-m" 'eval-last-sexp)
;(define-key global-map "\C-c\C-a" 'compile)
;(setq compile-command "make")
;(if (not (featurep 'meadow))
;  (define-key global-map [kanji] 'toggle-egg-mode))
(define-key global-map "\C-x\C-m\C-f" 'auto-fill-mode)
(global-set-key "\C-x\C-m\C-o" 'overwrite-mode)
(global-set-key "\C-x\C-m\C-i" 'overwrite-mode)
(define-key global-map "\C-x\C-m\C-r" 'toggle-read-only)
(define-key global-map "\C-x\C-m\C-l" 'describe-current-coding-system)
;(if (string-match "-nz$" (getenv "TERM")) (global-set-key "\C-z" 'shell))
;(global-set-key "\C-x\C-kr" 'set-file-coding-system-for-read)
(global-set-key "\C-^" 'call-last-kbd-macro)
(global-set-key "\C-]" "\C-a>\C-a\C-n")
(global-set-key "\C-]" "\C-a>\C-a\C-n")
(global-set-key "\C-x\C-q" 'toggle-read-only)	; not a vc-toggle-read-only
;(define-key global-map [] ')


;;; modification of filename to mode pair
(defun delpair-by-key (key value alist)
  "delete (key . value) pair from alist that the key is matched with key"
  (apply 'append
	 (mapcar (lambda (p)
		   (cond ((and (equal (car p) key)
			       (eq (listp (cdr p)) (listp value)))
			  nil)
			 (t
			  (list p))))
		 alist)))
(defun delpair-by-pair (key value alist)
  "delete (key . value) pair from alist"
  (apply 'append
	 (mapcar (lambda (p)
		   (cond ((equal p (cons key value))
			  nil)
			 (t
			  (list p))))
		 alist)))

(defun set-auto-major-mode (key mode)
  "change major mode associated to filename selected by regexp 'key'"
  (setq auto-mode-alist
	(cons (cons key mode)
	      (delpair-by-key key mode auto-mode-alist)))
  )
(defun delete-all-auto-minor-mode (key mode)
  "delete all minor mode associated to filename selected by regexp 'key'"
  (setq auto-mode-alist
	(delpair-by-key key (list mode) auto-mode-alist))
  )
(defun delete-auto-minor-mode (key mode)
  "delete minor mode associated to filename selected by regexp 'key'"
  (setq auto-mode-alist
	(delpair-by-pair key (list mode) auto-mode-alist))
  )
(defun add-auto-minor-mode (key mode)
  "associate minor mode to filename selected by regexp 'key'"
  (setq auto-mode-alist
	(cons (cons key (list mode)) auto-mode-alist))
  )



;;; assign modes
;(set-auto-major-mode "\\.pl\\'" 'perl-mode)
;(set-auto-major-mode "\\.l\\'" 'c-mode)
;(set-auto-major-mode "\\.rd\\'" 'rd-mode)
;(set-auto-major-mode "\\.rb\\'" 'ruby-mode)
;(set-auto-major-mode "\\.js\\'" 'javascript-mode)
;;(set-auto-major-mode "\\.xhtml\\(\\.\\w+\\)*\\'" 'xml-mode)
;;(set-auto-major-mode "\\.xml\\'" 'xml-mode)
;;(set-auto-major-mode "\\.rlx\\'" 'xml-mode)	;; RELAX
;;(set-auto-major-mode "\\.rng\\'" 'xml-mode)	;; RELAX-NG
;;(set-auto-major-mode "\\.sgml\\'" 'sgml-mode)
;(autoload 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
;(autoload 'ruby-mode "ruby-mode" "major mode for ruby script" t)
;(autoload 'javascript-mode "javascript-mode" "major mode for javascript" t)
;(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
;(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
;
;(setq interpreter-mode-alist
;      (cons (cons "ruby" 'ruby-mode) interpreter-mode-alist))
;(setq interpreter-mode-alist
;      (cons (cons "rd2" 'rd-mode) interpreter-mode-alist))



;;; c-mode
;(set-c-style "C++" t)
(setq c-tab-always-indent nil)
(setq c-indent-level 4)
(setq c-continued-statement-offset 4)
(setq c-brace-offset 0)
(setq c-brace-imaginary-offset 0)
(setq c-argdecl-indent 2)
(setq c-label-offset (- c-indent-level))
(add-hook 'c-mode-hook
	  (lambda ()
	    (define-key c-mode-map "\177" 'backward-delete-char)
	    (define-key c-mode-map [delete] 'delete-char)
	    ))
(defun insert-variables (varname)
  (cond ((not (null varname))
	 (insert (format "%s : %S\n" (car varname) (eval (car varname))))
	 (insert-variables (cdr varname)))))
(defun list-c-variables (n)
  "list c-mode variables for indentation customizing."
  (interactive "p")
  (switch-to-buffer-other-window "*c-mode variables*")
  (erase-buffer)
  (insert-variables '(c-auto-newline
		     c-tab-always-indent
		     c-indent-level
		     c-continued-statement-offset
		     c-brace-offset
		     c-brace-imaginary-offset
		     c-argdecl-indent
		     c-label-offset)))



;;; java-mode
(add-hook 'java-mode-hook
	  (function (lambda ()
		      (define-key java-mode-map "\C-c\C-m" 'compile)
)))



;;; ruby-mode
(setq load-path
      (append (list (expand-file-name "C:/appli/meadow/site-lisp/ruby-mode")) load-path))
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
	    (define-key ruby-mode-map "\C-j" 'newline)))

;;; rd-mode
;(setq load-path
;      (append (list (expand-file-name "C:/appli/meadow/site-lisp/rd-mode")) load-path))
(autoload 'rd-mode "rd-mode" "Mode for editing rd document files" t)
(setq auto-mode-alist
      (append '(("\\.rd$" . rd-mode)) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.rda$" . rd-mode)) auto-mode-alist))

;;; for ruby debugger
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

(add-hook 'rubydb-mode-hook
  (function (lambda ()
	      (set-buffer-process-coding-system 'shift_jis-unix 'shift_jis-unix))))



;;; shell-script-mode
(add-hook 'sh-mode-hook
	  (function (lambda ()
		      (setq sh-indentation 2)
)))



;;; shell-mode
(setq explicit-shell-file-name "bash.exe")
(setq shell-file-name "bash.exe")
;(setq shell-file-name "sh.exe")
;(setq shell-command-switch "-c")
(modify-coding-system-alist 'process ".*sh\\.exe" '(shift_jis-dos . euc-japan))

(add-hook 'shell-mode-hook
  (function (lambda ()
     (define-key shell-mode-map "\ep" 'comint-previous-matching-input-from-input)
     (define-key shell-mode-map "\en" 'comint-next-matching-input-from-input)
;     (define-key shell-mode-map "\C-p" 'previous-line)
;     (define-key shell-mode-map "\C-n" 'next-line)
     (define-key shell-mode-map "\e\C-p" 'comint-previous-input)
     (define-key shell-mode-map "\e\C-n" 'comint-next-input)
     (define-key shell-mode-map "\C-z" 'end-of-buffer)
     (define-key shell-mode-map "\C-a" 'comint-bol))))



;;; psgml-mode
(add-hook 'sgml-mode-hook
	  (function (lambda ()
		      (setq sgml-catalog-files '("catalog" "~/.sgml/catalog" "/usr/local/lib/sgml/catalog"))
		      (setq sgml-ecat-files '("ecat" "~/.sgml/ecat" "/usr/local/lib/sgml/ECAT"))
		      (setq sgml-custom-dtd
			    '(("HTML 4.01 Strict"
			       "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">")
			      ("HTML 4.01 Translational"
			       "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Translational//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">")
			      ("HTML 4.01 Frameset"
			       "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">")
			      ("XHTML 1.0 Strict"
			       "<?xml version=\"1.0\">\n <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n")
			      ("XHTML 1.0 Translational"
			       "<?xml version=\"1.0\">\n <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Translational//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n")
			      ("XHTML 1.0 Frameset" 
			       "<?xml version=\"1.0\">\n <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">\n")
			      ("XHTML 1.1"
			       "<?xml version=\"1.0\">\n <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n")
			      ("SVG 1.1"
			       "<?xml version=\"1.0\">\n <!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n")
			      ))
		      )))



;;; lisp-interaction-mode
(defun eval-print-last-sexp-at-eol (n)
  "Do eval-print-last-sexp after jumping to end of current line.
If arg N is 1, no jumping, i.e. completely same as eval-print-last-sexp."
  (interactive "p")
  (if (eq n 1) (end-of-line))
  (eval-print-last-sexp))



;;; perl-mode
(setq perl-indent-level 2)



;;; javascript-mode
(autoload 'javascript-mode "javascript-mode" "Mode for editing javascript source files" t)
(setq auto-mode-alist
      (append '(("\\.js$" . javascript-mode)) auto-mode-alist))



;;; css-mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
(setq cssm-indent-function 'cssm-c-style-indenter)



;;; Man-mode
(add-hook 'Man-mode-hook
	  (function (lambda ()
		      (define-key Man-mode-map "h" 'scroll-right)
		      (define-key Man-mode-map "j" "\C-u1\C-v")
		      (define-key Man-mode-map "k" "\C-u1\M-v")
		      (define-key Man-mode-map "l" 'scroll-left)
		      (define-key Man-mode-map "d" "\C-v\C-p")
		      (define-key Man-mode-map "u" "\M-v\C-n")
		      (define-key Man-mode-map "f" 'scroll-up)
		      (define-key Man-mode-map "b" 'scroll-down)
		      (define-key Man-mode-map "e" "\C-u2\C-v")
		      (define-key Man-mode-map "y" "\C-u2\M-v")
		      (define-key Man-mode-map "h" 'scroll-left)
		      (define-key Man-mode-map "j" "\C-u1\C-v")
		      (define-key Man-mode-map "k" "\C-u1\M-v")
		      (define-key Man-mode-map "l" 'scroll-right)
		      (define-key Man-mode-map "d" "\C-v\C-p")
		      (define-key Man-mode-map "u" "\M-v\C-n")
		      (define-key Man-mode-map "f" 'scroll-up)
		      (define-key Man-mode-map "b" 'scroll-down)
		      (define-key Man-mode-map "e" "\C-u2\C-v")
		      (define-key Man-mode-map "y" "\C-u2\M-v")
		      (define-key Man-mode-map "g" 'beginning-of-buffer)
		      (define-key Man-mode-map "G" 'end-of-buffer)
)))

;;; jman
(autoload 'jman "jman" "Get a Un*x manual page written on Japanese." t)



;;;; fence-mode
;(add-hook 'fence-mode-hook
;	  (function (lambda ()
;		      (define-key fence-mode-map [delete] 'fence-delete-char)
;		      (define-key fence-mode-map [escape] 'fence-cancel-input)
;		      (define-key fence-mode-map [kanji] 'fence-toggle-egg-mode)
;)))
;
;
;
;;;; henkan-mode
;(add-hook 'henkan-mode-hook
;	  (function (lambda ()
;		      (define-key henkan-mode-map [escape] 'henkan-quit)
;		      ;;; emulating bunsetu shinshuku of atok in henkan-mode (experimental)
;		      (define-key henkan-mode-map [down] 'henkan-forward-bunsetu)
;		      (define-key henkan-mode-map [up] 'henkan-previous-kouho)
;		      (define-key henkan-mode-map [right] 'henkan-bunsetu-nobasi-sho)
;		      (define-key henkan-mode-map [left] 'henkan-bunsetu-chijime-sho)
;					;(define-key henkan-mode-map [] ')
;)))




;;; TeX
;(setq tex-dvi-view-command
;      (if (eq window-system 'x) "xdvi" "dvi2tty * | cat -s"))
;(add-hook 'tex-shell-hook
;	  (function (lambda ()
;		      (setq tex-command "jlatex")
;		      (setq latex-run-command "jlatex"))))
;(setq tex-start-of-header "\\documentstyle")
;(setq tex-end-of-header "\\begin{document}")
;(setq tex-trailer "\\end{document}")
;;; TeX-mode
(setq tex-run-command "ptex")
(setq latex-run-command "platex")
(setq slitex-run-command "pslitex")
(setq tex-dvi-print-command "execvp - /dfs/c/wintex/bin/windvi.exe windvi.exe `bsd2dos.exe *`")
(setq tex-dvi-view-command "execvp - /dfs/c/wintex/bin/windvi.exe windvi.exe `bsd2dos.exe *`")



;;; ITS (Egg)
(setq load-path (cons "~/.elisp" load-path))
(require 'atok-hira nil t)
(require 'atok-kata nil t)



;;; W3
(setq url-keep-history t)
(setq url-be-asynchronous t)
(setq w3-default-homepage
	"file://localhost/usr/share/doc/ja/handbook/handbook.html")



;;; GLOG
(autoload 'glog                  "glog" "View BBS log mode." t)
(autoload 'glog-view-file-mode   "glog" "view file as BBS log." t)
(autoload 'glog-view-buffer-mode "glog" "view buffer as BBS log." t)
(autoload 'glog-batch-view       "glog" "like viewer." t)



;;; make buffers readonly from drag&drop or emacsclient
(setq bowpad-drag-and-drop-format "\C-[!!\C-x\C-r%s\r!")
;(add-hook 'server-switch-hook 'vc-toggle-read-only)
(add-hook 'server-switch-hook 'toggle-read-only)



;;; mail reply
(define-key global-map "\C-cm" "\C-xb~/t1.txt\C-m\C-x\C-w")
(define-key global-map "\C-c]" "\M-<\C-u8\C-n\M-<\C-w\C-m\C-u60\C-xf\C-x\C-m\C-f")



;;; Tips
;(set-fill-column 72)
;(put 'upcase-region 'disabled nil)
;(put 'downcase-region 'disabled nil)
;(setq default-tab-width 8)
;(cd "~")
;;; others
;(setq default-tab-width 4)

;(define-key -map "" ')
;(substitute-key-definition ' ' -map)
;(global-set-key "" ')

(put 'downcase-region 'disabled nil)
(put 'eval-expression 'disabled nil)
(setq auto-mode-alist (cons '("\\.pl\\'" . perl-mode) auto-mode-alist))
(put 'narrow-to-region 'disabled nil)
;(shell)
;(set-file-coding-system-for-read '*sjis*dos)

(setq homedir (getenv "HOME"))
(if (featurep 'meadow)
    (let ()
      (setq homedir (replace-regexp-in-string "^/\\([a-zA-Z]\\)/" "\\1:/" homedir))
      (setenv "HOME" homedir)))
(cd homedir)



;;; followings are autoconfigurated lines
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(sh-basic-offset 2)
 '(sh-indent-after-do (quote +))
 '(sh-indent-for-case-alt (quote +))
 '(sh-indent-for-case-label 0)
 '(sh-indent-for-do (quote -))
 '(sh-indent-for-then (quote -)))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
