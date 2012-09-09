package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class PhongBanDTO extends CatalogDTO{
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("TENPHONGBAN", this.name);
		map.put("STT", this.stt.toString());
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	public static PhongBanDTO mapObject(ResultSet rs) throws SQLException {
		PhongBanDTO dto = new PhongBanDTO();
		dto.setId(rs.getString("ID"));
		dto.setName(rs.getString("TENPHONGBAN"));
		dto.setStt(rs.getInt("STT"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
}
