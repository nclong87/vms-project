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
	
	private Integer mainmenu;

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
	
	public Integer getMainmenu() {
		return mainmenu;
	}

	public void setMainmenu(Integer mainmenu) {
		this.mainmenu = mainmenu;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.getId());
		map.put("namegroup", this.getNamegroup());
		map.put("active", this.getActive().toString());
		map.put("mainmenu", String.valueOf(this.mainmenu));
		return map;
	}
	
	public static Vmsgroup mapObject(ResultSet rs) throws SQLException {
		Vmsgroup vmsgroup = new Vmsgroup();
		vmsgroup.setId(rs.getString("ID"));
		vmsgroup.setActive(rs.getInt("ACTIVE"));
		vmsgroup.setNamegroup(rs.getString("NAMEGROUP"));
		vmsgroup.setMainmenu(rs.getInt("MAINMENU"));
        return vmsgroup;
	}

}