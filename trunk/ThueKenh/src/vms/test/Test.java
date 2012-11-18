package vms.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.PhuLucDAO;
import vms.utils.DateUtils;


public class Test {
	public static void main(String arg[]) {
		System.out.println("Begin");
		/*String fileuploadFileName = "SuCoExcelMau.xls";
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
		}*/
		
		//MyCaculator.main(args)
		/*String[][] replacements = {{"DG", "123"}, 
                {"SL", "4"}};
		
		//loop over the array and replace
		String strOutput = "DG*SL";
		for(String[] replacement: replacements) {
		strOutput = strOutput.replace(replacement[0], replacement[1]);
		}
		
		System.out.println(strOutput);*/
		/*Date date = DateUtils.parseDate("23/11/2012", "dd/MM/yyyy");
		date = DateUtils.add(DateUtils.parseDate("23/11/2012", "dd/MM/yyyy"), Calendar.DATE, -1);
		java.sql.Date sqlDate = DateUtils.convertToSQLDate(DateUtils.add(DateUtils.parseDate("23/11/2012", "dd/MM/yyyy"), Calendar.DATE, -1));
		
		DataSource dataSource = ResourceManager.getDataSource();
		PhuLucDAO dao = new PhuLucDAO(new DaoFactory(dataSource));
		Map<String, Object> mapPhuLuc;
		try {
			mapPhuLuc = dao.findPhuLucCoHieuLuc( "VT_0003", sqlDate);
			System.out.println(mapPhuLuc.get("tenphuluc"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		/*Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		//calendar.
		//int curMonth = calendar.get(Calendar.MONTH) + 1;
		//calendar.add(Calendar.MONTH, -1);
		int thang = calendar.get(Calendar.MONTH);
		int nam = calendar.get(Calendar.YEAR);
		System.out.println(thang);*/
		//Date ngayhieuluc = new Date(nam, thang, 1);
		//System.out.println(ngayhieuluc.toString());
		//System.out.println(Calendar.OCTOBER);
		
		long num = Long.valueOf("1352318400000");
		java.util.Date date = new java.util.Date(num);
		System.out.println(DateUtils.formatDate(date, DateUtils.SDF_DDMMYYYYHHMMSS));
		
		System.out.println("Done!");
    }
}