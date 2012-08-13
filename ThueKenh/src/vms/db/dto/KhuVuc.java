package vms.db.dto;

public class KhuVuc {

	private Long id;

	private String tenkhuvuc;

	private Boolean deleted;


    public KhuVuc() {
    }


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}



	public String getTenkhuvuc() {
		return tenkhuvuc;
	}


	public void setTenkhuvuc(String tenkhuvuc) {
		this.tenkhuvuc = tenkhuvuc;
	}


	public Boolean getDeleted() {
		return deleted;
	}


	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	
	

	

}