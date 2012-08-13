package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;



/**
 * The persistent class for the ROOTMENU database table.
 * 
 */
public class Rootmenu {

	private String id;

	private String name;

    public Rootmenu() {
    }

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("name", this.name);
		return map;
	}
	
	public static Rootmenu mapObject(ResultSet rs) throws SQLException {
		Rootmenu dto = new Rootmenu();
		dto.setId(rs.getString("ID"));
		dto.setName(rs.getString("NAME"));
        return dto;
	}
}