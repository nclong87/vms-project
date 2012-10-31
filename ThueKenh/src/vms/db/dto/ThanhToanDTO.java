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
public class ThanhToanDTO {

	private String id;
	private String ngaychuyenkt;
	private Integer thang;
	private Integer nam;
	private String giatritt;
	private Integer trangthai;
	private String usercreate;
	private String timecreate;
	private String history;
	private Integer deleted;
	private String filename;
	private String filepath;
	private String filesize;

	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	

	public String getNgaychuyenkt() {
		return ngaychuyenkt;
	}

	public void setNgaychuyenkt(String ngaychuyenkt) {
		this.ngaychuyenkt = ngaychuyenkt;
	}

	public Integer getThang() {
		return thang;
	}

	public void setThang(Integer thang) {
		this.thang = thang;
	}

	public Integer getNam() {
		return nam;
	}

	public void setNam(Integer nam) {
		this.nam = nam;
	}

	public String getGiatritt() {
		return giatritt;
	}

	public void setGiatritt(String giatritt) {
		this.giatritt = giatritt;
	}

	public Integer getTrangthai() {
		return trangthai;
	}

	public void setTrangthai(Integer trangthai) {
		this.trangthai = trangthai;
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

	public String getHistory() {
		return history;
	}

	public void setHistory(String history) {
		this.history = history;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
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

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("ngaychuyenkt", this.ngaychuyenkt);
		map.put("thang", String.valueOf(this.thang));
		map.put("nam", String.valueOf(this.nam));
		map.put("giatritt", this.giatritt);
		map.put("trangthai", String.valueOf(this.trangthai));
		map.put("timecreate", this.timecreate);
		map.put("usercreate", this.usercreate);
		map.put("deleted", String.valueOf(this.deleted));
		map.put("filename",this.filename);
		map.put("filepath",this.filepath);
		map.put("filesize",this.filesize);
		return map;
	}
	
	public static ThanhToanDTO mapObject(ResultSet rs) throws SQLException {
		ThanhToanDTO dto = new ThanhToanDTO();
		dto.setId(rs.getString("ID"));
		dto.setNgaychuyenkt(rs.getString("NGAYCHUYENKT"));
		dto.setThang(rs.getInt("thang"));
		dto.setNam(rs.getInt("nam"));
		dto.setGiatritt(rs.getString("giatritt"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setFilename(rs.getString("filename"));
		dto.setFilepath(rs.getString("filepath"));
		dto.setFilesize(rs.getString("filesize"));
        return dto;
	}
	

}