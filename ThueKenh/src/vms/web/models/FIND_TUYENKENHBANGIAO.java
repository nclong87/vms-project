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
public class FIND_TUYENKENHBANGIAO {
	private String id;
	private String tuyenkenh_id;
	private String madiemdau;
	private String madiemcuoi;
	private String loaigiaotiep;
	private String dungluong;
	private String soluong;
	private String ngaydenghibangiao;
	private String ngayhenbangiao;
	private String tenvanbandexuat;
	private String tiendo;
	private String tenduan;
	private String username;
	private String mavanbandexuat;
	


	public String getMavanbandexuat() {
		return mavanbandexuat;
	}

	public void setMavanbandexuat(String mavanbandexuat) {
		this.mavanbandexuat = mavanbandexuat;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getTenduan() {
		return tenduan;
	}

	public void setTenduan(String tenduan) {
		this.tenduan = tenduan;
	}
	
	public String getTenvanbandexuat() {
		return tenvanbandexuat;
	}

	public void setTenvanbandexuat(String tenvanbandexuat) {
		this.tenvanbandexuat = tenvanbandexuat;
	}

	public String getTiendo() {
		return tiendo;
	}

	public void setTiendo(String tiendo) {
		this.tiendo = tiendo;
	}

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
		map.put("tenvanbandexuat", this.tenvanbandexuat);
		map.put("mavanbandexuat", this.mavanbandexuat);
		map.put("tenduan", this.tenduan);
		map.put("tiendo", this.tiendo+"%");
		return map;
	}

	public static FIND_TUYENKENHBANGIAO mapObject(ResultSet rs) throws SQLException {
		FIND_TUYENKENHBANGIAO dto = new FIND_TUYENKENHBANGIAO();
		dto.setId(rs.getString("ID"));
		dto.setTuyenkenh_id(rs.getString("TUYENKENH_ID"));
		dto.setMadiemdau(rs.getString("MADIEMDAU"));
		dto.setMadiemcuoi(rs.getString("MADIEMCUOI"));
		dto.setLoaigiaotiep(rs.getString("LOAIGIAOTIEP"));
		dto.setDungluong(rs.getString("DUNGLUONG"));
		dto.setTenduan(rs.getString("TENDUAN"));
		dto.setSoluong(rs.getString("SOLUONG"));
		dto.setTiendo(rs.getString("TIENDO"));
		dto.setTenvanbandexuat(rs.getString("TENVANBANDEXUAT"));
		dto.setMavanbandexuat(rs.getString("MAVANBANDEXUAT"));
        return dto;
	}

	

}