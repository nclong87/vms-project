package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class DoiTacDTO {
	protected String id = "";
	protected String tendoitac = "";
	protected Integer stt = 0;
	protected Integer deleted = 0;
	protected String ma = "";
	
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

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENDOITAC", this.tendoitac);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		map.put("MA", this.ma);
		return map;
	}
	
	public static DoiTacDTO mapObject(ResultSet rs) throws SQLException {
		DoiTacDTO dto = new DoiTacDTO();
		dto.setId(rs.getString("ID"));
		dto.setTendoitac(rs.getString("TENDOITAC"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setMa(rs.getString("MA"));
        return dto;
	}
}
