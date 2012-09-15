package vms.web.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;

/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class FIND_TUYENKENHDEXUAT {
	private String id;
	private String tuyenkenh_id;
	private String madiemdau;
	private String madiemcuoi;
	private String loaigiaotiep;
	private String dungluong;
	private String soluong;
	private String tenduan;
	private String tenphongban;
	private String tenkhuvuc;
	private String trangthai;
	private String ngaydenghibangiao;
	private String ngayhenbangiao;
	
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
	
	public String getNgaydenghibangiao() {
		return ngaydenghibangiao;
	}

	public void setNgaydenghibangiao(String ngaydenghibangiao) {
		this.ngaydenghibangiao = ngaydenghibangiao;
	}

	public String getNgayhenbangiao() {
		return ngayhenbangiao;
	}

	public void setNgayhenbangiao(String ngayhenbangiao) {
		this.ngayhenbangiao = ngayhenbangiao;
	}
	
	public String getTuyenkenh_id() {
		return tuyenkenh_id;
	}

	public void setTuyenkenh_id(String tuyenkenh_id) {
		this.tuyenkenh_id = tuyenkenh_id;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("tuyenkenh_id", this.tuyenkenh_id);
		map.put("madiemdau", this.madiemdau);
		map.put("madiemcuoi", this.madiemcuoi);
		map.put("loaigiaotiep", this.loaigiaotiep);
		map.put("dungluong", this.dungluong);
		map.put("soluong", this.soluong);
		map.put("tenduan", this.tenduan);
		map.put("tenphongban", this.tenphongban);
		map.put("tenkhuvuc", this.tenkhuvuc);
		map.put("trangthai", this.trangthai);
		map.put("ngaydenghibangiao", this.ngaydenghibangiao);
		map.put("ngayhenbangiao", this.ngayhenbangiao);
		return map;
	}

	public static FIND_TUYENKENHDEXUAT mapObject(ResultSet rs) throws SQLException {
		FIND_TUYENKENHDEXUAT dto = new FIND_TUYENKENHDEXUAT();
		dto.setId(rs.getString("ID"));
		dto.setTuyenkenh_id(rs.getString("TUYENKENH_ID"));
		dto.setMadiemdau(rs.getString("MADIEMDAU"));
		dto.setMadiemcuoi(rs.getString("MADIEMCUOI"));
		dto.setLoaigiaotiep(rs.getString("LOAIGIAOTIEP"));
		dto.setDungluong(rs.getString("DUNGLUONG"));
		dto.setSoluong(rs.getString("SOLUONG"));
		dto.setTenduan(rs.getString("TENDUAN"));
		dto.setTenphongban(rs.getString("TENPHONGBAN"));
		dto.setTenkhuvuc(rs.getString("TENKHUVUC"));
		dto.setTrangthai(rs.getString("TRANGTHAI"));
		dto.setNgaydenghibangiao(DateUtils.formatDate(rs.getDate("NGAYDENGHIBANGIAO"), DateUtils.SDF_DDMMYYYY));
		dto.setNgayhenbangiao(DateUtils.formatDate(rs.getDate("NGAYHENBANGIAO"), DateUtils.SDF_DDMMYYYY));
        return dto;
	}

	

}