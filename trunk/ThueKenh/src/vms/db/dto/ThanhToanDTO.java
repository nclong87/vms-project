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

	private String id="";
	private String sohoso="";
	private String ngaychuyenkt="";
	private Integer trangthai=0;
	private String usercreate="";
	private String timecreate="";
	private String history="";
	private Integer deleted=0;
	private String filename="";
	private String filepath="";
	private String filesize="";
	private String doisoatcuoc_id="";
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	

	public String getSohoso() {
		return sohoso;
	}

	public void setSohoso(String sohoso) {
		this.sohoso = sohoso;
	}

	public String getNgaychuyenkt() {
		return ngaychuyenkt;
	}

	public void setNgaychuyenkt(String ngaychuyenkt) {
		this.ngaychuyenkt = ngaychuyenkt;
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

	
	public String getDoisoatcuoc_id() {
		return doisoatcuoc_id;
	}

	public void setDoisoatcuoc_id(String doisoatcuoc_id) {
		this.doisoatcuoc_id = doisoatcuoc_id;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("sohoso", this.sohoso);
		map.put("ngaychuyenkt", this.ngaychuyenkt);
		map.put("trangthai", String.valueOf(this.trangthai));
		map.put("timecreate", this.timecreate);
		map.put("usercreate", this.usercreate);
		map.put("deleted", String.valueOf(this.deleted));
		map.put("filename",this.filename);
		map.put("filepath",this.filepath);
		map.put("filesize",this.filesize);
		map.put("doisoatcuoc_id",this.doisoatcuoc_id);
		return map;
	}
	
	public static ThanhToanDTO mapObject(ResultSet rs) throws SQLException {
		ThanhToanDTO dto = new ThanhToanDTO();
		dto.setId(rs.getString("ID"));
		dto.setSohoso(rs.getString("SOHOSO"));
		dto.setNgaychuyenkt(DateUtils.formatDate(rs.getDate("NGAYCHUYENKT"), DateUtils.SDF_DDMMYYYY));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setFilename(rs.getString("filename"));
		dto.setFilepath(rs.getString("filepath"));
		dto.setFilesize(rs.getString("filesize"));
		dto.setDoisoatcuoc_id(rs.getString("doisoatcuoc_id"));
        return dto;
	}
	

}