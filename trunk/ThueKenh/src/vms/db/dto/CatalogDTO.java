package vms.db.dto;

import java.sql.ResultSet;

public class CatalogDTO {
	//properties
	protected String id;
	protected String name;
	protected Integer deleted;
	public CatalogDTO(){
	}
	public CatalogDTO(ResultSet rs){
		try{
		setId(rs.getLong("ID"));
		setIsDeleted(rs.getBoolean("DELETED"));
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}

	//getter & setter
	public long getId() {
		return Id;
	}
	public void setId(long l) {
		Id = l;
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
	public Integer getStt() {
		return stt;
	}
	public void setStt(Integer stt) {
		this.stt = stt;
	}
	
}
