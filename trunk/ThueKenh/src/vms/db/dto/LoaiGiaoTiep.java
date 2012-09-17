package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class LoaiGiaoTiep {

	private Integer deleted;

	private String id;

	private String loaigiaotiep;

	private Long cuoccong;
	
	private String ma;

    public LoaiGiaoTiep() {
    }

	

	public Integer getDeleted() {
		return deleted;
	}



	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getLoaigiaotiep() {
		return loaigiaotiep;
	}



	public void setLoaigiaotiep(String loaigiaotiep) {
		this.loaigiaotiep = loaigiaotiep;
	}



	public Long getCuoccong() {
		return cuoccong;
	}



	public void setCuoccong(Long cuoccong) {
		this.cuoccong = cuoccong;
	}



	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.getId());
		map.put("LOAIGIAOTIEP", this.getLoaigiaotiep());
		map.put("CUOCCONG", this.getCuoccong().toString());
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	public static LoaiGiaoTiep mapObject(ResultSet rs) throws SQLException {
		LoaiGiaoTiep dto = new LoaiGiaoTiep();
		dto.setId(rs.getString("ID"));
		dto.setLoaigiaotiep(rs.getString("LOAIGIAOTIEP"));
		dto.setCuoccong(rs.getLong("CUOCCONG"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
	

}