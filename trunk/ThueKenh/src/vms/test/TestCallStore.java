package vms.test;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import oracle.jdbc.OracleTypes;

import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiSoatCuocDAO;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.ReportDAO;
import vms.utils.DateUtils;
import vms.utils.ResourceManager;
import vms.utils.VMSUtil;


public class TestCallStore {
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
		String sohoso = "HS03";
		Date ngaykyunc = DateUtils.parseToSQLDate("10/12/2012", "dd/MM/yyyy");
		Date ngaychuyenkhoan = DateUtils.parseToSQLDate("13/12/2012", "dd/MM/yyyy");
		CallableStatement stmt = connection.prepareCall("{ call PROC_UPDATE_THANHTOAN(?,?,?) }");
		stmt.setString(1, sohoso);
		stmt.setDate(2, ngaykyunc);
		stmt.setDate(3, ngaychuyenkhoan);
		stmt.execute();
		stmt.close();
		connection.close();
		System.out.println("Done!");
    }
}