package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;

public class CongThucDTO {
	private String id;
	private String tencongthuc;
	private String chuoicongthuc;
	private String usercreate;
	private String timecreate;
	private Integer stt;
	private Integer deleted;
	
	public static CongThucDTO mapObject(ResultSet rs) throws SQLException {
		CongThucDTO dto = new CongThucDTO();
		dto.setId(rs.getString("ID"));
		dto.setTencongthuc(rs.getString("TENCONGTHUC"));
		dto.setChuoicongthuc(rs.getString("CHUOICONGTHUC"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(DateUtils.formatDate(rs.getDate("TIMECREATE"), DateUtils.SDF_DDMMYYYYHHMMSS2));
		
		dto.setStt(rs.getInt("STT"));
		dto.setMa(rs.getString("MA"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
	
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENCONGTHUC", this.tencongthuc);
		map.put("STT", this.stt.toString());
		map.put("MA", this.ma);
		map.put("DELETED", this.deleted.toString());
		map.put("CHUOICONGTHUC", this.chuoicongthuc);
		map.put("USERCREATE", this.usercreate);
		map.put("TIMECREATE", this.timecreate);
		return map;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTencongthuc() {
		return tencongthuc;
	}
	public void setTencongthuc(String tencongthuc) {
		this.tencongthuc = tencongthuc;
	}
	public String getChuoicongthuc() {
		return chuoicongthuc;
	}
	public void setChuoicongthuc(String chuoicongthuc) {
		this.chuoicongthuc = chuoicongthuc;
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
	public String getMa() {
		return ma;
	}
	public void setMa(String ma) {
		this.ma = ma;
	}
	private String ma;
}
