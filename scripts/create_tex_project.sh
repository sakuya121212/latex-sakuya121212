#!/bin/bash

read -p "作成するプロジェクト名を入力してください: " NAME

if [ -z "$NAME" ]; then
  echo "プロジェクト名が空です。中断します。"
  exit 1
fi

DIR="projects/$NAME"

if [ -d "$DIR" ]; then
  echo "既に存在します: $DIR"
  exit 1
fi

echo "LaTeXエンジンを選択してください:"
echo "1. uplatex"
echo "2. pdflatex"
echo "3. lualatex"
read -p "番号を入力: " ENGINE

case $ENGINE in
  1) ENGINE_NAME="uplatex" ;;
  2) ENGINE_NAME="pdflatex" ;;
  3) ENGINE_NAME="lualatex" ;;
  *) echo "無効な選択です。中断します。"; exit 1 ;;
esac

mkdir -p "$DIR"

# テンプレートファイルをコピーして置換
cp "projects/templates/$ENGINE_NAME/template.tex" "$DIR/$NAME.tex"
cp "projects/templates/$ENGINE_NAME/.latexmkrc" "$DIR/.latexmkrc"
sed -i "s/{{NAME}}/$NAME/g" "$DIR/$NAME.tex"

echo "プロジェクトを作成しました: $DIR (エンジン: $ENGINE_NAME)"
