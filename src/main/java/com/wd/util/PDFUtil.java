package com.wd.util;

import java.util.List;

import com.itextpdf.text.*;
import org.apache.log4j.Logger;
import org.apache.pdfbox.io.RandomAccessFile;
import org.apache.pdfbox.io.RandomAccessRead;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;

import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;


/**
 * Created by DimonHo on 2018/1/29.
 */
public class PDFUtil {
    private static final Logger logger= Logger.getLogger(PDFUtil.class);

    public static final Rectangle PAGE_SIZE = PageSize.A4;
    public static final float MARGIN_LEFT = 50;
    public static final float MARGIN_RIGHT = 50;
    public static final float MARGIN_TOP = 50;
    public static final float MARGIN_BOTTOM = 50;
    public static final float SPACING = 20;


    public Document document = null;

    /**提取pdf文本**/
    public static String extractTXT(File file){
        String txt = null;
        try {
            PDFParser pdfParser = new PDFParser(new RandomAccessFile(file, "r"));
            pdfParser.parse();
            PDDocument pdDocument = new PDDocument(pdfParser.getDocument());
            PDFTextStripper pdfTextStripper = new PDFTextStripper();
            txt = pdfTextStripper.getText(pdDocument);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        };
        System.out.println(txt);
        return txt;
    }

    public static PDPageTree getPdfPages(File file){
        try {
            //打开pdf文件流
            FileInputStream fis = new   FileInputStream(file);
            PDFParser parser = new PDFParser(new RandomAccessFile(file, "r"));//解析pdf文档
            parser.parse();
            //获取PDDocument文档对象
            PDDocument document=parser.getPDDocument();
            return document.getDocumentCatalog().getPages();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 提取部分页面文本
     * @param file pdf文档路径
     * @param startPage 开始页数
     * @param endPage 结束页数
     */
    public static void extractTXT(String file,int startPage,int endPage){
        try{
            //打开pdf文件流
            FileInputStream fis = new   FileInputStream(file);
            //实例化一个PDF解析器
            PDFParser parser = new PDFParser((RandomAccessRead) fis);
            //解析pdf文档
            parser.parse();
            //获取PDDocument文档对象
            PDDocument document=parser.getPDDocument();
            //获取一个PDFTextStripper文本剥离对象
            PDFTextStripper stripper = new PDFTextStripper();
            // 设置起始页
            stripper.setStartPage(startPage);
            // 设置结束页
            stripper.setEndPage(endPage);
            //获取文本内容
            String content = stripper.getText(document);
            //打印内容
            System.out.println( "内容:" + content );
            document.close();
            fis.close();
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }


    /**
     * 功能：创建导出数据的目标文档
     * @param fileName 存储文件的临时路径
     * @return
     */
    public void createDocument(String fileName) {
        File file = new File(fileName);
        FileOutputStream out = null;
        document = new Document(PAGE_SIZE, MARGIN_LEFT, MARGIN_RIGHT, MARGIN_TOP, MARGIN_BOTTOM);
        try {
            out = new FileOutputStream(file);
//          PdfWriter writer =
            PdfWriter.getInstance(document, out);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        // 打开文档准备写入内容
        document.open();
    }

    /**
     * 将章节写入到指定的PDF文档中
     * @param element
     * @return
     */
    public void writeChapterToDoc(Element element,boolean isNew) {
        try {
            if(document != null) {
                if(!document.isOpen()) {
                    document.open();
                }
                if (isNew){
                    document.newPage();
                }
                document.add(element);
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }

    /**
     * 功能  创建PDF文档中的章节
     * @param title 章节标题
     * @param chapterNum 章节序列号
     * @param alignment 0表示align=left，1表示align=center
     * @param numberDepth 章节是否带序号 设值=1 表示带序号 1.章节一；1.1小节一...，设值=0表示不带序号
     * @param font 字体格式
     * @return Chapter章节
     */
    public static Chapter createChapter(String title, int chapterNum, int alignment, int numberDepth, Font font) {
        Paragraph chapterTitle = new Paragraph(title, font);
        chapterTitle.setAlignment(alignment);
        Chapter chapter = new Chapter(chapterTitle, chapterNum);
        chapter.setNumberDepth(numberDepth);
        return chapter;
    }

    /**
     * 功能：创建某指定章节下的小节
     * @param chapter 指定章节
     * @param title 小节标题
     * @param font 字体格式
     * @param numberDepth 小节是否带序号 设值=1 表示带序号 1.章节一；1.1小节一...，设值=0表示不带序号
     * @return section在指定章节后追加小节
     */
    public static Section createSection(Chapter chapter, String title, Font font, int numberDepth) {
        Section section = null;
        if(chapter != null) {
            Paragraph sectionTitle = new Paragraph(title, font);
            sectionTitle.setSpacingBefore(SPACING);
            section = chapter.addSection(sectionTitle);
            section.setNumberDepth(numberDepth);
        }
        return section;
    }

    /**
     * 功能：向PDF文档中添加的内容
     * @param text 内容
     * @param font 内容对应的字体
     * @return phrase 指定字体格式的内容
     */
    public static Phrase createPhrase(String text,Font font) {
        Phrase phrase = new Paragraph(text,font);
        return phrase;
    }



    /**
     * 功能：创建列表中的项
     * @param content 列表项中的内容
     * @param font 字体格式
     * @return listItem
     */
    public static ListItem createListItem(String content, Font font) {
        ListItem listItem = new ListItem(content, font);
        return listItem;
    }

    /**
     * 功能：创造字体格式
     * @param fontname
     * @param size 字体大小
     * @param style 字体风格
     * @param color 字体颜色
     * @return Font
     */
    public static Font createFont(String fontname, float size, int style, BaseColor color) {
        Font font =  FontFactory.getFont(fontname, size, style, color);
        return font;
    }

    /**
     * 功能： 返回支持中文的字体---仿宋
     * @param size 字体大小
     * @param style 字体风格
     * @param color 字体 颜色
     * @return  字体格式
     */
    public static Font createCHineseFont(float size, int style, BaseColor color,String font) {
        BaseFont bfChinese = null;
        try {
            bfChinese = BaseFont.createFont(font,BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Font(bfChinese, size, style, color);
    }

    /**
     * 最后关闭PDF文档
     */
    public void closeDocument() {
        if(document != null) {
            document.close();
        }
    }
}
