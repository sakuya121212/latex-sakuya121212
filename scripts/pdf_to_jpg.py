import os
import sys
from pdf2image import convert_from_path

def convert_pdfs_in_folder(project_path):
    # プロジェクトディレクトリ内のPDFを検索
    pdf_files = [f for f in os.listdir(project_path) if f.lower().endswith('.pdf')]
    
    if not pdf_files:
        print(f"PDFファイルが見つかりませんでした: {project_path}")
        return

    for pdf_file in pdf_files:
        pdf_path = os.path.join(project_path, pdf_file)
        print(f"変換中: {pdf_file}...")
        
        # PDFを画像に変換 (600dpi指定)
        # 600dpiはかなり高画質用の数値（300が標準）
        images = convert_from_path(pdf_path, dpi=600)
        
        for i, image in enumerate(images):
            # ファイル名: 元の名前_page1.jpg
            base_name = os.path.splitext(pdf_file)[0]
            output_name = f"{base_name}_page{i+1}.jpg"
            output_path = os.path.join(project_path, output_name)
            
            image.save(output_path, "JPEG")
            print(f"  -> 保存完了: {output_name}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        convert_pdfs_in_folder(sys.argv[1])