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
import jxl.WorkbookSettings;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.io.FileUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiSoatCuocDAO;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.DuAnDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.LichSuTuyenKenhDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.ReportDAO;
import vms.db.dao.TramDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dao.TuyenkenhImportDAO;
import vms.db.dto.DuAnDTO;
import vms.db.dto.TramDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.ResourceManager;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;


public class ImportTuyenKenh {
	private static DaoFactory daoFactory;
	private static Connection connection;
	private static void instance() {
		System.out.println("Initing...");
		daoFactory = new DaoFactory(ResourceManager.getDataSource());
		connection = ResourceManager.connect();
	}
	public static void main(String arg[]) throws Exception {
		System.out.println("Begin");
		Workbook workBook = null;
		try {
			System.out.println("Begin upload");
			String file = "D:\\import2.xls";
			String filetype = StringUtil.getExtension(file);
			if(filetype.equals("xls") == false && filetype.equals("xlsx") == false)
				throw new Exception("Vui lòng chọn file excel 2003 hay excel 2007!");
	        // write file to local file system or to database as blob
	        File newFile = new File(file);
			workBook = Workbook.getWorkbook(newFile);
			Sheet sheet = workBook.getSheet(0);
			int maxrow = sheet.getRows();
			System.out.println("maxrow = "+maxrow);
			int max_col = sheet.getColumns();
			Map<Integer, String> map = new LinkedHashMap<Integer, String>();
			for(int i = 0;i< max_col; i++) {
				map.put(i, sheet.getCell(i, 0).getContents());
				//System.out.println(sheet.getCell(i, 0).getContents());
			}
			Integer index;
			//List<TuyenKenhImportDTO> list = new ArrayList<TuyenKenhImportDTO>();
			List<Map<String,String>> list = new ArrayList<Map<String,String>>();
			for(int i=1;i<maxrow;i++) {
				Map<String,String> dto = new LinkedHashMap<String, String>();
				for (Integer key : map.keySet()) {
					dto.put(map.get(key), sheet.getCell(key, i).getContents().trim());
				}
				list.add(dto);
			}
			instance();
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			for(int i=0;i<list.size();i++) {
				Map<String,String> dto = list.get(i);
				TuyenKenh tk = tuyenkenhDao.findByKey2(dto.get("MADIEMDAU"), dto.get("MADIEMCUOI"), dto.get("GIAOTIEP_MA"), NumberUtil.parseInt(dto.get("DUNGLUONG")));
				if(tk != null) {
					//System.out.println("Uodate tuyen kenh ID : "+tk.getId());
					//int loaikenh = dto.get("LOAIKENH").equals("Nội hạt")
					tuyenkenhDao.runScript("update TUYENKENH set NGAYBATDAU = TO_DATE('"+dto.get("NGAYBATDAU")+"','MM/DD/RRRR'),LOAIKENH = "+dto.get("LOAIKENH")+" where ID = '"+tk.getId()+"'");
				} else {
					System.out.println(dto.get("MADIEMDAU")+";"+dto.get("MADIEMCUOI")+";"+ dto.get("GIAOTIEP_MA"));
				}
				
			}
			
			//System.out.println(listDuan.size());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			workBook.close();
		}
		
		//dao.insertLichSu("ada", "121", "hello");
		System.out.println("Done!");
		
    }
}