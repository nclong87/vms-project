package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class ThanhToanPhuLucDTO {

	private String thanhtoan_id="";
	private String phuluc_id="";

	
	public String getThanhtoan_id() {
		return thanhtoan_id;
	}

	public void setThanhtoan_id(String thanhtoan_id) {
		this.thanhtoan_id = thanhtoan_id;
	}

	public String getPhuluc_id() {
		return phuluc_id;
	}

	public void setPhuluc_id(String phuluc_id) {
		this.phuluc_id = phuluc_id;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("thanhtoan_id", this.thanhtoan_id);
		map.put("phuluc_id", this.phuluc_id);
		return map;
	}
	
	public static ThanhToanPhuLucDTO mapObject(ResultSet rs) throws SQLException {
		ThanhToanPhuLucDTO dto = new ThanhToanPhuLucDTO();
		dto.setThanhtoan_id(rs.getString("thanhtoan_id"));
		dto.setPhuluc_id(rs.getString("phuluc_id"));
        return dto;
	}
	

}