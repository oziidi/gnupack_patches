;;; .emacs --- dot emacs file

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This file is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this file; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:

;;; Code:

;; oz20240127b: Change garbage collection setting
;; ADD START "oz20240127b"
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ Performance Tuning                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Apply garbage collection at reaching 256MB
(setq gc-cons-threshold 268435456)
;; ADD END   "oz20240127b"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ site-lisp                                                     ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(let ( (default-directory
         (file-name-as-directory (concat user-emacs-directory "site-lisp")))
       )
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path)
  )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - coding system                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; デフォルトの文字コード
(set-default-coding-systems 'utf-8-unix)

;; テキストファイル／新規バッファの文字コード
(prefer-coding-system 'utf-8-unix)

;; ファイル名の文字コード
(set-file-name-coding-system 'utf-8-unix)

;; キーボード入力の文字コード
(set-keyboard-coding-system 'utf-8-unix)

;; サブプロセスのデフォルト文字コード
(setq default-process-coding-system '(undecided-dos . utf-8-unix))

;; 環境依存文字 文字化け対応
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ key binding - keyboard                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Altキーを使用せずにMetaキーを使用（有効：t、無効：nil）
(setq w32-alt-is-meta t)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - input method                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; モードラインの表示文字列
(setq-default w32-ime-mode-line-state-indicator "[Aa] ")
(setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))

;; IME初期化
(w32-ime-initialize)

;; デフォルトIME
(setq default-input-method "W32-IME")

;; IME変更
(global-set-key (kbd "C-\\") 'toggle-input-method)

;; 漢字/変換キー入力時のエラーメッセージ抑止
(global-set-key (kbd "<M-kanji>") 'ignore)
(global-set-key (kbd "<kanji>") 'ignore)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - fontset                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240104a: Update font settings to be compatible with emacs 27.1 and later versions.
;; oz20231227a: Use both Japanese & English fonts.
;; ORG START "oz20231227a"
;; ;; デフォルト フォント
;; ;; (set-face-attribute 'default nil :family "Migu 1M" :height 110)
;; (set-face-font 'default "Migu 1M-11:antialias=standard")

;; ;; プロポーショナル フォント
;; ;; (set-face-attribute 'variable-pitch nil :family "Migu 1M" :height 110)
;; (set-face-font 'variable-pitch "Migu 1M-11:antialias=standard")

;; ;; 等幅フォント
;; ;; (set-face-attribute 'fixed-pitch nil :family "Migu 1M" :height 110)
;; (set-face-font 'fixed-pitch "Migu 1M-11:antialias=standard")

;; ;; ツールチップ表示フォント
;; ;; (set-face-attribute 'tooltip nil :family "Migu 1M" :height 90)
;; (set-face-font 'tooltip "Migu 1M-9:antialias=standard")
;; ORG END
;; CHG START "oz20231227a"
;; ORG START "oz20240104a"
;; Set default font
;; ;; (set-default-font "Inconsolata-12")
;; (set-default-font "Fira Code-10")
;; (set-fontset-font (frame-parameter nil 'font) 'japanese-jisx0208
;;                   '("IPAexGothic" . "unicode-bmp"))
;; ORG END   "oz20240104a"
;; CHG START "oz20240104a"
;; Set the default font
(set-face-attribute 'default nil :family "Fira Code" :height 110)

;; oz20240127c: Add font settings
;; ADD START "oz20240127c"
;; Set variable-pitch (proportional) font
(set-face-attribute 'variable-pitch nil :family "Arial" :height 110)

;; Set fixed-pitch font
(set-face-font 'fixed-pitch "Fira Code-11:antialias=standard")

;; Set tooltip font
(set-face-font 'tooltip "Arial-9:antialias=standard")
;; ADD END   "oz20240127c"

;; Set a font for characters other than ASCII ones
(set-fontset-font nil '(#x80 . #x10ffff) (font-spec :family "IPAexGothic" :registry "unicode-bmp" :lang 'ja))

;; Not to use the default font for symbols
(setq use-default-font-for-symbols nil)
;; CHG END   "oz20240104a"
;; CHG END   "oz20231227a"


;;; fontset

;; フォントサイズ調整
(global-set-key (kbd "C-<wheel-up>")   #'(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-=")            #'(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-<wheel-down>") #'(lambda() (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C--")            #'(lambda() (interactive) (text-scale-decrease 1)))

;; フォントサイズ リセット
(global-set-key (kbd "M-0") #'(lambda() (interactive) (text-scale-set 0)))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - frame                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(setq default-frame-alist
      (append '((width                . 85)  ; フレーム幅
                (height               . 38 ) ; フレーム高
             ;; (left                 . 70 ) ; 配置左位置
             ;; (top                  . 28 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 10 ) ; 左フリンジ幅
                (right-fringe         . 11 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (tool-bar-lines       . 1  ) ; ツールバー
                (vertical-scroll-bars . 1  ) ; スクロールバー
                (scroll-bar-width     . 17 ) ; スクロールバー幅
                (cursor-type          . box) ; カーソル種別
                (alpha                . 100) ; 透明度
                )
              default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

;; フレーム タイトル
(setq frame-title-format
      '("emacs " emacs-version (buffer-file-name " - %f")))

;; 初期画面の非表示（有効：t、無効：nil）
(setq inhibit-startup-message nil)
(setq inhibit-startup-screen nil)

;; フルスクリーン化
(global-set-key (kbd "<M-return>") 'toggle-frame-fullscreen)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - mode line                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; 行番号の表示（有効：t、無効：nil）
(line-number-mode t)

;; 列番号の表示（有効：t、無効：nil）
(column-number-mode t)

;; モードライン カスタマイズ
(setq-default
 mode-line-format
 `(
   ""
   w32-ime-mode-line-state-indicator
   " "
   mode-line-mule-info
   mode-line-modified
   mode-line-frame-identification
   mode-line-buffer-identification
   " "
   global-mode-string
   " %[("
   mode-name
   mode-line-process
   "%n"
   ")%] "
   (which-func-mode ("" which-func-format " "))
   (line-number-mode
    (:eval
     (format "L%%l/L%d " (count-lines (point-max) 1) )))
   (column-number-mode " C%c ")
   (-3 . "%p")
   )
 )
(setq mode-line-frame-identification " ")

;; cp932エンコードの表記変更
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;; UTF-8エンコードの表記変更
(coding-system-put 'utf-8 :mnemonic ?U)
(coding-system-put 'utf-8-with-signature :mnemonic ?u)

;; 改行コードの表記追加
(setq eol-mnemonic-dos       ":Dos ")
(setq eol-mnemonic-mac       ":Mac ")
(setq eol-mnemonic-unix      ":Unx ")
(setq eol-mnemonic-undecided ":??? ")


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - buffer                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20231227b: Enable truncate long line by default.
;;              https://www.emacswiki.org/emacs/TruncateLines
;; ORG START
;; ;; バッファ画面外文字の切り詰め表示（有効：t、無効：nil）
;; (setq truncate-lines nil)
;; ORG END
;; CHG START
(set-default 'truncate-lines t)
;; CHG END

;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示（有効：t、無効：nil）
(setq truncate-partial-width-windows nil)

;; 同一バッファ名にディレクトリ付与
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; oz20231227c: Do not display newline symbol at wrapping text.
;; ADD START
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil) ;; no continuation indicators
      ;; '(nil right-curly-arrow) ;; right indicator only
      ;; '(left-curly-arrow nil) ;; left indicator only
      ;; '(left-curly-arrow right-curly-arrow) ;; default
      )
;; ADD END

;; oz20231227d: Change line wrap with a key bind
;; ADD START "oz20231227d"
;; oz20240113a: Change keybind of toggle-truncate-lines
;;              to use the default func binded with "C-l".
;; ORG START "oz20240113a"
;; (define-key global-map (kbd "C-l") 'toggle-truncate-lines)
;; ORG END   "oz20240113a"
;; CHG START "oz20240113a"
(define-key global-map (kbd "C-:") 'toggle-truncate-lines)
;; CHG END   "oz20240113a"
;; ADD END   "oz20231227d"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - minibuffer                                           ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; minibufferのアクティブ時、IMEを無効化
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (deactivate-input-method)))
(wrap-function-to-control-ime 'y-or-n-p nil nil)
(wrap-function-to-control-ime 'map-y-or-n-p nil nil)
(wrap-function-to-control-ime 'read-char nil nil)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - cursor                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; カーソルの点滅（有効：1、無効：0）
(blink-cursor-mode 0)

;; 非アクティブウィンドウのカーソル表示（有効：t、無効：nil）
(setq-default cursor-in-non-selected-windows t)

;; IME無効／有効時のカーソルカラー定義
(unless (facep 'cursor-ime-off)
  (make-face 'cursor-ime-off)
  (set-face-attribute 'cursor-ime-off nil
                      :background "DarkRed" :foreground "White")
  )
(unless (facep 'cursor-ime-on)
  (make-face 'cursor-ime-on)
  (set-face-attribute 'cursor-ime-on nil
                      :background "DarkGreen" :foreground "White")
  )

;; IME無効／有効時のカーソルカラー設定
(advice-add 'ime-force-on
            :before (lambda (&rest args)
                      (if (facep 'cursor-ime-on)
                          (let ( (fg (face-attribute 'cursor-ime-on :foreground))
                                 (bg (face-attribute 'cursor-ime-on :background)) )
                            (set-face-attribute 'cursor nil :foreground fg :background bg) )
                        )
                      ))
(advice-add 'ime-force-off
            :before (lambda (&rest args)
                      (if (facep 'cursor-ime-off)
                          (let ( (fg (face-attribute 'cursor-ime-off :foreground))
                                 (bg (face-attribute 'cursor-ime-off :background)) )
                            (set-face-attribute 'cursor nil :foreground fg :background bg) )
                        )
                      ))

;; バッファ切り替え時の状態引継ぎ設定（有効：t、無効：nil）
(setq w32-ime-buffer-switch-p t)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - linum                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'linum)

;; 行移動を契機に描画
(defvar linum-line-number 0)
(declare-function linum-update-current "linum" ())
(defadvice linum-update-current
    (around linum-update-current-around activate compile)
  (unless (= linum-line-number (line-number-at-pos))
    (setq linum-line-number (line-number-at-pos))
    ad-do-it
    ))

;; バッファ中の行番号表示の遅延設定
(defvar linum-delay nil)
(setq linum-delay t)
(defadvice linum-schedule (around linum-schedule-around () activate)
  (run-with-idle-timer 1.0 nil #'linum-update-current))

;; 行番号の書式
(defvar linum-format nil)
(setq linum-format "%5d")

;; バッファ中の行番号表示（有効：t、無効：nil）
(global-linum-mode t)

;; 文字サイズ
(set-face-attribute 'linum nil :height 0.75)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - tabbar                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'tabbar)

;; tabbar有効化（有効：t、無効：nil）
(call-interactively 'tabbar-mode t)

;; ボタン非表示
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil) (cons "" nil)))
  )

;; タブ切替にマウスホイールを使用（有効：0、無効：-1）
(call-interactively 'tabbar-mwheel-mode -1)
(remove-hook 'tabbar-mode-hook      'tabbar-mwheel-follow)
(remove-hook 'mouse-wheel-mode-hook 'tabbar-mwheel-follow)

;; タブグループを使用（有効：t、無効：nil）
(defvar tabbar-buffer-groups-function nil)
(setq tabbar-buffer-groups-function nil)

;; タブの表示間隔
(defvar tabbar-separator nil)
(setq tabbar-separator '(1.0))

;; タブ切り替え
;; oz20231227e: Change keybinds to switch tabs.
;; ORG START
;; (global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
;; (global-set-key (kbd "C-q")     'tabbar-backward-tab)
;; ORG END
;; CHG START
(global-set-key (kbd "C-.") 'tabbar-forward-tab)
(global-set-key (kbd "C-,") 'tabbar-backward-tab)
;; CHG END


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ search - isearch                                              ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; 大文字・小文字を区別しないでサーチ（有効：t、無効：nil）
(setq-default case-fold-search nil)

;; インクリメント検索時に縦スクロールを有効化（有効：t、無効：nil）
(setq isearch-allow-scroll nil)

;; C-dで検索文字列を一文字削除
(define-key isearch-mode-map (kbd "C-d") 'isearch-delete-char)

;; C-yで検索文字列にヤンク貼り付け
(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill)

;; C-eで検索文字列を編集
(define-key isearch-mode-map (kbd "C-e") 'isearch-edit-string)

;; Tabで検索文字列を補完
(define-key isearch-mode-map (kbd "TAB") 'isearch-yank-word)

;; C-gで検索を終了
(define-key isearch-mode-map (kbd "C-g")
  #'(lambda() (interactive) (isearch-done)))

;; 日本語の検索文字列をミニバッファに表示
(define-key isearch-mode-map (kbd "<compend>")
  #'(lambda() (interactive) (isearch-update)))
(define-key isearch-mode-map (kbd "<kanji>")
  'isearch-toggle-input-method)
(add-hook
 'isearch-mode-hook
 #'(lambda() (setq w32-ime-composition-window (minibuffer-window)))
 )
(add-hook
 'isearch-mode-end-hook
 #'(lambda() (setq w32-ime-composition-window nil))
 )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - hiwin                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; 他のウィンドウに色を付け、選択中のウィンドウをわかりやすくする
(require 'hiwin)

;; hiwin-modeを有効化
(hiwin-activate)

;; oz20240119a: Tune hiwin color to paint an inactive buffer
;; ADD START "oz20240119a"
;; busybee
(set-face-background 'hiwin-face "#282828")
;; ADD END   "oz20240119a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ search - migemo                                               ;;;
;;;   https://github.com/emacs-jp/migemo                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'migemo)

;; (defvar migemo-command nil)
;; (setq migemo-command "cmigemo")

;; (defvar migemo-options nil)
;; (setq migemo-options '("-q" "--emacs"))

;; (defvar migemo-dictionary nil)
;; (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

;; (defvar migemo-user-dictionary nil)

;; (defvar migemo-regex-dictionary nil)

;; (defvar migemo-coding-system nil)
;; (setq migemo-coding-system 'utf-8-unix)

;; (load-library "migemo")
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
(autoload 'migemo-init "migemo" nil t)

(with-eval-after-load 'migemo
  (defvar migemo-command nil)
  (setq migemo-command "cmigemo")

  (defvar migemo-options nil)
  (setq migemo-options '("-q" "--emacs"))

  (defvar migemo-dictionary nil)
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

  (defvar migemo-user-dictionary nil)

  (defvar migemo-regex-dictionary nil)

  (defvar migemo-coding-system nil)
  (setq migemo-coding-system 'utf-8-unix)
)

(add-hook 'emacs-startup-hook 'migemo-init)
;; CHG END   "oz20240202a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ file - backup                                                 ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ファイルオープン時のバックアップ（~）（有効：t、無効：nil）
(setq make-backup-files   t)  ;; 自動バックアップの実行有無
(setq version-control     t)  ;; バックアップファイルへの番号付与
(setq kept-new-versions   3)  ;; 最新バックアップファイルの保持数
(setq kept-old-versions   0)  ;; 最古バックアップファイルの保持数
(setq delete-old-versions t)  ;; バックアップファイル削除の実行有無

;; ファイルオープン時のバックアップ（~）の格納ディレクトリ
;; oz20240329a: Change emacs backup & auto-save directories
;; ORG START "oz20240329a"
;; (setq backup-directory-alist
;;       (cons (cons "\\.*$" (expand-file-name "/tmp/emacsbk"))
;;             backup-directory-alist))
;; ORG END   "oz20240329a"
;; CHG START "oz20240329a"
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))
;; CHG END   "oz20240329a"

;; 編集中ファイルの自動バックアップ（有効：t、無効：nil）
(setq backup-inhibited nil)

;; 終了時に自動バックアップファイルを削除（有効：t、無効：nil）
(setq delete-auto-save-files nil)

;; 編集中ファイルのバックアップ（有効：t、無効：nil）
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;; 編集中ファイルのバックアップ間隔（秒）
(setq auto-save-timeout 3)

;; 編集中ファイルのバックアップ間隔（打鍵）
(setq auto-save-interval 100)

;; 編集中ファイル（##）の格納ディレクトリ
;; oz20240329a: Change emacs backup & auto-save directories
;; ORG START "oz20240329a"
;; (setq auto-save-file-name-transforms
;;       `((".*" ,(expand-file-name "/tmp/emacsbk") t)))
;; ORG END   "oz20240329a"
;; CHG START "oz20240329a"
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/auto-save/") t)))
;; CHG END   "oz20240329a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ file - lockfile                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ロックファイルを生成（有効：t、無効：nil）
(setq create-lockfiles nil)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ scroll                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; スクロール時のカーソル位置を維持（有効：t、無効：nil）
(setq scroll-preserve-screen-position t)

;; スクロール開始の残り行数
(setq scroll-margin 0)

;; スクロール時の行数
(setq scroll-conservatively 10000)

;; スクロール時の行数（scroll-marginに影響せず）
(setq scroll-step 0)

;; 画面スクロール時の重複表示する行数
(setq next-screen-context-lines 1)

;; キー入力中の画面更新を抑止（有効：t、無効：nil）
(setq redisplay-dont-pause t)

;; recenter-top-bottomのポジション
(setq recenter-positions '(middle top bottom))

;; 横スクロール開始の残り列数
(setq hscroll-margin 1)

;; 横スクロール時の列数
(setq hscroll-step 1)

;; スクロールダウン
(global-set-key (kbd "C-z") 'scroll-down)

;; バッファの最後までスクロールダウン
(defadvice scroll-down (around scroll-down activate compile)
  (interactive)
  (let (
        (bgn-num (+ 1 (count-lines (point-min) (point))))
        )
    (if (< bgn-num (window-height))
        (goto-char (point-min))
      ad-do-it) ))

;; バッファの先頭までスクロールアップ
(defadvice scroll-up (around scroll-up activate compile)
  (interactive)
  (let (
        (bgn-num (+ 1 (count-lines (point-min) (point))))
        (end-num nil)
        )
    (save-excursion
      (goto-char (point-max))
      (setq end-num (+ 1 (count-lines (point-min) (point))))
      )
    (if (< (- (- end-num bgn-num) (window-height)) 0)
        (goto-char (point-max))
      ad-do-it) ))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ shell                                                         ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'shell)
;; (setq explicit-shell-file-name "bash.exe")
;; (setq shell-command-switch "-c")
;; (setq shell-file-name "bash.exe")
;; ;; (setq explicit-bash.exe-args '("--login" "-i"))

;; ;; (M-! and M-| and compile.el)
;; (setq shell-file-name "bash.exe")
;; (modify-coding-system-alist 'process ".*sh\\.exe" 'utf-8)
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
(autoload 'shell "shell" nil t)
(with-eval-after-load 'shell
  (setq explicit-shell-file-name "bash.exe")
  (setq shell-command-switch "-c")
  (setq shell-file-name "bash.exe")
  (modify-coding-system-alist 'process ".*sh\\.exe" 'utf-8)
  )
;; CHG END   "oz20240202a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ package manager                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; DEL START "oz20230109a"
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (package-initialize)
;; DEL END   "oz20230109a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ theme                                                         ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; テーマ格納ディレクトリのパス追加
(add-to-list 'custom-theme-load-path
             (file-name-as-directory (concat user-emacs-directory "theme"))
             )

;; テーマ選択
;; (load-theme 'solarized-light t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'gnupack-dark t)

;; oz20231227f: Add themes
;; ADD START
;; (load-theme 'emacs-21 t)
;; (load-theme 'dark-laptop t)
;; (load-theme 'badwolf t)
(load-theme 'busybee t)
;; (load-theme 'high-contrast t)
;; ADD END

;; oz20231227g: Tune colors on the mode line for busybee
;; ADD START
(set-face-foreground 'mode-line "gray30")
(set-face-background 'mode-line "gray85")
(set-face-foreground 'mode-line-inactive "gray30")
(set-face-background 'mode-line-inactive "gray85")
(set-face-foreground 'mode-line-buffer-id "gray30")
(set-face-background 'mode-line-buffer-id "gray85")
;; ADD END


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ server                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ;; emacs-server起動
;; (require 'server)
;; (defun server-ensure-safe-dir (dir) "Noop" t)
;; (setq server-socket-dir "~/.emacs.d")
;; (unless (server-running-p)
;;   (server-start)
;; )


;; oz20231227h: Add extensions
;; ADD START

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ aspell                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'ispell)

;; (add-to-list 'exec-path "/app/aspell/bin")
;; (setq-default ispell-program-name "aspell")

;; ;; For a case to check English text spells in .tex doc including Japanese texts as well
;; (eval-after-load "ispell"
;;   '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
(with-eval-after-load 'ispell
 (add-to-list 'exec-path "/app/aspell/bin")
 (setq-default ispell-program-name "aspell")

 ;; For a case to check English text spells in .tex doc including Japanese texts as well
 (eval-after-load "ispell"
   '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
 )
;; CHG END   "oz20240202a"

;; UNDER REVIEW START "impact for cpu load"
;; ;; flyspell automatic start
;; (setq-default flyspell-mode t)
;; (mapc (lambda (hook) (add-hook hook 'flyspell-prog-mode))
;;       '(
;;         c-mode-common-hook
;;         emacs-lisp-mode-hook
;;         ))
;; (mapc (lambda (hook) (add-hook hook '(lambda () (flyspell-mode 1))))
;;       '(text-mode-hook))
;; UNDER REVIEW END


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ flymake                                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'flymake)

;; ;; Enable flymake for all files
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; ;; Appearance
;; (add-hook 'flymake-mode-hook
;;           (lambda ()
;;             (set-face-attribute 'flymake-errline nil
;;                                 :underline "red"
;;                                 :weight 'bold
;;                                 :background nil)
;;             (set-face-attribute 'flymake-warnline nil
;;                                 :underline "yellow"
;;                                 :weight 'bold
;;                                 :background nil)
;;             ))

;; ;; Move to warning/error lines with M-p/M-n
;; (global-set-key "\M-p" 'flymake-goto-prev-error)
;; (global-set-key "\M-n" 'flymake-goto-next-error)

;; ;; Display warning/error lines
;; (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

;; ;; Check function with Makefile
;; (defun flymake-simple-generic-init (cmd &optional opts)
;;   (let* ((temp-file  (flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list cmd (append opts (list local-file)))))

;; ;; Don't display warnings in GUI
;; (setq flymake-gui-warnings-enabled nil)

;; ;; Also apply syntax checks for header files
;; (push '("\\.h\\'" flymake-simple-make-init flymake-master-cleanup)
;;       flymake-allowed-file-name-masks)

;; ;; UNDER REVIEW START
;; ;; ;; Show error in minibuffer
;; ;; (defun flymake-show-help ()
;; ;;   (when (get-char-property (point) 'flymake-overlay)
;; ;;     (let ((help (get-char-property (point) 'help-echo)))
;; ;;       (if help (message "%s" help)))))
;; ;; (add-hook 'post-command-hook 'flymake-show-help)
;; ;; UNDER REVIEW END
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
(with-eval-after-load 'flymake
;; oz20240205a: Add maintenance to flymake
;; DEL START "oz20240205a"
;;  ;; Enable flymake for all files
;;  (add-hook 'find-file-hook 'flymake-find-file-hook)
;; DEL END   "oz20240205a"

  ;; Appearance
  (add-hook 'flymake-mode-hook
            (lambda ()
              (set-face-attribute 'flymake-errline nil
                                  :underline "red"
                                  :weight 'bold
                                  :background nil)
              (set-face-attribute 'flymake-warnline nil
                                  :underline "yellow"
                                  :weight 'bold
                                  :background nil)
              ))

  ;; Move to warning/error lines with M-p/M-n
  (global-set-key "\M-p" 'flymake-goto-prev-error)
  (global-set-key "\M-n" 'flymake-goto-next-error)

  ;; Display warning/error lines
  (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

;; DEL START "oz20240205a"
;;  ;; Check function with Makefile
;;  (defun flymake-simple-generic-init (cmd &optional opts)
;;    (let* ((temp-file  (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;           (local-file (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;      (list cmd (append opts (list local-file)))))
;; DEL END   "oz20240205a"

  ;; Don't display warnings in GUI
  (setq flymake-gui-warnings-enabled t)

  ;; Also apply syntax checks for header files
  (push '("\\.h\\'" flymake-simple-make-init flymake-master-cleanup)
        flymake-allowed-file-name-masks)

  ;; UNDER REVIEW START
  ;; ;; Show error in minibuffer
  ;; (defun flymake-show-help ()
  ;;   (when (get-char-property (point) 'flymake-overlay)
  ;;     (let ((help (get-char-property (point) 'help-echo)))
  ;;       (if help (message "%s" help)))))
  ;; (add-hook 'post-command-hook 'flymake-show-help)
  ;; UNDER REVIEW END
)

;; oz20240328a: Enable flymake-mode manually
;; CHG START "oz20240328a"
(global-set-key (kbd "C-^") 'flymake-mode)
;; CHG END   "oz02240328a"
;; ORG START "oz20240328a"
;; ORG START "oz20240205a"
;; (add-hook 'c-mode-hook (lambda () (flymake-mode t)))
;; ORG END   "oz20240205a"
;; CHG START "oz20240205a"
;; (add-hook 'c-mode-hook
;;           (lambda()
;;             (if (file-exists-p "Makefile")
;;                 (flymake-mode t)
;;               )
;;             )
;;           )
;; CHG END   "oz20240205a"
;; ORG END   "oz20240328a"

;; CHG END   "oz20240202a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ xcscope                                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'xcscope)
;; (cscope-setup)
;; (setq cscope-do-not-update-database t)
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
;; (setq cscope-program “gtags-cscope”)
(autoload 'cscope-minor-mode "xcscope" nil t)
(with-eval-after-load 'cscope

  (setq cscope-do-not-update-database t)

)

(add-hook 'c-mode-hook 'cscope-minor-mode)
;; CHG END   "oz20240202a"


;; oz20240204d: DELTE wgrep
;; DEL START "oz20240204d"
;; ;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;; ;;; @ wgrep                                                         ;;;
;; ;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ;; Search by M-x grep.
;; ;; Type 'r' in the grep result buffer to enter the edit mode.
;; ;; Save by C-x C-s.
;; ;; Exit without save by C-x C-k.

;; (require 'wgrep)
;; (setq wgrep-enable-key "r")
;; DEL END


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ moccur                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; occur search by M-o
;; grep by M-x moccur-grep-find
;; Type 'r' in the grep result buffer to eneter the edit mode.
;; Save by C-x C-s.
;; Exit without save by C-x C-k.

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'color-moccur)
;; (global-set-key (kbd "M-o") 'occur-by-moccur)
;; (setq moccur-split-word t)
;; (setq moccur-use-migemo t)
;; (require 'moccur-edit)
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"

;; For color-moccur
(global-set-key (kbd "M-o") 'occur-by-moccur)
(autoload 'occur-by-moccur "color-moccur" nil t)
(autoload 'moccur-grep "color-moccur" nil t)
(autoload 'moccur-grep-find-subdir "color-moccur" nil t)
(autoload 'moccur-grep-find "color-moccur" nil t)
(with-eval-after-load 'color-moccur
  (setq moccur-split-word t)
  (setq moccur-use-migemo t)
)

;; For moccur-edit
(autoload 'moccur-edit-mode-in "moccur-edit" nil t)

;; CHG END   "oz20240202a"

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ autoinsert                                                    ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'autoinsert)

;; Location of template files
;; oz20240204a: Fix template directory path
;; ORG START "oz20240204a"
;; (setq auto-insert-directory "~/.emacs.d/template")
;; ORG END   "oz20240204a"
;; CHG START "oz20240204a"
(setq auto-insert-directory "~/template")
;; CHG END   "oz20240204a"

;; Change template according to file
(setq auto-insert-alist
      (nconc '(
               ("\\.c$" . ["new_template.c" my-template])
               ("\\.h$" . ["new_template.h" my-template])
               )
             auto-insert-alist))

(require 'cl)

;; Replace dummy keyword inside template files with the name of opened file
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"    . (lambda () (format "__%s_H__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
        (progn
          (goto-char (point-min))
          (replace-string (car c) (funcall (cdr c)) nil)))
    template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

(add-hook 'find-file-not-found-hooks 'auto-insert)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ gdb                                                           ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Open useful windows
(setq gdb-many-windows t)

;; Display the value of a variable at which the mouse cursor is being placed
(add-hook 'gdb-mode-hook #'(lambda () (gud-tooltip-mode t)))

;; Display I/O buffers to see standard input/output
(setq gdb-use-separate-io-buffer t)

;; Set 't' to this variable if you want values displayed on the mini buffer
(setq gud-tooltip-echo-area nil)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ c-mode                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; My C mode
(add-hook
 'c-mode-hook
 #'(lambda()
    (c-set-style "K&R")
    (setq tab-width 8)
    (setq indent-tabs-mode t)
    (setq c-basic-offset 8)
    (setq comment-start "//")
    (setq comment-end "")
    ))

;;
;; Other c-mode to use M-x "xxxx-c-mode"
;;

;; stm32-c-mode
(defun stm32-c-mode ()
  "C mode with adjusted defaults for use with STM32 MCU drivers."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  (setq comment-start "//")
  (setq comment-end "")
)

;; gnu-c-mode
(defun gnu-c-mode ()
  "GNU C mode."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  ;; comment style
  (setq comment-start "/*")
  (setq comment-end "*/")
  )

;;
;; An example from "Linux Kernel Coding Rule"
;;

;; linux-c-mode
;; This will define the M-x linux-c-mode command.When hacking on a
;; module, if you put the string -*- linux-c -*- somewhere on the first
;; two lines, this mode will be automatically invoked.
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8)
  )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ c++-mode                                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'google-c-style)
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a
(autoload 'google-set-c-style "google-c-style" nil t)
;; CHG END   "oz20240202a"
(add-hook 'c-mode-common-hook 'google-set-c-style)

;;
;; Another setting
;;

;; (defun my-c++-mode-hook ()
;;   (setq indent-tabs-mode nil)
;;   (setq c-basic-offset 2)
;;   )
;; (add-hook 'c++-mode-hook 'my-c++-mode-hook)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ text-mode                                                     ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Allow to add a tab character with the tab key in text-mode
(defun insert-tab-char ()
  "insert a tab char. (ASCII 9, \t)"
  (interactive)
  (insert "\t")
  )

;; Wrap longer line automatically
;; oz20240123a: Turn off auto fill by default
;; ORG START "oz20240123a"
;; (setq text-mode-hook 'turn-on-auto-fill)
;; ORG END   "oz20240123a"
;; CHG START "oz20240123a"
(setq text-mode-hook 'turn-off-auto-fill)
;; CHG END   "oz20240123a"
(add-hook 'text-mode-hook
          #'(lambda()
             (progn (set-fill-column 70)
                    (turn-on-auto-fill))))

;; oz20240113b: Enable/Disable auto-fill-mode by hand
;; ADD START "oz20240113b"
(define-key global-map (kbd "C-;") 'auto-fill-mode)
;; ADD END   "oz20240113b"

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ emacs-lisp-mode                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Don't insert a tab character with the tab key in emacs-lisp-mode
(add-hook
 'emacs-lisp-mode-hook
 #'(lambda() (setq indent-tabs-mode nil))
 )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ icf-mode                                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(defun icf-mode ()
  "IAR EWARM icf mode."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  ;; comment style
  (setq comment-start "/*")
  (setq comment-end "*/")
)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ sct-mode                                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(defun sct-mode ()
  "Keil EWARM sct mode."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  ;; comment style
  (setq comment-start ";")
  (setq comment-end "")
)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ ld-mode                                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(defun ld-mode ()
  "GNU LD linker script mode."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  ;; comment style
  (setq comment-start "/*")
  (setq comment-end "*/")
  )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ org-mode                                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240204c: Delete obsolete codes on org-mode
;; DEL START "oz20240204c"
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode")
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode/lisp")
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode/contrib/lisp")
;; DEL END   "oz20240204c"

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (add-hook 'org-mode-hook 'howm-mode)
;; (add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
;; (add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
;; (global-unset-key (kbd "C-x ,"))
;; (setq howm-prefix (kbd "C-x ,"))
;; (eval-after-load "howm-mode"
;;   '(progn
;;     (define-key howm-mode-map (kbd "C-c C-c") nil)))
;; (setq howm-use-color nil)
;; (setq org-startup-folded 'showall)
;; ;; (setq org-indent-mode-turns-on-hiding-stars nil)
;; ;; (setq org-indent-indentation-per-level 3)
;; ;; (add-hook 'org-mode-hook 'turn-off-auto-fill)
;; (setq org-src-fontify-natively t)
;; (setq org-fontify-quote-and-verse-blocks t)
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
(autoload 'org-mode "org" nil t)
(add-hook 'org-mode-hook 'howm-mode)
;; oz20240204f: Put together auto-mode-alist to one place
;; DEL START "oz20240204f"
;; (add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
;; (add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
;; DEL END
(with-eval-after-load 'org
  (setq org-startup-folded 'showall)
  (setq org-src-fontify-natively t)
  (setq org-fontify-quote-and-verse-blocks t)

  ;; UNDER REVIEW START
  ;; (setq org-indent-mode-turns-on-hiding-stars nil)
  ;; (setq org-indent-indentation-per-level 3)
  ;; (add-hook 'org-mode-hook 'turn-off-auto-fill)
  ;; UNDER REVIEW END
)
;; CHG END   "oz20240202a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ markdown-mode                                                 ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
;; oz20240114a: Add maintenance to markdown-mode
;; DEL START "oz20240114a"
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; DEL END   "oz20240114a"

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
;; ORG START "oz20240114a"
;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
;; ORG END   "oz20240114a"
;; CHG START "oz20240114a"
;; oz20240204f: Put together auto-mode-alist to one place
;; DEL START "oz20240204f"
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
;; DEL END   "oz20240204f"
;; CHG END   "oz20240114a"

(add-hook 'markdown-mode-hook 'turn-off-auto-fill)
;; ORG START "oz20240114a"
;; (setq markdown-fontify-code-blocks-natively t)
;; ORG END   "oz20240114a"
;; CHG START "oz20240114a"
(with-eval-after-load 'markdown-mode
  (setq pandoc-cmd (concat "pandoc -s -c " (getenv "MKDWCSS")))
  (custom-set-variables
   '(markdown-command pandoc-cmd)
   '(markdown-fontify-code-blocks-natively t)
   '(markdown-header-scaling t)
   '(markdown-indent-on-enter 'indent-and-new-item))
  (define-key markdown-mode-map (kbd "<S-tab>") #'markdown-shifttab)
  )
;; CHG END   "oz20240114a"


;; UNDER REVIEW START
;; ;; Tune header colors
;; (progn
;;   (custom-set-faces
;;    '(markdown-header-delimiter-face ((t (:inherit org-mode-line-clock))))
;;    '(markdown-header-face-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
;;    '(markdown-header-face-2 ((t (:inherit outline-2 :weight bold :height 1.2))))
;;    '(markdown-header-face-3 ((t (:inherit outline-3 :weight bold :height 1.1))))
;;    '(markdown-header-face-4 ((t (:inherit outline-4 :weight bold))))
;;    '(markdown-header-face-5 ((t (:inherit outline-5 :weight bold))))
;;    '(markdown-header-face-6 ((t (:inherit outline-6 :weight bold))))
;;    '(markdown-pre-face ((t (:inherit org-formula))))
;;    ))

;; ;; custom color
;; (defface markdown-header-face-1
;;   '((((class color) (background light))
;;      (:foreground "DeepPink1" :underline "DeepPink1" :weight bold))
;;     (((class color) (background dark))
;;      (:foreground "DeepPink1" :underline "DeepPink1" :weight bold)))
;;   "Face for level-1 headers.")

;; (defface markdown-header-face-2
;;   '((((class color) (background light))
;;      (:foreground "yellow1" :underline "yellow1" :weight bold))
;;     (((class color) (background dark))
;;      (:foreground "yellow1" :underline "yellow1" :weight bold)))
;;   "Face for level-2 headers.")

;; (defface markdown-header-face-3
;;   '((((class color) (background light))
;;      (:foreground "SlateBlue1" :underline "SlateBlue1" :weight bold))
;;     (((class color) (background dark))
;;      (:foreground "SlateBlue1" :underline "SlateBlue1" :weight bold)))
;;   "Face for level-3 headers.")

;; (defface markdown-header-face-4
;;   '((((class color) (background light))
;;      (:foreground "green" :underline "green" :weight bold))
;;     (((class color) (background dark))
;;      (:foreground "green" :underline "green" :weight bold)))
;;   "Face for level-4 headers.")

;; (defface markdown-header-face-5
;;   '((((class color) (background light))
;;      (:foreground "orange" :underline "orange" :weight bold))
;;     (((class color) (background dark))
;;      (:foreground "orange" :underline "orange" :weight bold)))
;;   "Face for level-5 headers.")

;; (defface markdown-header-face-6
;;   '((((class color) (background light))
;;      (:foreground "pink" :underline "pink" :weight bold))
;;     (((class color) (background dark))
;;      (:foreground "pink" :underline "pink" :weight bold)))
;;   "Face for level-6 headers.")
;; UNDER REVIEW END


;; oz20240407a: Tune shell script mode
;; ADD START "oz20240407a"
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ sh-mode                                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(defun turn-off-indent-tabs-mode ()
  (setq indent-tabs-mode nil))
(add-hook 'sh-mode-hook #'turn-off-indent-tabs-mode)

;; ADD END "oz20240407a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ auto-mode-alist                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; select mode according to file extension
(setq auto-mode-alist
      (append
       '(
         ("\\.c$"    . c-mode)
         ("\\.h$"    . c-mode)
         ("\\.cpp$"  . c++-mode)
         ("\\.cc$"   . c++-mode)
         ("\\.hh$"   . c++-mode)
         ("\\.el$"   . emacs-lisp-mode)
         ("\\.icf$"  . icf-mode)
         ("\\.sct$"  . sct-mode)
         ("\\.ld$"   . ld-mode)
         ("\\.txt$"  . org-mode)
         ("\\.md$'"  . gfm-mode)
         )
       auto-mode-alist))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ howm                                                          ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; ;; (add-to-list 'load-path "~/.emacs.d/site-lisp/howm/")
;; (setq howm-menu-lang 'ja)
;; (global-set-key (kbd "C-x , ,") 'howm-menu)
;; (autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)

;; (setq howm-home-directory "~/howm/")
;; (setq howm-keyword-file (concat howm-home-directory ".howm-keys"))
;; (setq howm-history-file (concat howm-home-directory ".howm-history"))

;; (setq howm-view-use-grep t)
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
;; oz20240305a: Fix a keybind to launch howm
;; ADD START "oz20240305a"
(global-unset-key (kbd "C-x ,"))
(setq howm-prefix (kbd "C-x ,"))
;; ADD END   "oz20240305a"
(global-set-key (kbd "C-x ,,") 'howm-menu)

(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
(with-eval-after-load 'howm
  (setq howm-menu-lang 'ja)
  (setq howm-home-directory "~/howm/")
  (setq howm-keyword-file (concat howm-home-directory ".howm-keys"))
  (setq howm-history-file (concat howm-home-directory ".howm-history"))
  (setq howm-view-use-grep t)
  (setq howm-use-color nil)
;; DEL START "oz20240305a"
;;  (global-unset-key (kbd "C-x ,"))
;;  (setq howm-prefix (kbd "C-x ,"))
;; DEL END   "oz20240305a"
)
;; CHG END   "oz20240202a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ pre-buffer-theme                                              ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; UNDER REVIEW START
;; ;; バッファ名やメジャーモードに応じてカラーテーマ(color-theme)を変更する
;; ;; http://emacs.rubikitch.com/per-buffer-theme/

;; (require 'per-buffer-theme)
;; (setq pre-buffer-theme/use-timer nil)
;; (setq per-buffer-theme/default-theme 'busybee)

;; ;; moe-dark, tangotango, cherry-blossom, soothe, flatland
;; (setq per-buffer-theme/themes-alist
;;       '(((:theme . badwolf)
;; ;;         (:buffernames . ("*scratch*"))
;;          (:modes . (org-mode)))
;;         ;; マッチしない場合は per-buffer-theme/default-theme を採用
;;         ))
;; ;; other-windowでもthemeを切り替えさせる
;; (defun per-buffer-theme--after-advice(&rest _)
;;   (per-buffer-theme/change-theme-if-buffer-matches))
;; ;; ウィンドウを切り替える他のコマンドでもアドバイスを追加する必要があるかもしれない
;; (advice-add 'other-window :after 'per-buffer-theme--after-advice)
;; UNDER REVIEW END


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ text-adjust                                                   ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; ORG START "oz20240202a"
;; (require 'text-adjust)

;; ;; 「？！」や全角空白を半角へ変換しないようにしたい
;; (setq text-adjust-hankaku-except "　？！＠ー〜、，。．")
;; ORG END   "oz20240202a"
;; CHG START "oz20240202a"
(autoload 'text-adjust "text-adjust" nil t)
(with-eval-after-load 'text-adjust
  ;; 「？！」や全角空白を半角へ変換しないようにしたい
  (setq text-adjust-hankaku-except "　？！＠ー〜、，。．")
)
;; CHG END   "oz20240202a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ imenu-list                                                    ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; oz20240202a: Optimize emacs startup
;; imenu-list.el has defun imenu-list () with ;;;##autoload
;; DEL START "oz20240202a"
;; (require 'imenu-list)
;; DEL END   "oz20240202a"

(with-eval-after-load 'imenu-list
  (define-key imenu-list-major-mode-map (kbd "j") 'next-line)
  (define-key imenu-list-major-mode-map (kbd "k") 'previous-line)
)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ pc-bufsw                                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Enable this part if tabbar is not used.

;;
;; Switch buffers with C-, & C-.
;;

;; (require 'pc-bufsw)

;; v1
;; (autoload 'pc-bufsw::lru "pc-bufsw" "pc-bufsw." t)
;; (autoload 'pc-bufsw::previous "pc-bufsw" "pc-bufsw." t)

;; v2
;; (global-set-key [?\C-,] 'pc-bufsw::lru)
;; (global-set-key [?\C-.] 'pc-bufsw::previous)

;; v3
;; (global-set-key (kbd "C-,") 'pc-bufsw-mru)
;; (global-set-key (kbd "C-.") 'pc-bufsw-lru)


;; oz20240113c: Add redo+
;; ADD START "oz20240113c"
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ redo                                                          ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'redo+)
;; oz20240207a: Change the keybind of redo
;; ORG START "20240207a"
;; (define-key global-map (kbd "C-z") 'redo)
;; ORG END   "20240207a"
;; CHG START "20240207a"
(define-key global-map (kbd "C-?") 'redo)
;; CHG END   "20240207a"
;; ADD END   "oz20240113c"


;; oz20240204e: Add grep-edit
;; ADD START "oz20240204e"
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ grep-edit                                                     ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; C-c C-e : apply the highlighting changes to files.
;; C-c C-u : All changes are ignored
;; C-c C-r : Remove the highlight in the region (The Changes doesn't

(with-eval-after-load 'grep
  (require 'grep-edit)
  (defadvice grep-edit-change-file (around inhibit-read-only activate)
    ""
    (let ((inhibit-read-only t))
      ad-do-it)
    )
)

;; ADD END   "oz20240204e"


;; oz20240330a: Add restart-emacs
;; ADD START "oz20240330a"
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ restart-emacs                                                 ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'restart-emacs)

;; ADD END   "oz20240330a"


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ preferences                                                   ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ;; Don't show splash screen after emacs booted
;; (setq inhibit-splash-screen t)

;; Inappropriate ioctl for device
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Start at "HOME" directory
;; (cd (getenv "HOME"))
;; (cd "~/")
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; Define system time locale
(setq system-time-locale "C")

;; Highlight corresponding parenthesis
(show-paren-mode t)

;; Quickly display key stroke at echo area
;(setq echo-keystrokes 0.1)

;; y instead of yes
(defalias 'yes-or-no-p 'y-or-n-p)

;; key bind for "goto-line"
(global-set-key "\M-g" 'goto-line)

;; Don't display grep: NUL: No such file or directory
(setq null-device "/dev/null")

;; ChangeLog header
(setq user-full-name "Oziidi")
(setq user-mail-address "oziidi76@gmail.com")

;; Diplay full-width space, tab, space at the end of line
;; Dark themes
(defface my-face-b-1 '((t (:foreground "gray10" :underline t))) nil)
;; (defface my-face-b-1 '((t (:foreground "gray30" :underline t))) nil)
(defface my-face-b-2 '((t (:background "gray14"))) nil)

;; emacs-21
;; (defface my-face-b-2 '((t (:background "light cyan"))) nil)

;; Meadow
;; (defface my-face-b-1 '((t (:background "bisque"))) nil)
;; (defface my-face-b-2 '((t (:background "LemonChiffon2"))) nil)

(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; Sort buffers with names in Buffer-menu-mode
(setq Buffer-menu-sort-column 4)

;; oz20240113d: Delete useless codes
;; DEL START "oz20240113d"
;; ;; Allocate C-z to redo
;; (global-set-key "\C-z" 'redo)
;; DEL END   "oz20240113d"

;; ;; Dont' show the initial message of the scratch buffer
;; (setq initial-scratch-message nil)

;; Display the current time on the mode line
(display-time-mode 1)

;; Disable automatic indent
(electric-indent-mode -1)

;; DEL START "oz20240127b"
;; ;; Apply garbage collection at reaching 256MB
;; (setq gc-cons-threshold 268435456)
;; DEL END   "oz20240127b"

;; Local Variables:
;; coding: utf-8
;; mode: emacs-lisp
;; End:
