package vms.web.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class FN_FIND_TUYENKENH {
	private String id;
	private String madiemdau;
	private String madiemcuoi;
	private String loaigiaotiep;
	private String dungluong;
	private String soluong;
	private String tenduan;
	private String tenphongban;
	private String tenkhuvuc;
	private String trangthai;
	private String giaotiep_id = "";
	private String duan_id = "";
	private String phongban_id = "";
	private String khuvuc_id = "";
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMadiemdau() {
		return madiemdau;
	}

	public void setMadiemdau(String madiemdau) {
		this.madiemdau = madiemdau;
	}

	public String getMadiemcuoi() {
		return madiemcuoi;
	}

	public void setMadiemcuoi(String madiemcuoi) {
		this.madiemcuoi = madiemcuoi;
	}

	public String getLoaigiaotiep() {
		return loaigiaotiep;
	}

	public void setLoaigiaotiep(String loaigiaotiep) {
		this.loaigiaotiep = loaigiaotiep;
	}

	public String getDungluong() {
		return dungluong;
	}

	public void setDungluong(String dungluong) {
		this.dungluong = dungluong;
	}

	public String getSoluong() {
		return soluong;
	}

	public void setSoluong(String soluong) {
		this.soluong = soluong;
	}

	public String getTenduan() {
		return tenduan;
	}

	public void setTenduan(String tenduan) {
		this.tenduan = tenduan;
	}

	public String getTenphongban() {
		return tenphongban;
	}

	public void setTenphongban(String tenphongban) {
		this.tenphongban = tenphongban;
	}

	public String getTenkhuvuc() {
		return tenkhuvuc;
	}

	public void setTenkhuvuc(String tenkhuvuc) {
		this.tenkhuvuc = tenkhuvuc;
	}

	public String getTrangthai() {
		return trangthai;
	}

	public void setTrangthai(String trangthai) {
		this.trangthai = trangthai;
	}
	
	public String getGiaotiep_id() {
		return giaotiep_id;
	}

	public void setGiaotiep_id(String giaotiep_id) {
		this.giaotiep_id = giaotiep_id;
	}

	public String getDuan_id() {
		return duan_id;
	}

	public void setDuan_id(String duan_id) {
		this.duan_id = duan_id;
	}

	public String getPhongban_id() {
		return phongban_id;
	}

	public void setPhongban_id(String phongban_id) {
		this.phongban_id = phongban_id;
	}

	public String getKhuvuc_id() {
		return khuvuc_id;
	}

	public void setKhuvuc_id(String khuvuc_id) {
		this.khuvuc_id = khuvuc_id;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("madiemdau", this.madiemdau);
		map.put("madiemcuoi", this.madiemcuoi);
		map.put("loaigiaotiep", this.loaigiaotiep);
		map.put("dungluong", this.dungluong);
		map.put("soluong", this.soluong);
		map.put("tenduan", this.tenduan);
		map.put("tenphongban", this.tenphongban);
		map.put("tenkhuvuc", this.tenkhuvuc);
		map.put("trangthai", this.trangthai);
		map.put("duan_id", this.duan_id);
		map.put("phongban_id", this.phongban_id);
		map.put("khuvuc_id", this.khuvuc_id);
		map.put("giaotiep_id", this.giaotiep_id);
		return map;
	}

	public static FN_FIND_TUYENKENH mapObject(ResultSet rs) throws SQLException {
		FN_FIND_TUYENKENH dto = new FN_FIND_TUYENKENH();
		dto.setId(rs.getString("ID"));
		dto.setMadiemdau(rs.getString("MADIEMDAU"));
		dto.setMadiemcuoi(rs.getString("MADIEMCUOI"));
		dto.setLoaigiaotiep(rs.getString("LOAIGIAOTIEP"));
		dto.setDungluong(rs.getString("DUNGLUONG"));
		dto.setSoluong(rs.getString("SOLUONG"));
		dto.setTenduan(rs.getString("TENDUAN"));
		dto.setTenphongban(rs.getString("TENPHONGBAN"));
		dto.setTenkhuvuc(rs.getString("TENKHUVUC"));
		dto.setTrangthai(rs.getString("TRANGTHAI"));
		dto.setGiaotiep_id(rs.getString("GIAOTIEP_ID"));
		dto.setDuan_id(rs.getString("DUAN_ID"));
		dto.setPhongban_id(rs.getString("PHONGBAN_ID"));
		dto.setKhuvuc_id(rs.getString("KHUVUC_ID"));
        return dto;
	}

	

}