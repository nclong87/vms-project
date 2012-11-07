package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 * The persistent class for the CHITIETPHULUC database table.
 * 
 */
public class PhuLucHopDongDTO {

	private String hopdong_id;
	private List<String> phuluc_ids;
	public String getHopdong_id() {
		return hopdong_id;
	}
	public void setHopdong_id(String hopdong_id) {
		this.hopdong_id = hopdong_id;
	}
	public List<String> getPhuluc_ids() {
		return phuluc_ids;
	}
	public void setPhuluc_ids(List<String> phuluc_ids) {
		this.phuluc_ids = phuluc_ids;
	}
	
}