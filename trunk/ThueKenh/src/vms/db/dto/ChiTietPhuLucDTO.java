package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the CHITIETPHULUC database table.
 * Sau khi tinh gia tri phu luc se luu vao bang nay
 * 
 */
public class ChiTietPhuLucDTO {

	private String id;
	private String tenchitietphuluc;
	private Long cuocdaunoi;
	private Long giatritruocthue;
	private Long giatrisauthue;
	private String usercreate;
	private String timecreate;
	private Integer deleted;
	private String soluongkenh;

    public ChiTietPhuLucDTO() {

    }
    
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTenchitietphuluc() {
		return tenchitietphuluc;
	}

	public void setTenchitietphuluc(String tenchitietphuluc) {
		this.tenchitietphuluc = tenchitietphuluc;
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

	public String getSoluongkenh() {
		return soluongkenh;
	}

	public void setSoluongkenh(String soluongkenh) {
		this.soluongkenh = soluongkenh;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("soluongkenh", this.soluongkenh);
		map.put("tenchitietphuluc", this.tenchitietphuluc);
		map.put("timecreate", this.timecreate);
		map.put("usercreate", this.usercreate);
		map.put("cuocdaunoi", String.valueOf(this.cuocdaunoi));
		map.put("deleted", String.valueOf(this.deleted));
		map.put("giatrisauthue", String.valueOf(this.giatrisauthue));
		map.put("giatritruocthue",String.valueOf( this.giatritruocthue));
		return map;
	}
	
	public static ChiTietPhuLucDTO mapObject(ResultSet rs) throws SQLException {
		ChiTietPhuLucDTO dto = new ChiTietPhuLucDTO();
		dto.setId(rs.getString("ID"));
		dto.setCuocdaunoi(rs.getLong("CUOCDAUNOI"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setGiatrisauthue(rs.getLong("GIATRISAUTHUE"));
		dto.setGiatritruocthue(rs.getLong("GIATRITRUOCTHUE"));
		dto.setSoluongkenh(rs.getString("SOLUONGKENH"));
		dto.setTenchitietphuluc(rs.getString("TENCHITIETPHULUC"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setUsercreate(rs.getString("USERCREATE"));
        return dto;
	}
	

}