package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class DoiTacDTO extends CatalogDTO{
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENDOITAC", this.name);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	public static DoiTacDTO mapObject(ResultSet rs) throws SQLException {
		DoiTacDTO dto = new DoiTacDTO();
		dto.setId(rs.getString("ID"));
		dto.setName(rs.getString("TENDOITAC"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}
