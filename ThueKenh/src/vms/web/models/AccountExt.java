package vms.web.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;



/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class AccountExt {

	private Integer active;

	private String id;

	//private String idgroup;

	private String idkhuvuc;

	private String idphongban;

	private String password;

	private String username;
	
	private String tenkhuvuc;
	
	private String tenphongban;

    public AccountExt() {
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
	
	public String getTenkhuvuc() {
		return tenkhuvuc;
	}

	public void setTenkhuvuc(String tenkhuvuc) {
		this.tenkhuvuc = tenkhuvuc;
	}

	public String getTenphongban() {
		return tenphongban;
	}

	public void setTenphongban(String tenphongban) {
		this.tenphongban = tenphongban;
	}

	public static AccountExt mapObject(ResultSet rs) throws SQLException {
		AccountExt account = new AccountExt();
		account.setId(rs.getString("ID"));
		account.setActive(rs.getInt("ACTIVE"));
		account.setIdkhuvuc(rs.getString("IDKHUVUC"));
		account.setIdphongban(rs.getString("IDPHONGBAN"));
		account.setUsername(rs.getString("USERNAME"));
		account.setTenkhuvuc(rs.getString("TENKHUVUC"));
		account.setTenphongban(rs.getString("TENPHONGBAN"));
        return account;
	}

	

}