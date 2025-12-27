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

mkdir -p "$DIR"

# テンプレートファイルをコピーして置換
cp projects/templates/template.tex "$DIR/$NAME.tex"
sed -i "s/{{NAME}}/$NAME/g" "$DIR/$NAME.tex"

echo "プロジェクトを作成しました: $DIR"
