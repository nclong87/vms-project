package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class BanGiaoDTO {
	private String id;
	
	private String sobienban;
	private String usercreate;
	private String timecreate;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSobienban() {
		return sobienban;
	}

	public void setSobienban(String sobienban) {
		this.sobienban = sobienban;
	}

	public String getUsercreate() {
		return usercreate;
	}

	public void setUsercreate(String usercreate) {
		this.usercreate = usercreate;
	}

	public String getTimecreate() {
		return timecreate;
	}

	public void setTimecreate(String timecreate) {
		this.timecreate = timecreate;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("sobienban", this.sobienban);
		map.put("usercreate", this.usercreate);
		map.put("timecreate", this.timecreate);
		return map;
	}
	
	public static BanGiaoDTO mapObject(ResultSet rs) throws SQLException {
		BanGiaoDTO dto = new BanGiaoDTO();
		dto.setId(rs.getString("ID"));
		dto.setSobienban(rs.getString("SOBIENBAN"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
        return dto;
	}
	

}