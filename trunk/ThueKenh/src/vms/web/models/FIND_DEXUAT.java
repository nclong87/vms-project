package vms.web.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;

/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class FIND_DEXUAT {
	private String id = "";
	private String doitac_id = "";
	private String tendoitac = "";
	private String tenvanban = "";
	private String ngaygui = "";
	private String ngaydenghibangiao = "";
	private String trangthai = "";
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDoitac_id() {
		return doitac_id;
	}

	public void setDoitac_id(String doitac_id) {
		this.doitac_id = doitac_id;
	}

	public String getTendoitac() {
		return tendoitac;
	}

	public void setTendoitac(String tendoitac) {
		this.tendoitac = tendoitac;
	}

	public String getTenvanban() {
		return tenvanban;
	}

	public void setTenvanban(String tenvanban) {
		this.tenvanban = tenvanban;
	}

	public String getNgaygui() {
		return ngaygui;
	}

	public void setNgaygui(String ngaygui) {
		this.ngaygui = ngaygui;
	}

	public String getNgaydenghibangiao() {
		return ngaydenghibangiao;
	}

	public void setNgaydenghibangiao(String ngaydenghibangiao) {
		this.ngaydenghibangiao = ngaydenghibangiao;
	}

	public String getTrangthai() {
		return trangthai;
	}

	public void setTrangthai(String trangthai) {
		this.trangthai = trangthai;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("doitac_id", this.doitac_id);
		map.put("tendoitac", this.tendoitac);
		map.put("tenvanban", this.tenvanban);
		map.put("ngaygui", this.ngaygui);
		map.put("ngaydenghibangiao", this.ngaydenghibangiao);
		map.put("trangthai", this.trangthai);
		return map;
	}

	public static FIND_DEXUAT mapObject(ResultSet rs) throws SQLException {
		FIND_DEXUAT dto = new FIND_DEXUAT();
		dto.setId(rs.getString("ID"));
		dto.setDoitac_id(rs.getString("DOITAC_ID"));
		dto.setTendoitac(rs.getString("TENDOITAC"));
		dto.setTenvanban(rs.getString("TENVANBAN"));
		dto.setNgaygui(DateUtils.formatDate(rs.getDate("NGAYGUI"), DateUtils.SDF_DDMMYYYY));
		dto.setNgaydenghibangiao(DateUtils.formatDate(rs.getDate("NGAYDENGHIBANGIAO"), DateUtils.SDF_DDMMYYYY));
		dto.setTrangthai(rs.getString("TRANGTHAI"));
        return dto;
	}

	

}