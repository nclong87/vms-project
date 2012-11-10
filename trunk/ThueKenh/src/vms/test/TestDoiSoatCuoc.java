package vms.test;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.ReportDao;
import vms.utils.DateUtils;
import vms.utils.ResourceManager;


public class TestDoiSoatCuoc {
	public static void main(String arg[]) {
		System.out.println("Begin");
		Connection connection = ResourceManager.connect();
		ReportDao dao = new ReportDao(connection);
		
		String doitac_id = "104";
		Date sqlTuNgay = DateUtils.parseToSQLDate("01/10/2012","dd/MM/yyyy");
		Date sqlDenNgay = DateUtils.parseToSQLDate("31/10/2012","dd/MM/yyyy");
		String[] phulucs = {"61","62","63"};
		String[] sucos = {"21"};
		try {
			Map<String, Object> map = dao.saveDoiSoatCuoc(doitac_id, sqlTuNgay, sqlDenNgay, phulucs, sucos);
			System.out.println("Doi soat cuoc ID =" +map.get("id"));
			System.out.println("Tong tien thanh toan = "+map.get("thanhtien"));
			System.out.println("Tong tien giam tru mat lien lac =" +map.get("giamtrumll"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(date.toString());
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
		
		System.out.println("Done!");
    }
}