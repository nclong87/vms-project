package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class KhuVucDTO{
	private String	id;
	private String  tenkhuvuc;
	private Integer deleted;
	private Integer stt;
	private String ma;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTenkhuvuc() {
		return tenkhuvuc;
	}

	public void setTenkhuvuc(String tenkhuvuc) {
		this.tenkhuvuc = tenkhuvuc;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public Integer getStt() {
		return stt;
	}

	public void setStt(Integer stt) {
		this.stt = stt;
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
		map.put("TENKHUVUC", this.tenkhuvuc);
		map.put("STT", this.stt.toString());
		map.put("MA", this.ma);
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	public static KhuVucDTO mapObject(ResultSet rs) throws SQLException {
		KhuVucDTO dto = new KhuVucDTO();
		dto.setId(rs.getString("ID"));
		dto.setMa(rs.getString("MA"));
		dto.setTenkhuvuc(rs.getString("TENKHUVUC"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}
