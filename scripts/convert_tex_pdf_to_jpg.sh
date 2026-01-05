#!/bin/bash

source scripts/common.sh

# --- メイン処理 ---

# projects/内のディレクトリを取得
PROJECTS_DIR="projects"
if [ ! -d "$PROJECTS_DIR" ]; then
  echo "projects/ディレクトリが見つかりません。"
  exit 1
fi

# ディレクトリをリストアップ（templates以外）
OPTIONS=()
for dir in "$PROJECTS_DIR"/*/; do
  dir_name=$(basename "$dir")
  if [ "$dir_name" != "templates" ]; then
    OPTIONS+=("$dir_name")
  fi
done

if [ ${#OPTIONS[@]} -eq 0 ]; then
  echo "プロジェクトが見つかりません。"
  exit 1
fi

echo "JPGに変換したいプロジェクトを選択してください (↑↓キーで移動, Enterで決定):"

# 関数を呼び出し
select_option "${OPTIONS[@]}"
CHOICE=$? # 戻り値（インデックス）を取得
SELECTED_PROJECT=${OPTIONS[$CHOICE]}
TARGET_PATH="$PROJECTS_DIR/$SELECTED_PROJECT"

echo "選択されたプロジェクト: $SELECTED_PROJECT"

# Pythonスクリプトを実行
python3 scripts/pdf_to_jpg.py "$TARGET_PATH"