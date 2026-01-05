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