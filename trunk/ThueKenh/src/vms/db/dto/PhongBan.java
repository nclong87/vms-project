package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class PhongBan {

	private String id;

	private String tenphongban;
	
	public String getMa() {
		return ma;
	}


	public void setMa(String ma) {
		this.ma = ma;
	}

	private Integer stt;

	private Integer deleted;

	private String ma;

    public PhongBan() {
    }
    
	
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTenphongban() {
		return tenphongban;
	}


	public void setTenphongban(String tenphongban) {
		this.tenphongban = tenphongban;
	}


	public Integer getStt() {
		return stt;
	}


	public void setStt(Integer stt) {
		this.stt = stt;
	}


	public Integer getDeleted() {
		return deleted;
	}


	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}


	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.putAll(map);
		map.put("ID", this.id);
		map.put("TENPHONGBAN", this.tenphongban);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		map.put("MA", this.ma);
		return map;
	}
	
	public static PhongBanDTO mapObject(ResultSet rs) throws SQLException {
		PhongBanDTO dto = new PhongBanDTO();
		dto.setId(rs.getString("ID"));
		dto.setMa(rs.getString("MA"));
		dto.setTenphongban(rs.getString("TENPHONGBAN"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}