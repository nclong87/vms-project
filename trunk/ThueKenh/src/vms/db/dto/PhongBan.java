package vms.db.dto;

public class PhongBan {

	private Long id;

	private String tenphongban;

	private Boolean deleted;


    public PhongBan() {
    }


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getTenphongban() {
		return tenphongban;
	}


	public void setTenphongban(String tenphongban) {
		this.tenphongban = tenphongban;
	}


	public Boolean getDeleted() {
		return deleted;
	}


	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	
	

	

}