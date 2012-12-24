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
public class BienBanVanHanhKenhDTO {
	
	private String id="";
	private String sobienban="";
	private String filename="";
	private String filepath="";
	private String filesize="";
	private String usercreate="";
	private String timecreate="";
	private Integer deleted=0;
	
	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

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

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
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
		map.put("filename", this.filename);
		map.put("filepath", this.filepath);
		map.put("filesize", String.valueOf(this.filesize));
		map.put("usercreate", this.usercreate);
		map.put("timecreate", this.timecreate);
		map.put("deleted", String.valueOf(this.deleted));
		return map;
	}
	
	public static BienBanVanHanhKenhDTO mapObject(ResultSet rs) throws SQLException {
		BienBanVanHanhKenhDTO bienbanvh = new BienBanVanHanhKenhDTO();
		bienbanvh.setId(rs.getString("ID"));
		bienbanvh.setSobienban(rs.getString("SOBIENBAN"));
		bienbanvh.setFilename(rs.getString("FILENAME"));
		bienbanvh.setFilepath(rs.getString("FILEPATH"));
		bienbanvh.setFilesize(rs.getString("FILESIZE"));
		bienbanvh.setUsercreate(rs.getString("USERCREATE"));
		bienbanvh.setTimecreate(DateUtils.formatDate(rs.getDate("TIMECREATE"), DateUtils.SDF_DDMMYYYY));
		bienbanvh.setDeleted(rs.getInt("DELETED"));
        return bienbanvh;
	}
	

}