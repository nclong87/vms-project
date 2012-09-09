package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class PhongBan {

	private String id;

	private String tenphongban;
	
	private Integer stt;

	private Integer deleted;


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
		map.put("ID", this.id);
		map.put("TENPHONGBAN", this.tenphongban);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	public static PhongBanDTO mapObject(ResultSet rs) throws SQLException {
		PhongBanDTO dto = new PhongBanDTO();
		dto.setId(rs.getString("ID"));
		dto.setName(rs.getString("TENPHONGBAN"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
	
	

	

}