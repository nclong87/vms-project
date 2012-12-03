package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class TramDTO {

	private String id = "";
	private String matram = "";
	private String diachi = "";
	private Integer deleted = 0;

    public TramDTO() {

    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMatram() {
		return matram;
	}

	public void setMatram(String matram) {
		this.matram = matram;
	}

	public String getDiachi() {
		return diachi;
	}

	public void setDiachi(String diachi) {
		this.diachi = diachi;
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
		map.put("matram", this.matram);
		map.put("diachi", this.diachi);
		map.put("deleted", String.valueOf(this.deleted));
		return map;
	}
    
	public static TramDTO mapObject(ResultSet rs) throws SQLException {
		TramDTO dto = new TramDTO();
		dto.setId(rs.getString("ID"));
		dto.setMatram(rs.getString("MATRAM"));
		String diachi=rs.getString("DIACHI");
		System.out.println("diachi:"+diachi);
		if(diachi=="null")
			diachi="";
		dto.setDiachi(diachi);
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}