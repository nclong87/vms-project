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
public class HopDongDetailDTO {

	private String id;
	private String tendoitac;
	private String sohopdong;
	/*
	 * Description loaihopdong :
	 * 1 : co thoi han
	 * 0 : vo thoi han
	 */
	private Integer loaihopdong;
	private String ngayky;
	private String ngayhethan;
	private Integer trangthai;
	private String usercreate;
	private String timecreate;
	private String history;
	private Integer deleted;

    public HopDongDetailDTO() {

    }
    

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTendoitac() {
		return tendoitac;
	}


	public void setTendoitac(String tendoitac) {
		this.tendoitac = tendoitac;
	}


	public String getSohopdong() {
		return sohopdong;
	}


	public void setSohopdong(String sohopdong) {
		this.sohopdong = sohopdong;
	}


	public Integer getLoaihopdong() {
		return loaihopdong;
	}


	public void setLoaihopdong(Integer loaihopdong) {
		this.loaihopdong = loaihopdong;
	}


	public String getNgayky() {
		return ngayky;
	}


	public void setNgayky(String ngayky) {
		this.ngayky = ngayky;
	}


	public String getNgayhethan() {
		return ngayhethan;
	}


	public void setNgayhethan(String ngayhethan) {
		this.ngayhethan = ngayhethan;
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


	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("tendoitac", this.tendoitac);
		map.put("history", this.history);
		map.put("loaihopdong", String.valueOf(this.loaihopdong));
		map.put("ngayhethan", this.ngayhethan);
		map.put("ngayky", this.ngayky);
		map.put("sohopdong", this.sohopdong);
		map.put("timecreate", this.timecreate);
		map.put("usercreate", this.usercreate);
		map.put("deleted", String.valueOf(this.deleted));
		map.put("trangthai", String.valueOf(this.trangthai));
		return map;
	}
	
	public static HopDongDetailDTO mapObject(ResultSet rs) throws SQLException {
		HopDongDetailDTO dto = new HopDongDetailDTO();
		dto.setId(rs.getString("ID"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setTendoitac(rs.getString("TENDOITAC"));
		dto.setHistory(rs.getString("HISTORY"));
		dto.setLoaihopdong(rs.getInt("LOAIHOPDONG"));
		dto.setNgayhethan(DateUtils.formatDate(rs.getDate("NGAYHETHAN"), DateUtils.SDF_DDMMYYYY));
		dto.setNgayky(DateUtils.formatDate(rs.getDate("NGAYKY"), DateUtils.SDF_DDMMYYYY));
		dto.setSohopdong(rs.getString("SOHOPDONG"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
        return dto;
	}
	

}