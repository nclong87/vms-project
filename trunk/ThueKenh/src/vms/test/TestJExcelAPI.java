package vms.test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import vms.db.dao.TuyenkenhDao;
import vms.db.dto.SuCoImportDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhImportDTO;

import jxl.*;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

public class TestJExcelAPI {
	public static void main(String arg[]) {
		System.out.println("Begin");
		/*Workbook workBook = null;
		try {
			WorkbookSettings ws = new WorkbookSettings();
			ws.setEncoding("Cp1252");
			workBook = Workbook.getWorkbook(new File("D:\\TuyenKenhReportTemplate.xls"),ws);
			File outputWorkbook = new File("D:\\sandy2.xls");                            // the excel sheet where data is to copied  
			WritableWorkbook workbook1=Workbook.createWorkbook(outputWorkbook,workBook);  
	       WritableSheet sheet = workbook1.getSheet(0); 
	       sheet.addRowPageBreak(arg0)
	        WritableCell cell = sheet.
	          sheet.findCell("[TU_NGAY]");
	          LabelCell labelCell = sheet.findLabelCell("[TU_NGAY]");
	          Label label = new Labe
	          label.setString("05/11/2012");
	          //Label l = (Label) cell; 
	          //l.setString("05/11/2012");
	         workbook1.write();
	          workbook1.close();
			int nColumn = sheet.getColumns();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i< nColumn; i++) {
				map.put(sheet.getCell(i, 0).getContents(), i);
				//System.out.println(sheet.getCell(i, 0).getContents());
			}
			System.out.println("nColumn = "+nColumn);
		} catch (BiffException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			workBook.close();
		}*/
		
		System.out.println("Done!");
    }
}