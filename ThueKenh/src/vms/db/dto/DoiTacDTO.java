package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class DoiTacDTO {
	private String id = "";
	private String tendoitac = "";
	private Integer stt = 0;
	private Integer deleted = 0;
	private String khuvuc_id = "";
	private String ma = "";
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTendoitac() {
		return tendoitac;
	}

	public void setTendoitac(String tendoitac) {
		this.tendoitac = tendoitac;
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

	public String getMa() {
		return ma;
	}

	public void setMa(String ma) {
		this.ma = ma;
	}
	
	public String getKhuvuc_id() {
		return khuvuc_id;
	}

	public void setKhuvuc_id(String khuvuc_id) {
		this.khuvuc_id = khuvuc_id;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENDOITAC", this.tendoitac);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		map.put("MA", this.ma);
		map.put("KHUVUC_ID", this.khuvuc_id);
		return map;
	}
	
	public static DoiTacDTO mapObject(ResultSet rs) throws SQLException {
		DoiTacDTO dto = new DoiTacDTO();
		dto.setId(rs.getString("ID"));
		dto.setTendoitac(rs.getString("TENDOITAC"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setMa(rs.getString("MA"));
		dto.setKhuvuc_id(rs.getString("KHUVUC_ID"));
        return dto;
	}
}
