#!/bin/bash

# --- 選択UI用関数 ---
select_option() {
    local options=("$@")
    local selected=0
    local key

    # カーソルを消す
    tput civis
    trap 'tput cnorm; exit 1' SIGINT

    while true; do
        # 選択肢を表示
        for i in "${!options[@]}"; do
            if [ "$i" -eq "$selected" ]; then
                echo -e "\e[1;32m > ${options[$i]} \e[0m" # 選択中（緑色）
            else
                echo "   ${options[$i]}"
            fi
        done

        # キー入力を待機（1文字）
        read -rsn3 key
        
        # 前の表示を消去（行数分戻る）
        for ((i=0; i<${#options[@]}; i++)); do echo -ne "\033[1A\033[2K"; done

        case "$key" in
            $'\x1b[A') # 上矢印
                ((selected--))
                [ $selected -lt 0 ] && selected=$((${#options[@]} - 1))
                ;;
            $'\x1b[B') # 下矢印
                ((selected++))
                [ $selected -ge ${#options[@]} ] && selected=0
                ;;
            "") # エンターキー
                break
                ;;
        esac
    done

    # カーソルを戻す
    tput cnorm
    return $selected
}

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