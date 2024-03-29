# gnupack_patches

GitHub branch: [https://github.com/oziidi/gnupack_patches](https://github.com/oziidi/gnupack_patches)

Patches for gnupack-pretest_devel-2017.11.19.  
gnupack allows Windows OS users to use cygwin and emacs in a ready-to-use manner.


## 使い方

* gnupack-pretest_devel-2017.11.19.exeを下記からダウンロード  
  [gnupack - ダウンロードファイル一覧](https://ja.osdn.net/projects/gnupack/releases/)  
  リンク先のウェブページで下記を探して「2017.11.19」をクリック  

  > リリース時刻: 2017-11-19 10:14
  > 2017.11.19 (4 個のファイル 表示)

* gnupack-pretest_devel-2017.11.19.exeをダブルクリックすると展開先のディレクトリをきかれるのでgnupackを運用したい任意のディレクトリを入力

* gnupack-pretest_devel-2017.11.19を展開した同じディレクトリにこのgnupack_patches/を配置。  
  ディレクトリの名前を「gnupack_patches」を「gnupkack」に変更。  
  下記は(C:)ドライブ直下に配置した場合の例

  ```
  (C:) --- ...
        | 
        |-- gnupack/
        |
        |-- gnupack-pretest_devel-2017.11.19/
        |
  ```

* C:\gnupack\fetch_gnupack_pretest_devel_2017-09-11.batを実行。  
  ダブルクリック or cmd.exeからの実行どちらでも可。  
  gnupack-pretest_devel-2017.11.19/から必要なファイルをgnupack/に取り込んでくれる。

* cygwinの取り込みは下記どちらかの方法で対応。
  1. C:\gnupack\fetch_gnupack_pretest_devel_2017-09-11.batの下記のコメントアウトを解除してフェッチを実行

     ```
     rem echo Fetch app\cygwin
     rem xcopy %dir_src%app\cygwin %dir_dst%app\cygwin %xcpyopt%
     ```
     
  2. [cygwin_gnupack](https://github.com/oziidi/cygwin_gnupack)を使う。
     「cygwin_gnupack」を「cygwin」と名前を変更して下記に配置：

     C:\gnupack\app\cygwin\

     配置すると

     C:\gnupack\app\cygwin\cygwin\bin

     というかんじのディレクトリ構造になる


## パッチの内容

* apt-cyg  
  下記GitHubリポジトリで公開されている最近のapt-cygを取り込み  
  [https://github.com/kou1okada/apt-cyg](https://github.com/kou1okada/apt-cyg)

* フォント
  migu-1mではなく、下記を使用。
  + 英語 ==> Fira Code
  + 日本語 ==> IPAexfont

* aspell  
  Windows向けにビルドされたGNU Aspell 0.50 (Win32 version)。  
  GNU Aspell 0.50 (Win32 version) ([http://aspell.net/win32/](http://aspell.net/win32/))  
  C:\gnupack\app\aspell\に配置してある。下記をダウンロードしてインストールしたもの：
  + Full installer (Released Dec 22, 2002)
  + aspell-en-0.50-2-3.exe

* cscope  
  Windows向けにビルドされたcscope-win32  
  cscope-win32 ([https://code.google.com/archive/p/cscope-win32/downloads?authuser=0](https://code.google.com/archive/p/cscope-win32/downloads?authuser=0))  
  ここから、cscope-15.8a-win64rev1-static.zipををダウンロードしてインストール、解凍して、  
  cscope.exeを下記に配置。  
  cscope-indexerも下記に配置済。  
  ```
  gnupack\app\cscope\
  ```
* emacs

  + 設定ファイル: home/.emacs.d/init.el

  + 拡張: home/.emacs.d/site-lisp/
    - grep-edit
    - howm
    - imenu-list
    - markdown-mode
    - moccur (color-moccur & moccur-edit)
    - redo+
    - text-adjust
    - xcscope

  + フォント設定

    | フォント種別 | 設定 |
    | :--- | :--- |
    | default | Fira Code |
    | variable-pitch (proportional) | Arial |
    | fixed-pitch | Fira Code |
    | tooltip | Arial |
    | 日本語 | IPAexGothic |

  + キーバインド

    | キーバインド | 関数 |
    | :--- | :--- |
    | C-. | tabbar-forward-tab |
    | C-, | tabbar-backward-tab |
    | C-x,, | howm-menu |
    | C-? | redo |
    | C-: | toggle-truncate-lines |
    | C-; | auto-fill-mode |
    | M-g | goto-line |
    | M-n | flymake-goto-next-error |
    | M-p | flymake-goto-prev-error |
    | M-o | occur-by-moccur |

  + app\cygiwin\emacs\share\emacs\25.2\lisp\org\org.el  
    C-,をtab切り替えに使えるように下記をコメントアウト  

    ```emacslisp
    (org-defkey org-mode-map [(control ?,)]     'org-cycle-agenda-files)
    ```

  + color-theme
    - busybee ==> 有効
    - emacs-21
    - dark-laptop
    - badwolf
    - high-contrast


* pandoc

  下記から pandoc-3.1.12.3-windows-x86_64.zip をダウンロードおよび解凍。  
  [https://github.com/jgm/pandoc/releases/tag/3.1.12.3](https://github.com/jgm/pandoc/releases/tag/3.1.12.3)  
  <br>
  解凍したフォルダ pandoc-3.1.12.3 の名前を pandoc に変更して、下記に配置。  

  ```
  gnupack\app\pandoc
  ```

  **emacsとの関連付け**  
  <br>
  gnupack\\startup_config.ini にて下記環境変数を設定。

  ```
   [Process Variable]
      ...
      MKDWCSS   = %ROOT_DIR%\app\script\github-markdown.css

      PATH = ...
  ```

  この環境変数を gnupack\\home\\.emacs.d\\init.el で下記のように取り出して markdown-mode.el の markdown-command に css ファイルの所在を設定。

  ``` emacs-lisp
  (with-eval-after-load 'markdown-mode

    (setq pandoc-cmd (concat "pandoc -s -f gfm t html5 -c " (getenv "MKDWCSS")))

    (custom-set-variables
     '(markdown-command pandoc-cmd)
     ...)
  ```

  emacsからpandocでmarkdownテキストをプレビューするには下記のどちらかを実行:  
  M-x (ESC-x or Alt-x) markdown-preview  
  or  
  C-c C-c p  


* vim  
  + 設定ファイル
    home/.vimrc  

  + colorschem  
    home/vimfiles/colors/*  
    有効なカラースキーム ==> badwolf。home/_gvimrcで設定。

  + プラグイン  

    - @anyakichiさんの下記プラグインを追加。  
      10年以上前に「あにゃログ」で見つけて、手元に残しておいたもの  

      | プラグイン | 配置場所 |
      | :--- | :--- |
      | vim-csutil | gnupack_patches\app\vim\plugins\vim-csutil\ |
      | vim-qfutil | gnupack_patches\app\vim\pluginsvim-qfutil\ |
      | vim-tabutil | gnupack_pathes\app\vim\pluginsvim-tabutil\ |

    - その他のプラグインを追加  

      | プラグイン | 配置場所 |
      | :--- | :--- |
      | cscope_maps | gnupack_patches\home\vimfiles\cscope_maps.vim |
      | gtags | gnupack_patches\home\vimfiles\gtags.vim |
      | QFixHowm |  gnupack_patches\app\vim\plugins\qfixapp\ |


## Link

[apt-cyg](https://github.com/kou1okada/apt-cyg)  
[vim-csutil](https://github.com/anyakichi/vim-csutil)  
[vim-qfutil](https://github.com/anyakichi/vim-qfutil|)  
[vim-tabutil](https://github.com/anyakichi/vim-tabutil)  
[cscope_maps.vim](https://github.com/joe-skb7/cscope-maps/blob/master/plugin/cscope_maps.vim)  
[gtags.vim](https://github.com/ivechan/gtags.vim)  
[QFixHowm](https://sites.google.com/site/fudist/Home/qfixhowm)  
[grep-edit](https://www.emacswiki.org/emacs/grep-edit.el)  
[howm](https://github.com/kaorahi/howm)  
[imenu-list](https://github.com/bmag/imenu-list)  
[markdown-mode](https://github.com/jrblevin/markdown-mode)  
[color-moccur](https://www.emacswiki.org/emacs/color-moccur.el)  
[moccur-edit](https://www.emacswiki.org/emacs/moccur-edit.el)  
[redo+](https://www.emacswiki.org/emacs/redo+.el)  
[text-adjust](https://github.com/uwabami/text-adjust.el)  
[cscope](https://sourceforge.net/projects/cscope/files/cscope/15.8a/)  
[cscope-win32](https://code.google.com/archive/p/cscope-win32/downloads?authuser=0)  
[xscope](https://github.com/dkogan/xcscope.el)  
[Emacs Theme](https://emacsthemes.com/)  
[Fira Code](https://github.com/tonsky/FiraCode)  
[IPAフォント](https://moji.or.jp/ipafont/ipafontdownload/)  
[GNU Aspell 0.50 (Win32 version)](http://aspell.net/win32/)  

<br>
<br>
gnupack-pretest_devel-2017.11.19を使う理由:

この次のバージョン2018.06.10からemacsのバージョンが26になり、aspell-0.50が使えなくなってしまうため。  
IMEパッチ適用済のemacsにしては動作が比較的安定している。

