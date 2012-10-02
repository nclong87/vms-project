package vms.utils;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import com.smartxls.WorkBook;






public class Test {
	public static void main(String arg[]) {
		System.out.println("Begin");
		String fileuploadFileName = "SuCoExcelMau.xls";
		String filepath = "D:\\SuCoExcelMau.xls";
		WorkBook workBook = new WorkBook();
		String filetype = StringUtil.getExtension(fileuploadFileName);
		try {
			if(filetype.equals("xls")) {  // Excel 2003
				workBook.read(filepath);
			} else {  // Excel 2007
				workBook.readXLSX(filepath);
			}
			int maxrow = workBook.getLastRow();
			System.out.println("maxrow = "+maxrow);
			int max_col = workBook.getLastCol();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i< max_col; i++) {
				map.put(workBook.getText(0, i), i);
			}
			Integer index;
			for(int i=1;i<=maxrow;i++) {
				if( (index = map.get("THOIDIEMBATDAU")) != null) {
					String thoidiembd = workBook.getFormattedText(i, index);
					System.out.println("THOIDIEMBATDAU = "+thoidiembd);
					long thoidiembatdau = DateUtils.parseDate(thoidiembd, "dd/MM/yyyy hh:mm:ss").getTime();
					System.out.println("thoidiembatdau = "+thoidiembatdau);
					java.sql.Timestamp date = new java.sql.Timestamp(thoidiembatdau);
					System.out.println("date : "+date.getMinutes());
				}
					
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			workBook.dispose();
		}
		
		System.out.println("Done!");
    }
}