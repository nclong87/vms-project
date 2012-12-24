package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class VanHanhSuCoKenhDTO {
	
	private String bienban_id="";
	private String sucokenh_id="";
	
	public String getBienban_id() {
		return bienban_id;
	}

	public void setBienban_id(String bienban_id) {
		this.bienban_id = bienban_id;
	}

	public String getSucokenh_id() {
		return sucokenh_id;
	}

	public void setSucokenh_id(String sucokenh_id) {
		this.sucokenh_id = sucokenh_id;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("bienban_id", this.bienban_id);
		map.put("sucokenh_id", this.sucokenh_id);
		return map;
	}
	
	public static VanHanhSuCoKenhDTO mapObject(ResultSet rs) throws SQLException {
		VanHanhSuCoKenhDTO bienbanvh = new VanHanhSuCoKenhDTO();
		bienbanvh.setBienban_id(rs.getString("BIENBAN_ID"));
		bienbanvh.setSucokenh_id(rs.getString("SUCOKENH_ID"));
        return bienbanvh;
	}
	

}