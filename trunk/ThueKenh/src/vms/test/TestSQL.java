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
import vms.db.dao.DoiSoatCuocDAO;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.LichSuTuyenKenhDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.ReportDAO;
import vms.utils.DateUtils;
import vms.utils.ResourceManager;


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
		instance();
		LichSuTuyenKenhDAO dao = new LichSuTuyenKenhDAO(daoFactory);
		List<Map<String, Object>> list = dao.getData(1, "BD_0015");
		for (Map<String, Object> map : list) {
			System.out.println(map.get("timeaction"));
		}
		//dao.insertLichSu("ada", "121", "hello");
		System.out.println("Done!");
		
    }
}