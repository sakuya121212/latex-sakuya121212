#!/bin/bash

source scripts/common.sh

# --- メイン処理 ---

# projects/内のtemplates以外のディレクトリを取得
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
  echo "削除可能なプロジェクトがありません。"
  exit 0
fi

echo "削除するプロジェクトを選択してください (↑↓キーで移動, Enterで決定):"

# 関数を呼び出し
select_option "${OPTIONS[@]}"
CHOICE=$? # 戻り値（インデックス）を取得
SELECTED_PROJECT=${OPTIONS[$CHOICE]}

# 確認
read -p "本当に '$SELECTED_PROJECT' を削除しますか？ (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "削除をキャンセルしました。"
  exit 0
fi

# 削除
rm -rf "$PROJECTS_DIR/$SELECTED_PROJECT"

echo "プロジェクトを削除しました: $SELECTED_PROJECT"