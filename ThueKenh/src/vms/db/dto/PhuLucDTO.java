package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;
import vms.utils.VMSUtil;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class PhuLucDTO {

	private String id;
	private String chitietphuluc_id;
	private String hopdong_id;
	private String tenphuluc;
	
	/*
	 * Description loaiphuluc :
	 * 1 : doc lap
	 * 2 : thay the
	 */
	private Integer loaiphuluc;
	private String ngayky;
	private String ngayhieuluc;
	private Integer thang; // da thanh toan den thang 
	private Integer nam; // da thanh toan den nam
	private Integer trangthai;
	private String usercreate;
	private String timecreate;
	private Integer deleted;
	private String ngayhethieuluc;
	private String filename;
	private String filepath;
	private String filesize;
	private String phulucthaythe_id;
	private Long cuocdaunoi;
	private Long giatritruocthue;
	private Long giatrisauthue;
	private String soluongkenh;

    public PhuLucDTO() {

    }
    
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getChitietphuluc_id() {
		return chitietphuluc_id;
	}

	public void setChitietphuluc_id(String chitietphuluc_id) {
		this.chitietphuluc_id = chitietphuluc_id;
	}

	public String getHopdong_id() {
		return hopdong_id;
	}

	public void setHopdong_id(String hopdong_id) {
		this.hopdong_id = hopdong_id;
	}

	public String getTenphuluc() {
		return tenphuluc;
	}

	public void setTenphuluc(String tenphuluc) {
		this.tenphuluc = tenphuluc;
	}

	public Integer getLoaiphuluc() {
		return loaiphuluc;
	}

	public void setLoaiphuluc(Integer loaiphuluc) {
		this.loaiphuluc = loaiphuluc;
	}

	public String getNgayky() {
		return ngayky;
	}

	public void setNgayky(String ngayky) {
		this.ngayky = ngayky;
	}

	public String getNgayhieuluc() {
		return ngayhieuluc;
	}

	public void setNgayhieuluc(String ngayhieuluc) {
		this.ngayhieuluc = ngayhieuluc;
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

	public String getNgayhethieuluc() {
		return ngayhethieuluc;
	}

	public void setNgayhethieuluc(String ngayhethieuluc) {
		this.ngayhethieuluc = ngayhethieuluc;
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

	public String getPhulucthaythe_id() {
		return phulucthaythe_id;
	}

	public void setPhulucthaythe_id(String phulucthaythe_id) {
		this.phulucthaythe_id = phulucthaythe_id;
	}
	
	public Long getCuocdaunoi() {
		return cuocdaunoi;
	}

	public void setCuocdaunoi(Long cuocdaunoi) {
		this.cuocdaunoi = cuocdaunoi;
	}

	public Long getGiatritruocthue() {
		return giatritruocthue;
	}

	public void setGiatritruocthue(Long giatritruocthue) {
		this.giatritruocthue = giatritruocthue;
	}

	public Long getGiatrisauthue() {
		return giatrisauthue;
	}

	public void setGiatrisauthue(Long giatrisauthue) {
		this.giatrisauthue = giatrisauthue;
	}

	public String getSoluongkenh() {
		return soluongkenh;
	}

	public void setSoluongkenh(String soluongkenh) {
		this.soluongkenh = soluongkenh;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("chitietphuluc_id", this.chitietphuluc_id);
		map.put("filename", this.filename);
		map.put("filepath", this.filepath);
		map.put("filesize", this.filesize);
		map.put("hopdong_id", this.hopdong_id);
		map.put("ngayhethieuluc", this.ngayhethieuluc);
		map.put("ngayhieuluc", this.ngayhieuluc);
		map.put("ngayky", this.ngayky);
		map.put("phulucthaythe_id", this.phulucthaythe_id);
		map.put("tenphuluc", this.tenphuluc);
		map.put("timecreate", this.timecreate);
		map.put("usercreate", this.usercreate);
		map.put("deleted", String.valueOf(this.deleted));
		map.put("loaiphuluc", String.valueOf(this.loaiphuluc));
		map.put("nam", String.valueOf(this.nam));
		map.put("thang", String.valueOf(this.thang));
		map.put("trangthai", String.valueOf(this.trangthai));
		map.put("cuocdaunoi", String.valueOf(this.cuocdaunoi));
		map.put("giatritruocthue", String.valueOf(this.giatritruocthue));
		map.put("giatrisauthue", String.valueOf(this.giatrisauthue));
		map.put("soluongkenh", this.soluongkenh);
		return map;
	}
	
	public static PhuLucDTO mapObject(ResultSet rs) throws SQLException {
		PhuLucDTO dto = new PhuLucDTO();
		dto.setId(rs.getString("ID"));
		dto.setChitietphuluc_id(rs.getString("CHITIETPHULUC_ID"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setFilename(rs.getString("FILENAME"));
		dto.setFilepath(rs.getString("FILEPATH"));
		dto.setFilesize(rs.getString("FILESIZE"));
		dto.setHopdong_id(rs.getString("HOPDONG_ID"));
		dto.setLoaiphuluc(rs.getInt("LOAIPHULUC"));
		dto.setNam(rs.getInt("NAM"));
		dto.setThang(rs.getInt("THANG"));
		dto.setNgayhethieuluc(DateUtils.formatDate(rs.getDate("NGAYHETHIEULUC"), DateUtils.SDF_DDMMYYYY));
		dto.setNgayhieuluc(DateUtils.formatDate(rs.getDate("NGAYHIEULUC"), DateUtils.SDF_DDMMYYYY));
		dto.setNgayky(DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
		dto.setPhulucthaythe_id(rs.getString("PHULUCTHAYTHE_ID"));
		dto.setTenphuluc(rs.getString("TENPHULUC"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setCuocdaunoi(rs.getLong("CUOCDAUNOI"));
		dto.setGiatritruocthue(rs.getLong("GIATRITRUOCTHUE"));
		dto.setGiatrisauthue(rs.getLong("GIATRISAUTHUE"));
		dto.setSoluongkenh(rs.getString("SOLUONGKENH"));
        return dto;
	}
	
	public static Map<String,Object> resultSetToMap(ResultSet rs) throws SQLException {
		Map<String,Object> map = VMSUtil.resultSetToMap(rs);
		map.put("ngayky", DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
		map.put("ngayhieuluc", DateUtils.formatDate(rs.getDate("NGAYHIEULUC"), DateUtils.SDF_DDMMYYYY));
		map.put("ngayhethieuluc", DateUtils.formatDate(rs.getDate("NGAYHETHIEULUC"), DateUtils.SDF_DDMMYYYY));
		return map;
	}

}