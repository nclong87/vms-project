package vms.test;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.io.FileUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.TuyenkenhImportDAO;
import vms.utils.DateUtils;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;


public class Test {
	public static void main(String arg[]) {
		System.out.println("Begin");
		long l1 = 453640675;
		//l1 = 450746553;
		l1 = (long)Math.round(l1*0.1);
		//long l = (long) Math.ceil( l1* 0.1);
		System.out.println(l1);
		/*Workbook workBook = null;
		try {
			System.out.println("Begin upload");
	        File file = new File("D:\\test.xls");
			workBook = Workbook.getWorkbook(file);
			Sheet sheet = workBook.getSheet(0);
			int maxrow = sheet.getRows();
			System.out.println("maxrow = "+maxrow);
			int max_col = sheet.getColumns();
			Map<Integer, String> map = new LinkedHashMap<Integer, String>();
			for(int i = 0;i< max_col; i++) {
				map.put(i, sheet.getCell(i, 0).getContents());
			}
			List<Map<String,String>> list = new ArrayList<Map<String,String>>();
			Date date = new Date();
			for(int i=1;i<maxrow;i++) {
				Map<String,String> dto = new LinkedHashMap<String, String>();
				for (Integer key : map.keySet()) {
					dto.put(map.get(key), sheet.getCell(key, i).getContents());
				}
				list.add(dto);
			}
			for(int i=0;i<list.size();i++) {
				Map<String,String> dto = list.get(i);
				System.out.println(dto.get("MADIEMDAU"));
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			workBook.close();
		}*/
		//Date date = DateUtils.parseDate("1/3/2013", "dd/MM/yyyy");
		//System.out.println(date.getTime());
		System.out.println("Done!");
    }
}