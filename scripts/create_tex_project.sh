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

cat << EOF > "$DIR/$NAME.tex"
\\documentclass[a4paper,11pt]{article}

\\usepackage{amsmath,amssymb}

\\title{$NAME}
\\author{}
\\date{\\today}

\\begin{document}
\\maketitle

\\section{Introduction}

Hello, LaTeX!

\\end{document}
EOF

echo "プロジェクトを作成しました: $DIR"
