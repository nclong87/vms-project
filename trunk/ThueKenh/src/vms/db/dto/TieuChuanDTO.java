package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class TieuChuanDTO {
	private String id;
	private String tentieuchuan;
	private String mota;
	private String loaitieuchuan;
	private String usercreate;
	private String timecreate;
	private Integer stt;
	private Integer deleted;
	private String ma;
	
	public String getMa() {
		return ma;
	}

	public void setMa(String ma) {
		this.ma = ma;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENTIEUCHUAN", this.tentieuchuan);
		map.put("MOTA", this.mota);
		map.put("LOAITIEUCHUAN", this.loaitieuchuan);
		map.put("USERCREATE", this.usercreate);
		map.put("TIMECREATE", this.timecreate);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		map.put("MA", this.ma);
		return map;
	}
	
	public static TieuChuanDTO mapObject(ResultSet rs) throws SQLException {
		//System.out.println("map duanDTO start");
		TieuChuanDTO dto = new TieuChuanDTO();
		dto.setId(rs.getString("ID"));
		dto.setTentieuchuan(rs.getString("TENTIEUCHUAN"));
		dto.setMota(rs.getString("MOTA"));
		dto.setLoaitieuchuan(rs.getString("LOAITIEUCHUAN"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setMa(rs.getString("MA"));
        return dto;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTentieuchuan() {
		return tentieuchuan;
	}
	public void setTentieuchuan(String tentieuchuan) {
		this.tentieuchuan = tentieuchuan;
	}
	public String getLoaitieuchuan() {
		return loaitieuchuan;
	}
	public void setLoaitieuchuan(String loaitieuchuan) {
		this.loaitieuchuan = loaitieuchuan;
	}
	public String getMota() {
		return mota;
	}
	public void setMota(String mota) {
		this.mota = mota;
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
}
