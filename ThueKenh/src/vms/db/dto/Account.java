package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class Account {

	private Integer active;

	private String id;

	private String idgroup;

	private String idkhuvuc;

	private String idphongban;

	private String password;

	private String username;
	
	private Integer mainmenu;

    public Account() {
    }

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	/*public String getIdgroup() {
		return idgroup;
	}

	public void setIdgroup(String idgroup) {
		this.idgroup = idgroup;
	}*/

	public String getIdkhuvuc() {
		return idkhuvuc;
	}

	public void setIdkhuvuc(String idkhuvuc) {
		this.idkhuvuc = idkhuvuc;
	}

	public String getIdphongban() {
		return idphongban;
	}

	public void setIdphongban(String idphongban) {
		this.idphongban = idphongban;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getIdgroup() {
		return idgroup;
	}

	public void setIdgroup(String idgroup) {
		this.idgroup = idgroup;
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
		map.put("username", this.getUsername());
		map.put("idphongban", this.getIdphongban());
		map.put("idgroup", this.idgroup);
		map.put("idkhuvuc", this.getIdkhuvuc());
		map.put("active", String.valueOf(this.getActive()));
		map.put("mainmenu", String.valueOf(this.mainmenu));
		return map;
	}
	
	public static Account mapObject(ResultSet rs) throws SQLException {
		Account account = new Account();
		account.setId(rs.getString("ID"));
		account.setActive(rs.getInt("ACTIVE"));
		//account.setIdgroup(rs.getString("IDGROUP"));
		account.setIdkhuvuc(rs.getString("IDKHUVUC"));
		account.setIdphongban(rs.getString("IDPHONGBAN"));
		account.setUsername(rs.getString("USERNAME"));
		account.setIdgroup(rs.getString("IDGROUP"));
		account.setMainmenu(rs.getInt("MAINMENU"));
		//System.out.println(rs.getString("USERNAME"));
        return account;
	}
	

}