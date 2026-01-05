#!/bin/bash

source scripts/common.sh

# --- メイン処理 ---

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

echo "LaTeXエンジンを選択してください (↑↓キーで移動, Enterで決定):"
ENGINES=("uplatex" "pdflatex" "lualatex")

# 関数を呼び出し
select_option "${ENGINES[@]}"
CHOICE=$? # 戻り値（インデックス）を取得
ENGINE_NAME=${ENGINES[$CHOICE]}

mkdir -p "$DIR"

# テンプレートファイルをコピーして置換
cp "projects/templates/$ENGINE_NAME/template.tex" "$DIR/$NAME.tex"
cp "projects/templates/$ENGINE_NAME/.latexmkrc" "$DIR/.latexmkrc"
sed -i "s/{{NAME}}/$NAME/g" "$DIR/$NAME.tex"

echo "プロジェクトを作成しました: $DIR (エンジン: $ENGINE_NAME)"

if command -v code >/dev/null 2>&1; then
  code "$DIR/$NAME.tex"
else
  echo "警告: 'code' コマンドが見つからないため、ファイルを開けませんでした。"
fi