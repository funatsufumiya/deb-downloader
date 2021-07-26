# deb-downloader

debファイルをpackages.debian.orgから手動ダウンロードする際のユーティリティスクリプト。使い方は `-h`。デフォルトではstretch、armhfをjpサーバからダウンロードするように設定。

- deb-search: パッケージを検索
- deb-dl: debファイルをカレントディレクトリにダウンロード
- deb-deps: 依存を列挙（注: deepには探索しない）
- deb-ftp-url: debファイルのURLを表示