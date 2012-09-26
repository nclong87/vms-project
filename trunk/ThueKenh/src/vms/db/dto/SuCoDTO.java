package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;

public class SuCoDTO {
	//attribute
	private String id="";
	private String tuyenkenh_id="";
	private String phuluc_id="";
	private String thanhtoan_id="";
	private String thoidiembatdau="";
	private String thoidiemketthuc="";
	private Integer thoigianmll=0;
	private String nguyennhan="";
	private String phuonganxuly="";
	private String nguoixacnhan="";
	private long giamtrumll=0;
	private Integer trangthai=0;
	private String usercreate="";
	private String timecreate="";
	private Integer deleted=0;
	private String filename="";
	public String filepath="";
	public String filesize="";
	
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTuyenkenh_id() {
		return tuyenkenh_id;
	}

	public void setTuyenkenh_id(String tuyenkenh_id) {
		this.tuyenkenh_id = tuyenkenh_id;
	}


	public String getPhuluc_id() {
		return phuluc_id;
	}

	public void setPhuluc_id(String phuluc_id) {
		this.phuluc_id = phuluc_id;
	}

	public String getThanhtoan_id() {
		return thanhtoan_id;
	}

	public void setThanhtoan_id(String thanhtoan_id) {
		this.thanhtoan_id = thanhtoan_id;
	}

	public String getThoidiembatdau() {
		return thoidiembatdau;
	}

	public void setThoidiembatdau(String thoidiembatdau) {
		this.thoidiembatdau = thoidiembatdau;
	}

	public String getThoidiemketthuc() {
		return thoidiemketthuc;
	}

	public void setThoidiemketthuc(String thoidiemketthuc) {
		this.thoidiemketthuc = thoidiemketthuc;
		
	}

	public Integer getThoigianmll() {
		return thoigianmll;
	}

	public void setThoigianmll(Integer thoigianmll) {
		this.thoigianmll = thoigianmll;
	}

	public String getNguyennhan() {
		return nguyennhan;
	}

	public void setNguyennhan(String nguyennhan) {
		this.nguyennhan = nguyennhan;
	}

	public String getPhuonganxuly() {
		return phuonganxuly;
	}

	public void setPhuonganxuly(String phuonganxuly) {
		this.phuonganxuly = phuonganxuly;
	}

	public String getNguoixacnhan() {
		return nguoixacnhan;
	}

	public void setNguoixacnhan(String nguoixacnhan) {
		this.nguoixacnhan = nguoixacnhan;
	}

	public long getGiamtrumll() {
		return giamtrumll;
	}

	public void setGiamtrumll(long giamtrumll) {
		this.giamtrumll = giamtrumll;
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

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("tuyenkenh_id",this.tuyenkenh_id);
		map.put("phuluc_id",this.phuluc_id);
		map.put("thanhtoan_id",this.thanhtoan_id);
		map.put("thoidiembatdau",this.thoidiembatdau);
		map.put("thoidiemketthuc",this.thoidiemketthuc);
		map.put("thoigianmll",String.valueOf(this.thoigianmll));
		map.put("nguyennhan",this.nguyennhan);
		map.put("phuonganxuly",this.phuonganxuly);
		map.put("nguoixacnhan",this.nguoixacnhan);
		map.put("giamtrumll",String.valueOf(this.giamtrumll));
		map.put("trangthai",String.valueOf(this.trangthai));
		map.put("usercreate",this.usercreate);
		map.put("timecreate",this.timecreate);
		map.put("deleted",String.valueOf(this.deleted));
		map.put("filename",this.filename);
		map.put("filepath",this.filepath);
		map.put("filesize",this.filesize);
		return map;
	}
	
	public static SuCoDTO mapObject(ResultSet rs) throws SQLException {
		SuCoDTO dto = new SuCoDTO();
		dto.setId(rs.getString("ID"));
		dto.setTuyenkenh_id(rs.getString("TUYENKENH_ID"));
		dto.setThanhtoan_id(rs.getString("THANHTOAN_ID"));
		dto.setThoidiembatdau(DateUtils.formatDate(rs.getDate("THOIDIEMBATDAU"), DateUtils.SDF_DDMMYYYYHHMMSS2));
		dto.setThoidiemketthuc(DateUtils.formatDate(rs.getDate("THOIDIEMKETTHUC"), DateUtils.SDF_DDMMYYYYHHMMSS2));
		dto.setThoigianmll(rs.getInt("THOIGIANMLL"));
		dto.setNguyennhan(rs.getString("NGUYENNHAN"));
		dto.setPhuonganxuly(rs.getString("PHUONGANXULY"));
		dto.setNguoixacnhan(rs.getString("NGUOIXACNHAN"));
		dto.setGiamtrumll(rs.getLong("GIAMTRUMLL"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(DateUtils.formatDate(rs.getDate("TIMECREATE"), DateUtils.SDF_DDMMYYYY));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setFilename(rs.getString("FILENAME"));
		dto.setFilepath(rs.getString("FILEPATH"));
		dto.setFilesize(rs.getString("FILESIZE"));
        return dto;
	}
}
