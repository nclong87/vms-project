package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;



/**
 * The persistent class for the VMSGROUP database table.
 * 
 */
public class Vmsgroup {

	private String id;

	private Integer active;

	private String namegroup;

    public Vmsgroup() {
    }

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getActive() {
		return this.active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getNamegroup() {
		return this.namegroup;
	}

	public void setNamegroup(String namegroup) {
		this.namegroup = namegroup;
	}
	
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.getId());
		map.put("namegroup", this.getNamegroup());
		map.put("active", this.getActive().toString());
		return map;
	}
	
	public static Vmsgroup mapObject(ResultSet rs) throws SQLException {
		Vmsgroup vmsgroup = new Vmsgroup();
		vmsgroup.setId(rs.getString("ID"));
		vmsgroup.setActive(rs.getInt("ACTIVE"));
		vmsgroup.setNamegroup(rs.getString("NAMEGROUP"));
        return vmsgroup;
	}

}