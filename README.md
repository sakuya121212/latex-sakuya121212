# LaTeX Project Manager

このリポジトリは、LaTeXプロジェクトを簡単に作成、管理するためのツールです。プロジェクトの作成、削除、PDFからJPGへの変換などの機能を提供します。

## 開発環境のセットアップ

このリポジトリは、dev container を使用することを基本としています。必要な環境（LaTeX, Python, pdf2image など）が事前にセットアップされています。

### dev container の立ち上げ

1. VS Code を開き、[Dev Containers] 拡張機能をインストールしていることを確認してください。
2. リポジトリをクローンまたはダウンロードします。
3. VS Code でリポジトリのフォルダを開きます。
4. コマンドパレット（Ctrl+Shift+P）を開き、「Dev Containers: Reopen in Container」を選択します。
5. dev container が立ち上がるまで待機します。初回はイメージのダウンロードとセットアップに時間がかかります。

dev container 内でターミナルが使用可能になり、必要なツールがすべてインストールされています。

## 使用方法

dev container が立ち上がったら、以下のコマンドを実行します：

### プロジェクト作成
```bash
make project
```
プロンプトに従ってプロジェクト名を入力し、LaTeXエンジンを選択してください。

### プロジェクト削除
```bash
make delete
```
削除するプロジェクトを選択してください。

### PDFからJPG変換
```bash
make jpg
```
JPGに変換したいプロジェクトを選択してください。プロジェクト内のPDFファイルがJPGに変換されます。

## 例

### プロジェクト作成
```bash
$ make project
作成するプロジェクト名を入力してください: my_paper
LaTeXエンジンを選択してください (↑↓キーで移動, Enterで決定):
 > pdflatex
   lualatex
   uplatex
プロジェクトを作成しました: projects/my_paper (エンジン: pdflatex)
```

### プロジェクト削除
```bash
$ make delete
削除するプロジェクトを選択してください (↑↓キーで移動, Enterで決定):
 > my_paper
本当に 'my_paper' を削除しますか？ (y/N): y
プロジェクトを削除しました: my_paper
```

### PDFからJPG変換
```bash
$ make jpg
JPGに変換したいプロジェクトを選択してください (↑↓キーで移動, Enterで決定):
 > my_paper
選択されたプロジェクト: my_paper
変換中: my_paper.pdf...
  -> 保存完了: my_paper_page1.jpg
```

## 必要な環境

- Bashシェル
- LaTeX環境（TeX Live, MiKTeXなど） - pdflatex, lualatex, uplatex のいずれか
- Python 3 - PDFからJPG変換に必要
- pdf2imageライブラリ（`pip install pdf2image`） - PDF変換に必要
- Poppler（pdf2imageの依存ライブラリ）

## ファイル構造

- `Makefile`: 主要なコマンド（project, delete, jpg）の定義
- `scripts/`: スクリプトファイル
  - `create_tex_project.sh`: プロジェクト作成スクリプト
  - `delete_tex_project.sh`: プロジェクト削除スクリプト
  - `convert_tex_pdf_to_jpg.sh`: PDFからJPG変換スクリプト
  - `pdf_to_jpg.py`: PDF変換Pythonスクリプト
  - `common.sh`: 共通関数（選択UI）
- `projects/`: プロジェクト関連
  - `templates/`: LaTeXテンプレート
    - `pdflatex/`: pdflatex用テンプレート
    - `lualatex/`: lualatex用テンプレート
    - `uplatex/`: uplatex用テンプレート
  - `test/`: テストプロジェクト
- `build/`: ビルド出力用ディレクトリ（現在空）

## 注意事項

- プロジェクト名が空の場合、作成は中断されます。
- 同じ名前のプロジェクトが既に存在する場合、作成は中断されます。
- 削除時には確認プロンプトが表示されます。
- PDF変換はプロジェクトディレクトリ内の全PDFファイルを対象とし、600dpiの高解像度で変換します。
- テンプレートは基本的なarticleクラスを使用しています。必要に応じてカスタマイズしてください。
- VS Codeがインストールされている場合、作成後に.texファイルが自動で開きます。