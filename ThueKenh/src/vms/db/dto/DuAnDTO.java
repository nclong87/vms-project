package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;

public class DuAnDTO{
	private String tenduan;
	private String mota;
	private Integer giamgia;
	private String usercreate;
	private String timecreate;
	private String ma;
	private String id;
	private Integer stt;
	private Integer deleted;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getStt() {
		return stt;
	}

	public void setStt(Integer stt) {
		this.stt = stt;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public String getMota() {
		return mota;
	}

	public void setMota(String mota) {
		this.mota = mota;
	}

	public Integer getGiamgia() {
		return giamgia;
	}

	public void setGiamgia(Integer giamgia) {
		this.giamgia = giamgia;
	}

	public String getUsercreate() {
		return usercreate;
	}

	public void setUsercreate(String usercreate) {
		this.usercreate = usercreate;
	}

	public String getTimecreate() {
		return timecreate.split(" ")[0];
	}

	public void setTimecreate(String timecreate) {
		this.timecreate = timecreate;
	}
	
	public String getTenduan() {
		return tenduan;
	}

	public void setTenduan(String tenduan) {
		this.tenduan = tenduan;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENDUAN", this.tenduan);
		map.put("MOTA", this.mota);
		map.put("GIAMGIA", this.giamgia.toString());
		map.put("USERCREATE", this.usercreate);
		map.put("TIMECREATE", this.timecreate);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		map.put("MA", this.ma);
		return map;
	}
	
	public static DuAnDTO mapObject(ResultSet rs) throws SQLException {
		//System.out.println("map duanDTO start");
		DuAnDTO dto = new DuAnDTO();
		dto.setId(rs.getString("ID"));
		dto.setTenduan(rs.getString("TENDUAN"));
		dto.setMota(rs.getString("MOTA"));
		dto.setGiamgia(rs.getInt("GIAMGIA"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(DateUtils.formatDate(rs.getDate("TIMECREATE"), DateUtils.SDF_DDMMYYYYHHMMSS2));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setMa(rs.getString("MA"));
		//System.out.println("map duanDTO end");
        return dto;
	}

	public String getMa() {
		return ma;
	}

	public void setMa(String ma) {
		this.ma = ma;
	}
}
