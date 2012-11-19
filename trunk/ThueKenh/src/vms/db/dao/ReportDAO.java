package vms.db.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.sql.DataSource;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.JdbcTemplate;

import vms.db.dto.DoiTacDTO;
import vms.db.dto.report.rptDoiSoatCuoc;
import vms.db.dto.report.rptGiamTruMLL;
import vms.db.dto.report.rptSuCo;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;

public class ReportDAO {
	@SuppressWarnings("unused")
	private JdbcTemplate jdbcTemplate;
	private DataSource jdbcDatasource;
	private Connection connection;
	private DaoFactory daoFactory;
	public ReportDAO(Connection conn) {
		connection = conn;
	}
	
	public ReportDAO(DaoFactory factory) {
		this.jdbcTemplate = factory.getJdbcTemplate();
		this.jdbcDatasource = factory.getJdbcDataSource();
		this.daoFactory = factory;
	}
	
	/*
	 * Danh sach tuyen kenh da de xuat nhung chua ban giao
	 */
	private static final String SQL_BC_CHUABANGIAO = "{ ? = call BC_CHUABANGIAO(?) }";
	public String reportTuyenKenhChuaBanGiao(String doitac_id) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportTuyenKenhChuaBanGiao***");
		/*String tendoitac = "";
		if(doitac_id.isEmpty() == false) {
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			DoiTacDTO dto = doiTacDAO.get(doitac_id);
			tendoitac = dto.getTendoitac();
		}*/
		CallableStatement stmt = connection.prepareCall(SQL_BC_CHUABANGIAO);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header></header>");
		stringBuffer.append("<data>");
		int stt = 1;
		int iSoKenhChuaBanGiao = 0;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(VMSUtil.resultSetToXML(rs));
			stringBuffer.append("</row>");
			int iSoLuong = NumberUtil.parseInt(rs.getString("SOLUONGDEXUAT"));
			if(iSoLuong == 0) iSoLuong = NumberUtil.parseInt(rs.getString("SOLUONG"));
			iSoKenhChuaBanGiao+=iSoLuong;
			stt++;
		}
		stringBuffer.append("</data>");
		stringBuffer.append("<summary><sokenhchuabangiao>"+iSoKenhChuaBanGiao+"</sokenhchuabangiao></summary>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	/*
	 * Danh sach tuyen kenh da ban giao nhung chua co hop dong
	 */
	private static final String SQL_BC_CHUAHOPDONG = "{ ? = call BC_CHUAHOPDONG(?) }";
	public String reportTuyenKenhDaBanGiaoChuaHopDong(String doitac_id) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportTuyenKenhChuaBanGiao***");
		CallableStatement stmt = connection.prepareCall(SQL_BC_CHUAHOPDONG);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header></header>");
		stringBuffer.append("<data>");
		int stt = 1;
		int iSoKenhBanGiaoChuaHopDong = 0;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(VMSUtil.resultSetToXML(rs));
			stringBuffer.append("</row>");
			stt++;
			int iSoLuong = NumberUtil.parseInt(rs.getString("SOLUONGDEXUAT"));
			if(iSoLuong == 0) iSoLuong = NumberUtil.parseInt(rs.getString("SOLUONG"));
			iSoKenhBanGiaoChuaHopDong+=iSoLuong;
		}
		stringBuffer.append("</data>");
		stringBuffer.append("<summary><tuyenkenhdabangiao>"+iSoKenhBanGiaoChuaHopDong+"</tuyenkenhdabangiao></summary>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	/*
	 * Danh sach phu luc hop dong chua thanh toan o thoi diem hien tai (11/2012)
	 * Source :
	 * 		+ Thang thanh toan null hoac < 10
	 * 		+ Nam thanh toan = 2012
	 * 		+ Ngay hieu luc < 1/11/2012
	 * 		+ Trang thai != 1 ( loai nhung phu luc da thanh toan va da het hieu luc)
	 */
	private static final String SQL_BC_HDCHUATHANHTOAN = "{ ? = call BC_HDCHUATHANHTOAN(?,?,?) }";
	public String reportHopDongChuaThanhToan(String doitac_id,Date previous,Date current) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportHopDongChuaThanhToan***");
		CallableStatement stmt = connection.prepareCall(SQL_BC_HDCHUATHANHTOAN);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.setDate(3, previous);
		stmt.setDate(4, current);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header></header>");
		stringBuffer.append("<data>");
		int stt = 1;
		//int iSoKenhBanGiaoChuaHopDong = 0;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(VMSUtil.resultSetToXML(rs));
			stringBuffer.append("</row>");
			stt++;
		}
		stringBuffer.append("</data>");
		stringBuffer.append("<summary></summary>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	/*
	 * Xuat bang doi soat cuoc
	 * Source :
	 * 		+ Table DOISOATCUOC
	 * 		+ Table DOISOATCUOC_PHULUC
	 */
	private static final String SQL_BC_DOISOATCUOC = "{ ? = call BC_DOISOATCUOC(?) }";
	@SuppressWarnings("unchecked")
	public String reportXuatDoiSoatCuoc(String doisoatcuoc_id) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		Map<String, Object> doisoatcuoc = null;
		if(doisoatcuoc_id.isEmpty() == false) {
			DoiSoatCuocDAO doiSoatCuocDAO = new DoiSoatCuocDAO(daoFactory);
			doisoatcuoc = doiSoatCuocDAO.findById(doisoatcuoc_id);
		}
		System.out.println("***BEGIN reportXuatDoiSoatCuoc***");
		CallableStatement stmt = connection.prepareCall(SQL_BC_DOISOATCUOC);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doisoatcuoc_id);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header>");
		int tonggiamtru = 0;
		if(doisoatcuoc != null ) {
			stringBuffer.append(VMSUtil.xml("tungay", doisoatcuoc.get("tungay").toString()));
			stringBuffer.append(VMSUtil.xml("denngay", doisoatcuoc.get("denngay").toString()));
			stringBuffer.append(VMSUtil.xml("matlienlactu", doisoatcuoc.get("matlienlactu").toString()));
			stringBuffer.append(VMSUtil.xml("matlienlacden", doisoatcuoc.get("matlienlacden").toString()));
			stringBuffer.append(VMSUtil.xml("tendoitac", doisoatcuoc.get("tendoitac").toString().toUpperCase()));
			tonggiamtru = Integer.valueOf(doisoatcuoc.get("giamtrumll").toString());
		}
		stringBuffer.append("</header>");
		stringBuffer.append("<data>");
		int stt = 1;
		Map<Integer,Object> map = new LinkedHashMap<Integer,Object>();
		int hopdong_id = -1;
		int tongthanhtien = 0;
		int tongdaunoihoamang = 0;
		int tongdathanhtoan = 0;
		int tongconthanhtoan = 0;
		while(rs.next()) {
			//String hopdong_id = rs.getString("HOPDONG_ID");
			List<String> list = null;
			Map<String, Object> tmpMap1 = null;
			if(hopdong_id != rs.getInt("HOPDONG_ID")) {
				hopdong_id = rs.getInt("HOPDONG_ID");
				tmpMap1 = new LinkedHashMap<String, Object>();
				tmpMap1.put("stt", stt);
				tmpMap1.put("sohopdong", rs.getString("SOHOPDONG"));
				list = new ArrayList<String>();
				stt++;
			} else {
				
				tmpMap1 = (Map<String, Object>) map.get(hopdong_id);
				list = (List<String>) tmpMap1.get("childs");
			}
			list.add(rptDoiSoatCuoc.toXML(rs));
			tongthanhtien += rs.getInt("THANHTIEN");
			tongdaunoihoamang += rs.getInt("DAUNOIHOAMANG");
			tongdathanhtoan += rs.getInt("DATHANHTOAN");
			tongconthanhtoan += rs.getInt("CONTHANHTOAN");
			tmpMap1.put("childs", list);
			map.put(hopdong_id, tmpMap1);
		}
		for (Entry<Integer, Object> entry : map.entrySet()) {
			Map<String, Object> tmpMap1 = (Map<String, Object>) entry.getValue();
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+tmpMap1.get("stt")+"</stt>");
			stringBuffer.append(VMSUtil.xml("sohopdong", tmpMap1.get("sohopdong").toString()));
			List<String> list = (List<String>) tmpMap1.get("childs");
			stringBuffer.append(VMSUtil.xml("num_child", String.valueOf(list.size())));
			stringBuffer.append("<childs>");
			for(int i=0;i<list.size();i++) {
				stringBuffer.append("<child>"+list.get(i)+"</child>");
			}
			stringBuffer.append("</childs>");
			stringBuffer.append("</row>");
			//System.out.println("Name : " + entry.getKey() + " : " + tmpMap1.get("sohopdong").toString());
		}
		System.out.println("map.size()="+map.size());
		stringBuffer.append("</data>");
		stringBuffer.append("<summary>");
		tongconthanhtoan = tongconthanhtoan - tonggiamtru;
		int tongvat = (int) Math.floor(tongconthanhtoan * 10 / 100);
		int tongcong = tongconthanhtoan + tongvat;
		stringBuffer.append(VMSUtil.xml("tongthanhtien", String.valueOf(tongthanhtien)));
		stringBuffer.append(VMSUtil.xml("tonggiamtru", String.valueOf(tonggiamtru)));
		stringBuffer.append(VMSUtil.xml("tongdaunoihoamang", String.valueOf(tongdaunoihoamang)));
		stringBuffer.append(VMSUtil.xml("tongdathanhtoan", String.valueOf(tongdathanhtoan)));
		stringBuffer.append(VMSUtil.xml("tongconthanhtoan", String.valueOf(tongconthanhtoan)));
		stringBuffer.append(VMSUtil.xml("tongvat", String.valueOf(tongvat)));
		stringBuffer.append(VMSUtil.xml("tongcong", String.valueOf(tongcong)));
		stringBuffer.append("</summary>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	/*
	 * Bao cao giam tru mat lien lac
	 */
	private static final String SQL_BC_GIAMTRUMLL = "{ ? = call BC_GIAMTRUMLL(?,?,?) }";
	public String reportGiamTruMatLienLac(String doitac_id,long from, long end) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportGiamTruMatLienLac***");
		String tendoitac = "";
		if(doitac_id.isEmpty() == false) {
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			DoiTacDTO dto = doiTacDAO.get(doitac_id);
			tendoitac = dto.getTendoitac().toUpperCase();
		}
		java.util.Date date = new java.util.Date(from);
		String thang = DateUtils.formatDate(date, DateUtils.SDF_MMYYYY);
		CallableStatement stmt = connection.prepareCall(SQL_BC_GIAMTRUMLL);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.setLong(3, from);
		stmt.setLong(4, end);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header>");
		stringBuffer.append(VMSUtil.xml("thang", thang));
		stringBuffer.append(VMSUtil.xml("tendoitac", tendoitac));
		stringBuffer.append("</header>");
		stringBuffer.append("<data>");
		int stt = 1;
		int tonggiamtru = 0;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(rptGiamTruMLL.toXML(rs));
			stringBuffer.append("</row>");
			stt++;
			tonggiamtru+=rs.getLong("GIAMTRUMLL");
		}
		int vat = (int) Math.floor(tonggiamtru * 10 / 100);
		int tong = tonggiamtru + vat;
		stringBuffer.append("</data>");
		stringBuffer.append("<summary>");
		stringBuffer.append(VMSUtil.xml("tong", String.valueOf(tonggiamtru)));
		stringBuffer.append(VMSUtil.xml("vat", String.valueOf(vat)));
		stringBuffer.append(VMSUtil.xml("tongcuocgiamtru", String.valueOf(tong)));
		stringBuffer.append("</summary>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
	
	/*
	 * Bao cao su co theo thoi gian
	 */
	public String reportSuCoTheoThoiGian(String doitac_id,long from, long end) throws Exception {
		if(connection == null)
			connection = this.jdbcDatasource.getConnection();
		System.out.println("***BEGIN reportSuCoTheoThoiGian***");
		String tendoitac = "";
		if(doitac_id.isEmpty() == false) {
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			DoiTacDTO dto = doiTacDAO.get(doitac_id);
			tendoitac = dto.getTendoitac().toUpperCase();
		}
		java.util.Date date = new java.util.Date(from);
		String thang = DateUtils.formatDate(date, DateUtils.SDF_MMYYYY);
		CallableStatement stmt = connection.prepareCall(SQL_BC_GIAMTRUMLL);
		stmt.registerOutParameter(1, OracleTypes.CURSOR);
		stmt.setString(2, doitac_id);
		stmt.setLong(3, from);
		stmt.setLong(4, end);
		stmt.execute();
		ResultSet rs = (ResultSet) stmt.getObject(1);
		StringBuffer stringBuffer = new StringBuffer(1024);
		stringBuffer.append("<root>");
		stringBuffer.append("<header>");
		stringBuffer.append(VMSUtil.xml("thang", thang));
		stringBuffer.append(VMSUtil.xml("tendoitac", tendoitac));
		stringBuffer.append("</header>");
		stringBuffer.append("<data>");
		int stt = 1;
		int tongthoigianmll = 0;
		while(rs.next()) {
			stringBuffer.append("<row>");
			stringBuffer.append("<stt>"+stt+"</stt>");
			stringBuffer.append(rptSuCo.toXML(rs));
			stringBuffer.append("</row>");
			stt++;
			tongthoigianmll+=rs.getLong("THOIGIANMLL");
		}
		stringBuffer.append("</data>");
		stringBuffer.append("<summary>");
		stringBuffer.append(VMSUtil.xml("tong", String.valueOf(tongthoigianmll)));
		stringBuffer.append("</summary>");
		stringBuffer.append("</root>");
		stmt.close();
		connection.close();
		return stringBuffer.toString();
	}
}