package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class DiemDauCuoiDTO{
	
    private String	id;
	private String  tendiemdaucuoi;
	private Integer deleted;
	private Integer stt;
	private String ma;
	
	

	public static DiemDauCuoiDTO mapObject(ResultSet rs) throws SQLException {
		DiemDauCuoiDTO dto = new DiemDauCuoiDTO();
		dto.setId(rs.getString("ID"));
		dto.setTendiemdaucuoi(rs.getString("TENDIEMDAUCUOI"));
		dto.setStt(rs.getInt("STT"));
		dto.setMa(rs.getString("MA"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
	
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENDIEMDAUCUOI", this.tendiemdaucuoi);
		map.put("STT", this.stt.toString());
		map.put("MA", this.ma);
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	

	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}







	public String getTendiemdaucuoi() {
		return tendiemdaucuoi;
	}

	public void setTendiemdaucuoi(String TENDIEMDAUCUOI) {
		this.tendiemdaucuoi = TENDIEMDAUCUOI;
	}

	public Integer getDeleted() {
		return deleted;
	}



	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}



	public Integer getStt() {
		return stt;
	}



	public void setStt(Integer stt) {
		this.stt = stt;
	}



	public String getMa() {
		return ma;
	}



	public void setMa(String ma) {
		this.ma = ma;
	}





	
}
