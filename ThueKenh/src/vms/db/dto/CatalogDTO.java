package vms.db.dto;

import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class CatalogDTO {
	//properties
	protected String id;
	protected String name;
	protected Integer deleted;
	protected Integer stt;
	public Integer getStt() {
		return stt;
	}
	public void setStt(Integer stt) {
		this.stt = stt;
	}
	public CatalogDTO(){
	}
	public CatalogDTO(ResultSet rs){
		try{
		setId(rs.getString("ID"));
		setDeleted(rs.getInt("DELETED"));
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.putAll(map);
		map.put("ID", this.id);
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	

	//getter & setter
	public String getId() {
		return id;
	}
	public void setId(String l) {
		id = l;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getDeleted() {
		return deleted;
	}
	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}
	
}
