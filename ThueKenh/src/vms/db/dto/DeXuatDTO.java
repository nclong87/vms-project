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
public class DeXuatDTO {

	private String id = "";
	private String doitac_id = "";
	private String tenvanban = "";
	private String ngaygui = "";
	private String ngaydenghibangiao = "";
	private String thongtinthem = "";
	private String history = "";
	private String usercreate = "";
	private String timecreate = "";
	private Integer deleted = 0;
	private Integer trangthai = 0;
	private String filename = "";
	private String filepath = "";
	private Integer filesize = 0;
	
    public DeXuatDTO() {

    }
    
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

	public Integer getFilesize() {
		return filesize;
	}

	public void setFilesize(Integer filesize) {
		this.filesize = filesize;
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

	public String getThongtinthem() {
		return thongtinthem;
	}

	public void setThongtinthem(String thongtinthem) {
		this.thongtinthem = thongtinthem;
	}

	public String getHistory() {
		return history;
	}

	public void setHistory(String history) {
		this.history = history;
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

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public Integer getTrangthai() {
		return trangthai;
	}

	public void setTrangthai(Integer trangthai) {
		this.trangthai = trangthai;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("doitac_id", this.doitac_id);
		map.put("filename", this.filename);
		map.put("filepath", this.filepath);
		map.put("filesize", String.valueOf(this.filesize));
		map.put("tenvanban", this.tenvanban);
		map.put("ngaygui", this.ngaygui);
		map.put("ngaydenghibangiao", this.ngaydenghibangiao);
		map.put("thongtinthem", this.thongtinthem);
		map.put("history", this.history);
		map.put("usercreate", this.usercreate);
		map.put("timecreate", this.timecreate);
		map.put("deleted", String.valueOf(this.deleted));
		map.put("trangthai", String.valueOf(this.trangthai));
		return map;
	}
	
	public static DeXuatDTO mapObject(ResultSet rs) throws SQLException {
		DeXuatDTO dto = new DeXuatDTO();
		dto.setId(rs.getString("ID"));
		dto.setDoitac_id(rs.getString("DOITAC_ID"));
		dto.setFilename(rs.getString("FILENAME"));
		dto.setFilepath(rs.getString("FILEPATH"));
		dto.setFilesize(rs.getInt("FILESIZE"));
		dto.setTenvanban(rs.getString("TENVANBAN"));
		dto.setNgaygui(DateUtils.formatDate(rs.getDate("NGAYGUI"), DateUtils.SDF_DDMMYYYY));
		dto.setNgaydenghibangiao(DateUtils.formatDate(rs.getDate("NGAYDENGHIBANGIAO"), DateUtils.SDF_DDMMYYYY));
		dto.setThongtinthem(rs.getString("THONGTINTHEM"));
		dto.setHistory(rs.getString("HISTORY"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
        return dto;
	}
	

}