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
import vms.db.dao.TuyenkenhImportDAO;
import vms.db.dto.DuAnDTO;
import vms.db.dto.TramDTO;
import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.DateUtils;
import vms.utils.ResourceManager;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;


public class TestSQL {
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
			String filetype = StringUtil.getExtension("D:\\Import.xls");
			if(filetype.equals("xls") == false && filetype.equals("xlsx") == false)
				throw new Exception("Vui lòng chọn file excel 2003 hay excel 2007!");
	        // write file to local file system or to database as blob
	        File newFile = new File("D:\\Import.xls");
			workBook = Workbook.getWorkbook(newFile);
			Sheet sheet = workBook.getSheet(0);
			int maxrow = sheet.getRows();
			System.out.println("maxrow = "+maxrow);
			int max_col = sheet.getColumns();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i< max_col; i++) {
				map.put(sheet.getCell(i, 0).getContents(), i);
			}
			Integer index;
			//List<TuyenKenhImportDTO> list = new ArrayList<TuyenKenhImportDTO>();
			List<String> listMaTram = new ArrayList<String>();
			List<String> listDuan = new ArrayList<String>();
			for(int i=1;i<maxrow;i++) {
				if( (index = map.get("MATRAM")) != null) {
					String str = sheet.getCell(index, i).getContents();
					if(str.isEmpty() == false)
						listMaTram.add(sheet.getCell(index, i).getContents());
				}
				if( (index = map.get("DUAN")) != null) {
					String str = sheet.getCell(index, i).getContents();
					if(str.isEmpty() == false)
						listDuan.add(sheet.getCell(index, i).getContents());
				}
			}
			instance();
			/* Import Tram
			 * TramDAO dao = new TramDAO(daoFactory);
			for(int i=0;i<listMaTram.size();i++) {
				TramDTO dto = new TramDTO();
				dto.setMatram(listMaTram.get(i));
				dto.setDiachi("");
				dao.save(dto);
			}*/
			
			DuAnDAO dao = new DuAnDAO(daoFactory);
			for(int i=0;i<listDuan.size();i++) {
				DuAnDTO dto = new DuAnDTO();
				dto.setTenduan(listDuan.get(i));
				dto.setDeleted(0);
				dto.setGiamgia(0);
				dto.setMa(listDuan.get(i));
				dto.setMota("");
				dto.setStt(i);
				dto.setUsercreate("SYSTEM");
				dto.setTimecreate(DateUtils.getCurrentDateSQL());
				dao.insert(dto);
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