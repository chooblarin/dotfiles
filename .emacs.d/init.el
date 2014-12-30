;; バッファーのデフォルトメジャーモードをLispインタプリタにする
(setq default-major-mode 'lisp-interaction-mode)
;; バッテリー残量表示
(display-battery-mode 1)
;;時刻表示
(display-time-mode 1)
;ビープ音を消す
(setq ring-bell-function 'ignore)
;; カラム番号を表示
(column-number-mode t)
;; TABの表示幅. 初期値は8
(setq-default tab-width 4)
;; ファイルサイズを表示
(size-indication-mode t)
;; タイトルバーにファイル名表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)
;; 最近使ったファイルをメニューに表示
(recentf-mode t)
;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)
;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)
;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; ウィンドウで開いた場合
(if window-system
    (progn	  
	  ;; asciiフォントをMenloに
	  (set-face-attribute 'default nil
						  :family "Menlo"
						  :height 120)
	  ;; 日本語フォントをヒラギノ明朝 Proに
	  (set-fontset-font
	   nil 'japanese-jisx0208
	   ;; 英語名の場合
	   ;; (font-spec :family "Hiragino Mincho Pro"))
	   (font-spec :family "ヒラギノ明朝 Pro"))
	  ;; ひらがなとカタカナをモトヤシーダに
	  ;; U+3000-303FCJKの記号および句読点
	  ;; U+3040-309Fひらがな
	  ;; U+30A0-30FFカタカナ
	  (set-fontset-font
	   nil '(#x3040 . #x30ff)
	   (font-spec :family "NfMotoyaCedar"))
	  ;; フォントの横幅を調節する
	  (setq face-font-rescale-alist
			'((".*Menlo.*" . 1.0)
			  (".*Hiragino_Mincho_Pro.*" . 1.2)
			  (".*nfmotoyacedar-bold.*" . 1.2)
			  (".*nfmotoyacedar-medium.*" . 1.2)
			  ("-cdac$" . 1.3))) 
	  
	  ;; スタートアップページを表示しない
      (setq inhibit-startup-message t)
      ;; tool-barを非表示
      (tool-bar-mode 0)
      ;; scroll-barを非表示
      (scroll-bar-mode 0)
      
      ;;起動時のフレームサイズを設定する
      (setq initial-frame-alist
			(append (list
					 '(width . 143)
					 '(height . 47)
					 )
					initial-frame-alist))
      ;; 背景を透過させる.
      (set-frame-parameter nil 'alpha 80)))

;; Emacs 23より前のバージョンを利用している方は
;; user-emacs-directory変数が未定義のため次の設定を追加
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf")

;; ELPAの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; anythingをrequire
; (require 'anything-startup)
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.3
   ;; タイプして再描写するまでの時間。デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)
  
  (when (require 'anything-config nil t)
	;; root権限でアクションを実行するときのコマンド
	;; デフォルトは"su"
	(setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)
  
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(require 'anything-migemo nil t))
  
  (when (require 'anything-complete nil t)
	;; lispシンボルの補完候補の再検索時間
	(anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)
  
  (when (require 'auto-install nil t)
	(require 'anything-auto-install nil t))
  
  (when (require 'descbinds-anything nil t)
	;; describe-bindingsをAnythingに置き換える
	(descbinds-anything-install)))

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; coffee-mode
(when (require 'coffee-mode)
  (defun coffee-custom ()
	"coffee-mode-hook"
	(and (set (make-local-variable 'tab-width) 2)
		 (set (make-local-variable 'coffee-tab-width) 2))
	))
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; Egg
(when (executable-find "git")
  (require 'egg nil t))

;; haskell-mode
(autoload 'haskell-mode "haskell-mode")
(autoload 'haskell-cabal "haskell-cabal")
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode))
(setq haskell-program-name "/usr/bin/ghci")


;; jedi (python)
(require 'epc)
(require 'auto-complete-config)
(require 'python)

(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(define-key python-mode-map (kbd "<C-tab>") 'jedi:complete)


;; gtags-modeのキーバインドを有効化する
(setq gtags-suggested-key-mapping t) ; 無効化する場合はコメントアウト
(require 'gtags nil t)


;; キーバインド設定
(define-key global-map (kbd "C-m") 'newline-and-indent)	; 改行とインデントを同時に行う
(define-key global-map (kbd "C-^") 'help-command) ; ヘルプコマンドをバインド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines) ; 行の折り返し表示を切り替える
(define-key global-map (kbd "M-n") (kbd "C-u 5 C-n")) ; 複数行移動（下
(define-key global-map (kbd "M-p") (kbd "C-u 5 C-p")) ; 複数行移動（上
(define-key global-map (kbd "M-[ 5 c") (kbd "M-f"))	  ; Ctrl+->
(define-key global-map (kbd "M-[ 5 D") (kbd "M-b"))	  ; Ctrl+<-
(define-key global-map (kbd "C-t") 'other-window) ; ウィンドウ切り替え
;; anything
(define-key global-map (kbd "C-x b") 'anything-for-files)
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
(define-key global-map (kbd "C-x M-x") 'anything-M-x)

;; カラーテーマ
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-dark-laptop))

;; 現在行のハイライト
;; (defface my-hl-line-face
;;     ;; 背景がdarkならば背景色を紺に
;;     '((((class color) (background dark))
;; 	        (:background "NavyBlue" t))
;; 	      ;; 背景がlightならば背景色を緑に
;; 	      (((class color) (background light))
;; 		        (:background "LightGoldenrodYellow" t))
;; 		      (t (:bold t)))
;; 	  "hl-line's my face")
;; (setq hl-line-face 'my-hl-line-face)
;; (global-hl-line-mode t)

;; 括弧の対応関係のハイライト
;; paren-mode：対応する括弧を強調して表示する
(setq show-paren-delay 1.0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t) ; 有効化
;; parenのスタイル: expressionは括弧内も強調表示
(setq show-paren-style 'expression)
;; フェイスを変更する
(set-face-foreground 'show-paren-match-face "black")
(set-face-background 'show-paren-match-face "color-222")

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
(add-to-list 'backup-directory-alist
			              (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
	        `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; オートセーブファイル作成までの秒間隔
(setq auto-save-timeout 15)
;; オートセーブファイル作成までのタイプ間隔
(setq auto-save-interval 60)

;; ファイルが #! から始まる場合、+xを付けて保存する
(add-hook 'after-save-hook
		  'executable-make-buffer-file-executable-if-script-p)

;; SQL サーバへ接続するためのデフォルト情報
(setq sql-user "root"
	  sql-database "test"
	  sql-server "localhost"
	  sql-product 'mysql)

;; Flymake設定
