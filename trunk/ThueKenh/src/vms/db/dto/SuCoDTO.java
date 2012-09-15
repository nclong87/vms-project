package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;

public class SuCoDTO {
	//attribute
	public String id="";
	public String tuyenkenh_id="";
	public String filescan_id="";
	public String phuluc_id="";
	public String thanhtoan_id="";
	public String loaisuco="";
	public String thoidiembatdau="";
	public String thoidiemketthuc="";
	public Integer thoigianmll=0;
	public String nguyennhan="";
	public String phuonganxuly="";
	public String nguoixacnhan="";
	public long giamtrumll=0;
	public Integer trangthai=0;
	public String usercreate="";
	public String timecreate="";
	public Integer deleted=0;
	
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

	public String getFilescan_id() {
		return filescan_id;
	}

	public void setFilescan_id(String filescan_id) {
		this.filescan_id = filescan_id;
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

	public String getLoaisuco() {
		return loaisuco;
	}

	public void setLoaisuco(String loaisuco) {
		this.loaisuco = loaisuco;
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
		map.put("filescan_id",this.filescan_id);
		map.put("phuluc_id",this.phuluc_id);
		map.put("thanhtoan_id",this.thanhtoan_id);
		map.put("loaisuco",this.loaisuco);
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
		return map;
	}
	
	public static SuCoDTO mapObject(ResultSet rs) throws SQLException {
		SuCoDTO dto = new SuCoDTO();
		dto.setId(rs.getString("ID"));
		dto.setTuyenkenh_id(rs.getString("TUYENKENH_ID"));
		dto.setFilescan_id(rs.getString("PHULUC_ID"));
		dto.setThanhtoan_id(rs.getString("THANHTOAN_ID"));
		dto.setLoaisuco(rs.getString("LOAISUCO"));
		dto.setThoidiembatdau(DateUtils.formatDate(rs.getDate("THOIDIEMBATDAU"), DateUtils.SDF_DDMMYYYY));
		dto.setThoidiemketthuc(DateUtils.formatDate(rs.getDate("THOIDIEMKETTHUC"), DateUtils.SDF_DDMMYYYY));
		dto.setThoigianmll(rs.getInt("THOIGIANMLL"));
		dto.setNguyennhan(rs.getString("NGUYENNHAN"));
		dto.setPhuonganxuly(rs.getString("PHUONGANXULY"));
		dto.setNguoixacnhan(rs.getString("NGUOIXACNHAN"));
		dto.setGiamtrumll(rs.getLong("GIAMTRUMLL"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(DateUtils.formatDate(rs.getDate("TIMECREATE"), DateUtils.SDF_DDMMYYYY));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}
