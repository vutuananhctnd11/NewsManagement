package com.laptrinhjavaweb.testJavaIO;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;

public class readFileWord {

	public static String convertWordToHtml(String filePath) {
        StringBuilder htmlContent = new StringBuilder();
        htmlContent.append("<body>");

        try (FileInputStream fis = new FileInputStream(filePath)) {
            // Mở tài liệu Word
            XWPFDocument document = new XWPFDocument(fis);

            // Lấy danh sách các đoạn văn trong tài liệu
            List<XWPFParagraph> paragraphs = document.getParagraphs();

            // Duyệt qua từng đoạn văn
            for (XWPFParagraph paragraph : paragraphs) {
                htmlContent.append("<p>"); // Bắt đầu đoạn văn HTML

                // Duyệt qua từng phần văn bản (run) trong đoạn văn
                for (XWPFRun run : paragraph.getRuns()) {
                    String text = run.getText(0); // Lấy văn bản
                    String fontFamily = run.getFontFamily(); // Lấy kiểu chữ (font)
                    int fontSize = run.getFontSize(); // Lấy kích thước chữ
                    String color = run.getColor(); // Lấy màu chữ
                    boolean isBold = run.isBold(); // Kiểm tra in đậm
                    boolean isItalic = run.isItalic(); // Kiểm tra in nghiêng

                    if (text != null) {
                        // Bắt đầu phần văn bản với thẻ span để áp dụng các định dạng
                        htmlContent.append("<span style='");
                        
                        // Thêm các kiểu chữ vào thuộc tính style
                        if (fontFamily != null) {
                            htmlContent.append("font-family:").append(fontFamily).append("; ");
                        }
                        if (fontSize > 0) {
                            htmlContent.append("font-size:").append(fontSize).append("pt; ");
                        }
                        if (color != null) {
                            htmlContent.append("color:#").append(color).append("; ");
                        }
                        if (isBold) {
                            htmlContent.append("font-weight:bold; ");
                        }
                        if (isItalic) {
                            htmlContent.append("font-style:italic; ");
                        }

                        htmlContent.append("'>").append(text).append("</span>");
                    }
                }

                htmlContent.append("</p>"); // Kết thúc đoạn văn HTML
            }

            document.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        htmlContent.append("</body>");
        return htmlContent.toString();
    }

    public static void main(String[] args) {
        // Đường dẫn tới file Word của bạn
        String filePath = "C:/Users/vutua/OneDrive/Documents/test.docx";

        // Chuyển đổi Word thành HTML
        String html = convertWordToHtml(filePath);

        // In ra chuỗi HTML
        System.out.println(html);
    }
}
