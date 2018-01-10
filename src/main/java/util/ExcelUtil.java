package main.java.util;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Workbook;

@SuppressWarnings({"unused","deprecation","resource"})
public class ExcelUtil { 
 
	/**
	 * 单元格样式
	 * 
	 * @param wb
	 * @param font_name
	 * @param haveBorder
	 * @param alignment
	 * @return
	 */
	private static CellStyle createCellStyle(Workbook wb, String font_name, String color, Short fontHeight,
			Boolean isBold, Boolean haveBorder, int alignment) {
		CellStyle cs = wb.createCellStyle();
		Font f = wb.createFont();
		if (!StringUtils.isEmpty(font_name)) {
			f.setFontName(font_name);
		}
		if (!StringUtils.isEmpty(color)) {
			if ("red".equals(color)) {
				f.setColor(IndexedColors.RED.getIndex());
			}
		} else {
			f.setColor(IndexedColors.BLACK.getIndex());
		}
		f.setFontHeightInPoints(fontHeight);
		if (isBold) {
			f.setBoldweight(Font.BOLDWEIGHT_BOLD);
		}
		cs.setFont(f);
		if (haveBorder) {
			cs.setBorderLeft(CellStyle.BORDER_THIN);
			cs.setBorderRight(CellStyle.BORDER_THIN);
			cs.setBorderTop(CellStyle.BORDER_THIN);
			cs.setBorderBottom(CellStyle.BORDER_THIN);
		}
		if (alignment == 0) {
			cs.setAlignment(CellStyle.ALIGN_LEFT);
		} else if (alignment == 1) {
			cs.setAlignment(CellStyle.ALIGN_CENTER);
		} else if (alignment == 2) {
			cs.setAlignment(CellStyle.ALIGN_RIGHT);
		}
		// 自动换行
		cs.setWrapText(true);
		// 垂直居中
		cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		return cs;
	}
 
	
	public static void exportExcel(HttpServletResponse response,String name, List<Map<String,String>> columList, List<Map<String,String>> resultList )throws Exception{

		// 第一步，创建一个webbook，对应一个Excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
		HSSFSheet sheet = wb.createSheet("查询记录");
		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
		HSSFRow row = sheet.createRow((int) 0);
		// 第四步，创建单元格，并设置值表头 设置表头居中
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

		for(int columIndex = 0; columIndex < columList.size(); columIndex++) {
			HSSFCell cell = row.createCell((short) columIndex);
			cell.setCellValue(columList.get(columIndex).get("label"));
			cell.setCellStyle(style);
			sheet.autoSizeColumn((short)columIndex,true);
		}
		// 第五步，写入实体数据 实际应用中这些数据从数据库得到，

		for(int rowIndex = 0; rowIndex < resultList.size();rowIndex++) {
			row = sheet.createRow((int) rowIndex+1);

			for(int columIndex = 0; columIndex < columList.size(); columIndex++) {
				// 第四步，创建单元格，并设置值
				HSSFCell cell = row.createCell((short) columIndex);
				Object value = resultList.get(rowIndex).get(columList.get(columIndex).get("name"));
				if (value == null) {
					value = "";
				}
				cell.setCellValue(value.toString());
				cell.setCellStyle(style);
				sheet.autoSizeColumn((short)columIndex,true);
			}

		}
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename="+new String(name.getBytes("gbk"), "iso8859-1")+".xls");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();

	} 
}
