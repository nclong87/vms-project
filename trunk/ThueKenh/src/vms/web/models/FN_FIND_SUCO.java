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
public class FN_FIND_SUCO {
	private String suco_id;
	private String tuyenkenh_id;
	private String madiemdau;
	private String madiemcuoi;
	private String loaigiaotiep;
	private String dungluong;
	private String soluong;
	private String thoidiembatdau;
	private String thoidiemketthuc;
	private String thoigianmll;
	private String nguyennhan;
	private String phuonganxuly;
	private String nguoixacnhan;
	private String usercreate;
	private String timecreate;
	private String filename;
	private String filepath;
	private String filesize;
	
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
		return suco_id;
	}

	public void setId(String id) {
		this.suco_id = id;
	}

	public String getTuyekenh_id() {
		return tuyenkenh_id;
	}

	public void setTuyekenh_id(String tuyekenh_id) {
		this.tuyenkenh_id = tuyekenh_id;
	}

	public String getMadiemdau() {
		return madiemdau;
	}

	public void setMadiemdau(String madiemdau) {
		this.madiemdau = madiemdau;
	}

	public String getMadiemcuoi() {
		return madiemcuoi;
	}

	public void setMadiemcuoi(String madiemcuoi) {
		this.madiemcuoi = madiemcuoi;
	}

	public String getLoaigiaotiep() {
		return loaigiaotiep;
	}

	public void setLoaigiaotiep(String loaigiaotiep) {
		this.loaigiaotiep = loaigiaotiep;
	}

	public String getDungluong() {
		return dungluong;
	}

	public void setDungluong(String dungluong) {
		this.dungluong = dungluong;
	}

	public String getSoluong() {
		return soluong;
	}

	public void setSoluong(String soluong) {
		this.soluong = soluong;
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

	public String getThoigianmll() {
		return thoigianmll;
	}

	public void setThoigianmll(String thoigianmll) {
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
		map.put("id", this.suco_id);
		map.put("tuyenkenh_id", this.tuyenkenh_id);
		map.put("madiemdau", this.madiemdau);
		map.put("madiemcuoi", this.madiemcuoi);
		map.put("loaigiaotiep", this.loaigiaotiep);
		map.put("dungluong", this.dungluong);
		map.put("soluong", this.soluong);
		map.put("thoidiembatdau", this.thoidiembatdau);
		map.put("thoidiemketthuc", this.thoidiemketthuc);
		map.put("thoigianmll", this.thoigianmll);
		map.put("nguyennhan", this.nguyennhan);
		map.put("phuonganxuly", this.phuonganxuly);
		map.put("nguoixacnhan", this.nguoixacnhan);
		map.put("usercreate", this.usercreate);
		map.put("timecreate", this.timecreate);
		map.put("filename", this.filename);
		map.put("filepath", this.filepath);
		map.put("filesize", this.filesize);
		return map;
	}

	public static FN_FIND_SUCO mapObject(ResultSet rs) throws SQLException {
		FN_FIND_SUCO dto = new FN_FIND_SUCO();
		dto.setId(rs.getString("suco_id"));
		dto.setTuyekenh_id(rs.getString("tuyenkenh_id"));
		dto.setMadiemdau(rs.getString("madiemdau"));
		dto.setMadiemcuoi(rs.getString("madiemcuoi"));
		dto.setLoaigiaotiep(rs.getString("loaigiaotiep"));
		dto.setDungluong(rs.getString("dungluong"));
		dto.setSoluong(rs.getString("soluong"));
		dto.setThoidiembatdau(DateUtils.formatDate(rs.getDate("thoidiembatdau"),DateUtils.SDF_DDMMYYYYHHMMSS2));
		dto.setThoidiemketthuc(DateUtils.formatDate(rs.getDate("thoidiemketthuc"),DateUtils.SDF_DDMMYYYYHHMMSS2));
		dto.setThoigianmll(rs.getString("thoigianmll"));
		dto.setNguyennhan(rs.getString("nguyennhan"));
		dto.setPhuonganxuly(rs.getString("phuonganxuly"));
		dto.setNguoixacnhan(rs.getString("nguoixacnhan"));
		dto.setUsercreate(rs.getString("usercreate"));
		dto.setTimecreate(DateUtils.formatDate(rs.getDate("timecreate"),DateUtils.SDF_DDMMYYYY));
		dto.setFilename(rs.getString("filename"));
		dto.setFilepath(rs.getString("filepath"));
		dto.setFilesize(rs.getString("filesize"));
        return dto;
	}

	

}