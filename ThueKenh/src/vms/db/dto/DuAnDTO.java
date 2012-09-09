package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class DuAnDTO extends CatalogDTO{
	private String tenduan;
	private String mota;
	private Integer giamgia;
	private String usercreate;
	private String timecreate;
	
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
		return timecreate;
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
		return map;
	}
	
	public static DuAnDTO mapObject(ResultSet rs) throws SQLException {
		DuAnDTO dto = new DuAnDTO();
		dto.setId(rs.getString("ID"));
		dto.setTenduan(rs.getString("TENDUAN"));
		dto.setMota(rs.getString("MOTA"));
		dto.setGiamgia(rs.getInt("GIAMGIA"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}
