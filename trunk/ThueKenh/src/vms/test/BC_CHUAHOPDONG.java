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
import vms.db.dao.DoiSoatCuocDAO;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.ReportDAO;
import vms.utils.DateUtils;
import vms.utils.ResourceManager;


public class BC_CHUAHOPDONG {
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
		ReportDAO dao = new ReportDAO(connection);
		
		String doitac_id = "";
		List<Map<String, Object>> list = dao.reportTuyenKenhDaBanGiaoChuaHopDong(doitac_id);
		for (Map<String, Object> map : list) {
			System.out.println(map.get("id"));
		}
		System.out.println("Done!");
    }
}