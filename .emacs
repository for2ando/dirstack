;; for Meadow
(cond ((featurep 'meadow)
  ;;;; この節はmeadow付属の$(MEADOW)/dot.emacs.jaに由来する。
  ;;;;
  
  ;;; Mule-UCS の設定
  ;; ftp://ftp.m17n.org/pub/mule/Mule-UCS/ が オフィシャルサイトですが、
  ;; http://www.meadowy.org/~shirai/elisp/mule-ucs.tar.gz に既知のパッチ
  ;; をすべて適用したものがおいてあります。
  ;; (set-language-environment) の前に設定します
  (require 'jisx0213)
  
  
  ;;; 日本語環境設定
  (set-language-environment "Japanese")
  
  
  ;;; IMEの設定
  (mw32-ime-initialize)
  (setq default-input-method "MW32-IME")
  (setq-default mw32-ime-mode-line-state-indicator "[--]")
  (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (add-hook 'mw32-ime-on-hook
  	  (function (lambda () (set-cursor-height 2))))
  (add-hook 'mw32-ime-off-hook
  	  (function (lambda () (set-cursor-height 4))))
  
  
  ;;; カーソルの設定
  ;; (set-cursor-type 'box)            ; Meadow-1.10互換 (SKK等で色が変る設定)
  ;; (set-cursor-type 'hairline-caret) ; 縦棒キャレット
  
  
  ;;; マウスカーソルを消す設定
  (setq w32-hide-mouse-on-key t)
  (setq w32-hide-mouse-timeout 5000)
  
  
  ;;; font-lockの設定
  (global-font-lock-mode t)
  
  
  ;; ;;; TrueType フォント設定
  ;; (w32-add-font
  ;;  "private-fontset"
  ;;  '((spec
  ;;     ((:char-spec ascii :height 120)
  ;;      strict
  ;;      (w32-logfont "Courier New" 0 -13 400 0 nil nil nil 0 1 3 49))
  ;;     ((:char-spec ascii :height 120 :weight bold)
  ;;      strict
  ;;      (w32-logfont "Courier New" 0 -13 700 0 nil nil nil 0 1 3 49))
  ;;     ((:char-spec ascii :height 120 :slant italic)
  ;;      strict
  ;;      (w32-logfont "Courier New" 0 -13 400 0   t nil nil 0 1 3 49))
  ;;     ((:char-spec ascii :height 120 :weight bold :slant italic)
  ;;      strict
  ;;      (w32-logfont "Courier New" 0 -13 700 0   t nil nil 0 1 3 49))
  ;;     ((:char-spec japanese-jisx0208 :height 120)
  ;;      strict
  ;;      (w32-logfont "ＭＳ ゴシック" 0 -16 400 0 nil nil nil 128 1 3 49))
  ;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold)
  ;;      strict
  ;;      (w32-logfont "ＭＳ ゴシック" 0 -16 700 0 nil nil nil 128 1 3 49)
  ;;      ((spacing . -1)))
  ;;     ((:char-spec japanese-jisx0208 :height 120 :slant italic)
  ;;      strict
  ;;      (w32-logfont "ＭＳ ゴシック" 0 -16 400 0   t nil nil 128 1 3 49))
  ;;     ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
  ;;      strict
  ;;      (w32-logfont "ＭＳ ゴシック" 0 -16 700 0   t nil nil 128 1 3 49)
  ;;      ((spacing . -1))))))

  ;; (set-face-attribute 'variable-pitch nil :family "*")


  ;; ;;; BDF フォント設定
  ;;
  ;; ;;; (方法その1) Netinstall パッケージを使う方法
  ;; ;;; misc と intlfonts パッケージを入れます。
  ;; ;;; .emacsの設定
  ;; (setq bdf-use-intlfonts16 t)
  ;; (setq initial-frame-alist '((font . "intlfonts16")))
  ;;
  ;; ;;; (方法その1') 
  ;; ;;; intlfonts-file-16dot-alist の形式で bdf-fontset-alist を書き、
  ;; ;;; 次を設定すれば良い。
  ;; ;;;  (require 'bdf)
  ;; ;;;  (bdf-configure-fontset "bdf-fontset" bdf-fontset-alist)
  ;; ;;; 詳細は $MEADOW/pkginfo/auto-autoloads.el と $MEADOW/site-lisp/bdf.el を
  ;; ;;; 参照のこと。
  ;;
  ;; ;;; (方法その2) 
  ;; ;;; フォントの指定方法は次のサンプルを参考にする。
  ;; ;;; normal, bold, italic, bold-itaric フォントを指定する必要あり。
  ;; (setq bdf-font-directory "c:/Meadow/fonts/intlfonts/")
  ;; (w32-add-font "bdf-fontset"
  ;; `((spec 
  ;;    ;; ascii
  ;;    ((:char-spec ascii :height any :weight normal :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "lt1-16-etl.bdf" bdf-font-directory)))
  ;;    ((:char-spec ascii :height any :weight bold :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "lt1-16b-etl.bdf" bdf-font-directory)))
  ;;    ((:char-spec ascii :height any :weight normal :slant any)
  ;;     strict (bdf-font ,(expand-file-name "lt1-16i-etl.bdf" bdf-font-directory)))
  ;;    ((:char-spec ascii :height any :weight bold :slant any)
  ;;     strict (bdf-font ,(expand-file-name "lt1-16bi-etl.bdf" bdf-font-directory)))
  ;;    ;; katakana-jisx0201
  ;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
  ;;     ((encoding . 1-byte-set-msb))) 
  ;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
  ;;     ((encoding . 1-byte-set-msb))) 
  ;;    ((:char-spec katakana-jisx0201 :height any :weight normal :slant any)
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
  ;;     ((encoding . 1-byte-set-msb))) 
  ;;    ((:char-spec katakana-jisx0201 :height any :weight bold :slant any)
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))
  ;;     ((encoding . 1-byte-set-msb)))
  ;;    ;; latin-jisx0201
  ;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
  ;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
  ;;    ((:char-spec latin-jisx0201 :height any :weight normal :slant any) 
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory))) 
  ;;    ((:char-spec latin-jisx0201 :height any :weight bold :slant any) 
  ;;     strict (bdf-font ,(expand-file-name "8x16rk.bdf" bdf-font-directory)))
  ;;    ;; japanese-jisx0208
  ;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant normal) 
  ;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
  ;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant normal)
  ;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory))) 
  ;;    ((:char-spec japanese-jisx0208 :height any :weight normal :slant any)
  ;;     strict (bdf-font ,(expand-file-name "j90-16.bdf" bdf-font-directory)))
  ;;    ((:char-spec japanese-jisx0208 :height any :weight bold :slant any)
  ;;     strict (bdf-font ,(expand-file-name "j90-16b.bdf" bdf-font-directory))))))
  
  
  ;; 初期フレームの設定
  (setq default-frame-alist
        (append (list '(foreground-color . "black")
  		      '(background-color . "LemonChiffon")
		      '(background-color . "gray")
  		      '(border-color . "black")
  		      '(mouse-color . "white")
  		      '(cursor-color . "black")
  ;;		      '(ime-font . (w32-logfont "ＭＳ ゴシック"
  ;;					        0 16 400 0 nil nil nil
  ;;					        128 1 3 49)) ; TrueType のみ
  ;;		      '(font . "bdf-fontset")    ; BDF
  ;;		      '(font . "private-fontset"); TrueType
  		      '(width . 164)
  		      '(height . 40)
  		      '(top . 0)
  		      '(left . 0))
  	        default-frame-alist))
  
  
  ;; ;;; shell の設定
  
  ;; ;;; Cygwin の bash を使う場合
  (setq explicit-shell-file-name "bash.exe") 
  (setq shell-file-name "sh.exe") 
  (setq shell-command-switch "-c") 
  
  ;; ;;; Virtually UN*X!にある tcsh.exe を使う場合
  ;; (setq explicit-shell-file-name "tcsh.exe") 
  ;; (setq shell-file-name "tcsh.exe") 
  ;; (setq shell-command-switch "-c") 
  
  ;; ;;; WindowsNT に付属の CMD.EXE を使う場合。
  ;; (setq explicit-shell-file-name "CMD.EXE") 
  ;; (setq shell-file-name "CMD.EXE") 
  ;; (setq shell-command-switch "\\/c") 
  
  
  ;;; coding-system の設定
  ;; for Cygwin
  (modify-coding-system-alist 'process ".*sh\\.exe" 'japanese-shift-jis-unix)
  
  
  ;;; argument-editing の設定
  (require 'mw32script)
  (mw32script-init)
  
  
  ;; ;;; browse-url の設定
  ;; (global-set-key [S-mouse-2] 'browse-url-at-mouse)
  
  
  ;; ;;; 印刷の設定
  ;; ;; この設定で M-x print-buffer RET などでの印刷ができるようになります
  ;; ;;
  ;; ;;  notepad に与えるパラメータの形式の設定
  ;; (define-process-argument-editing "notepad"
  ;;   (lambda (x) (general-process-argument-editing-function x nil t)))
  ;;
  ;; (defun w32-print-region (start end
  ;; 				    &optional lpr-prog delete-text buf display
  ;; 				    &rest rest)
  ;;   (interactive)
  ;;   (let ((tmpfile (convert-standard-filename (buffer-name)))
  ;; 	     (w32-start-process-show-window t)
  ;; 	     ;; もし、dos 窓が見えていやな人は上記の `t' を `nil' にします
  ;; 	     ;; ただし、`nil' にすると Meadow が固まる環境もあるかもしれません
  ;; 	     (coding-system-for-write w32-system-coding-system))
  ;;     (while (string-match "[/\\]" tmpfile)
  ;; 	   (setq tmpfile (replace-match "_" t nil tmpfile)))
  ;;     (setq tmpfile (expand-file-name (concat "_" tmpfile "_")
  ;; 				         temporary-file-directory))
  ;;     (write-region start end tmpfile nil 'nomsg)
  ;;     (call-process "notepad" nil nil nil "/p" tmpfile)
  ;;     (and (file-readable-p tmpfile) (file-writable-p tmpfile)
  ;; 	      (delete-file tmpfile))))
  ;; 
  ;; (setq print-region-function 'w32-print-region)


  ;; ;;; fakecygpty の設定
  ;; ;; この設定で cygwin の仮想端末を要求するプログラムを Meadow から
  ;; ;; 扱えるようになります
  ;; (setq mw32-process-wrapper-alist
  ;;       '(("/\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
  ;; 	    (nil . ("fakecygpty.exe" . set-process-connection-type-pty)))))


))
;;; end of (not (null (featurep 'meadow)))

(cond ((not (featurep 'meadow))
       (set-display-coding-system '*sjis*)))

(setq load-path (cons "~/.elisp" load-path))

;;; for my hands
(define-key global-map "\C-?" 'backward-delete-char)
(define-key global-map [delete] 'delete-char)
(define-key emacs-lisp-mode-map [delete] 'delete-char)
(define-key lisp-interaction-mode-map [delete] 'delete-char)
(define-key global-map "\C-m" 'newline-and-indent)
(define-key global-map "\C-j" 'newline)
(define-key lisp-interaction-mode-map "\C-m" 'eval-print-last-sexp)
(define-key lisp-interaction-mode-map "\C-j" nil)
(define-key lisp-interaction-mode-map [return] "\C-e\C-m")
(define-key global-map "\C-z" 'shell)
(define-key global-map "\C-xg" 'goto-line)
(define-key global-map "\e&" 'query-replace-regexp)
(defun shell-command-on-region-to-current-buffer (start end command)
  "wrapper for shell-command-on-region: command output is inserted to current buffer"
  (interactive "*r\nsShell command on region: ")
  (shell-command-on-region start end command t nil))
(define-key global-map "\e|" 'shell-command-on-region-to-current-buffer)
(defun set-tab-width (w) "changes variable: tab-width's value"
  (interactive "Ntab-width: ")
  (setq tab-width w)
  (princ (concat "tab-width set to: " tab-width) t))
(defun set-default-tab-width (w) "changes variable: default-tab-width's value"
  (interactive "Ndefault-tab-width: ")
  (setq default-tab-width w)
  (princ (concat "default-tab-width set to: " default-tab-width) t))
(define-key global-map "\C-x\C-mt" 'set-tab-width)
(define-key global-map "\C-x\C-mT" 'set-default-tab-width)
(defun toggle-tab-width ()
  "toggles a value of variable: tab-width between 8 and 4"
  (interactive)
  (setq tab-width (cond ((eq tab-width 8) 4)
			(t 8)))
  (redraw-display)
  (princ (concat "tab-width: " tab-width)))
(define-key global-map "\C-x\C-m\C-t" 'toggle-tab-width)
(if (featurep 'meadow)
  (define-key global-map "\C-^" 'call-last-kbd-macro)
  (define-key global-map [?\C-=] 'call-last-kbd-macro)
)
(define-key global-map "\C-x\C-m\C-e" 'toggle-truncate-buffer)
(defun toggle-truncate-buffer ()
  "toggles a value of variable: truncate-lines"
  (interactive)
  (setq truncate-lines (not truncate-lines))
  (recenter))
;(define-key global-map [] ')

;;; new assignments
(define-key emacs-lisp-mode-map "\e\C-m" 'eval-last-sexp)
(define-key lisp-interaction-mode-map "\e\C-m" 'eval-last-sexp)
(define-key global-map "\C-c\C-a" 'compile)
(setq compile-command "make")
(if (not (featurep 'meadow))
  (define-key global-map [kanji] 'toggle-egg-mode))
(define-key global-map "\C-x\C-m\C-f" 'auto-fill-mode)
(define-key global-map "\C-x\C-m\C-r" 'toggle-read-only)
(define-key global-map "\C-x\C-m\C-l" 'describe-current-coding-system)
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
(set-auto-major-mode "\\.pl\\'" 'perl-mode)
(set-auto-major-mode "\\.l\\'" 'c-mode)
(set-auto-major-mode "\\.rd\\'" 'rd-mode)
(set-auto-major-mode "\\.rb\\'" 'ruby-mode)
(set-auto-major-mode "\\.js\\'" 'javascript-mode)
(autoload 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
(autoload 'ruby-mode "ruby-mode" "major mode for ruby script" t)
(autoload 'javascript-mode "javascript-mode" "major mode for javascript" t)

(setq interpreter-mode-alist
      (cons (cons "ruby" 'ruby-mode) interpreter-mode-alist))
(setq interpreter-mode-alist
      (cons (cons "rd2" 'rd-mode) interpreter-mode-alist))

;;; c-mode
(add-hook 'c-mode-hook
	  (function (lambda ()
		      (define-key c-mode-map "\C-?" 'backward-delete-char)
		      (define-key c-mode-map [delete] 'delete-char)
)))

;;; java-mode
(add-hook 'java-mode-hook
	  (function (lambda ()
		      (define-key java-mode-map "\C-c\C-m" 'compile)
)))

;;; ruby-mode
(add-hook 'ruby-mode-hook
	  (function (lambda ()
		      (define-key ruby-mode-map "\C-m"
			'ruby-reindent-then-newline-and-indent)
		      (define-key ruby-mode-map "\C-j" 'newline)
)))

;;; shell-script-mode
(add-hook 'sh-mode-hook
	  (function (lambda ()
		      (setq sh-indentation 2)
)))

;;; shell-mode
(add-hook 'shell-mode-hook
	  (function (lambda ()
		      (define-key shell-mode-map "\C-a" 'comint-bol)
		      (define-key shell-mode-map "\C-p" 'comint-previous-input)
		      (define-key shell-mode-map "\C-n" 'comint-next-input)
		      (define-key shell-mode-map "\M-p" 'comint-previous-matching-input-from-input)
		      (define-key shell-mode-map "\M-n" 'comint-next-matching-input-from-input)
		      (define-key shell-mode-map "\C-\M-p" 'comint-previous-matching-input-from-input)
		      (define-key shell-mode-map "\C-\M-n" 'comint-next-matching-input-from-input)
		      (define-key shell-mode-map "\C-z" 'end-of-buffer)
		      (setq scroll-conservatively 1024)
		      (setq tab-width 8)
		      (cd "~")
)))

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

;;; fence-mode
(add-hook 'fence-mode-hook
	  (function (lambda ()
		      (define-key fence-mode-map [delete] 'fence-delete-char)
		      (define-key fence-mode-map [escape] 'fence-cancel-input)
		      (define-key fence-mode-map [kanji] 'fence-toggle-egg-mode)
)))

;;; henkan-mode
(add-hook 'henkan-mode-hook
	  (function (lambda ()
		      (define-key henkan-mode-map [escape] 'henkan-quit)
		      ;;; emulating bunsetu shinshuku of atok in henkan-mode (experimental)
		      (define-key henkan-mode-map [down] 'henkan-forward-bunsetu)
		      (define-key henkan-mode-map [up] 'henkan-previous-kouho)
		      (define-key henkan-mode-map [right] 'henkan-bunsetu-nobasi-sho)
		      (define-key henkan-mode-map [left] 'henkan-bunsetu-chijime-sho)
					;(define-key henkan-mode-map [] ')
)))


;;; evernote-mode
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional
(require 'evernote-mode)
(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)
(global-set-key "\C-cep" 'evernote-post-region)
(global-set-key "\C-ceb" 'evernote-browser)


;;; c source coding style
(setq c-auto-newline nil)
(setq c-tab-always-indent nil)
(setq c-indent-level 4)
(setq c-continued-statement-offset c-indent-level)
(setq c-brace-offset -4)
(setq c-brace-imaginary-offset 0)
(setq c-argdecl-indent 2)
(setq c-label-offset (- c-indent-level))

;;; TeX
(setq tex-dvi-view-command
      (if (eq window-system 'x) "xdvi" "dvi2tty * | cat -s"))
(add-hook 'tex-shell-hook
	  (function (lambda ()
		      (setq tex-command "jlatex")
		      (setq latex-run-command "jlatex"))))
(setq tex-start-of-header "\\documentstyle")
(setq tex-end-of-header "\\begin{document}")
(setq tex-trailer "\\end{document}")

;;; ITS (Egg)
(require 'atok-hira nil t)
(require 'atok-kata nil t)

;;; W3
(setq url-keep-history t)
(setq url-be-asynchronous t)
(setq w3-default-homepage
	"file://localhost/usr/share/doc/ja/handbook/handbook.html")

;;; Emacs-w3m
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-antenna "w3m-antenna" "*Report change of WEB sites." t)
;(setq w3m-icon-directory (expand-file-name "etc/w3m" netinstall-pkg-dir))

;; Cygwin のドライブ・プレフィックスを有効に
(require 'cygwin-mount)
(cygwin-mount-activate)

;;; Tips
(set-fill-column 72)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq default-tab-width 8)

;;; followings are autoconfigurated lines
(put 'eval-expression 'disabled nil)
