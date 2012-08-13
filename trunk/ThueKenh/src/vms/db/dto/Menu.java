package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;



/**
 * The persistent class for the MENU database table.
 * 
 */
public class Menu {

	private String id;

	private String action;

	private Integer active;

	private String idrootmenu;

	private String namemenu;

    public Menu() {
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}


	public String getIdrootmenu() {
		return idrootmenu;
	}

	public void setIdrootmenu(String idrootmenu) {
		this.idrootmenu = idrootmenu;
	}

	public String getNamemenu() {
		return namemenu;
	}

	public void setNamemenu(String namemenu) {
		this.namemenu = namemenu;
	}
	
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("namemenu", this.namemenu);
		map.put("action", this.action);
		map.put("active", this.active.toString());
		map.put("idrootmenu", this.idrootmenu);
		return map;
	}
	
	public static Menu mapObject(ResultSet rs) throws SQLException {
		Menu dto = new Menu();
		dto.setId(rs.getString("ID"));
		dto.setActive(rs.getInt("ACTIVE"));
		dto.setAction(rs.getString("ACTION"));
		dto.setIdrootmenu(rs.getString("IDROOTMENU"));
		dto.setNamemenu(rs.getString("NAMEMENU"));
        return dto;
	}
	

}