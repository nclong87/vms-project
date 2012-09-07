package vms.db.dto;

public class DuAnDTO extends CatalogDTO{
	private String MoTa;
	private String GiamGia;
	private String UserCreate;
	private String TimeCreate;
	public String getMoTa() {
		return MoTa;
	}
	public void setMoTa(String moTa) {
		MoTa = moTa;
	}
	public String getGiamGia() {
		return GiamGia;
	}
	public void setGiamGia(String giamGia) {
		GiamGia = giamGia;
	}
	public String getUserCreate() {
		return UserCreate;
	}
	public void setUserCreate(String userCreate) {
		UserCreate = userCreate;
	}
	public String getTimeCreate() {
		return TimeCreate;
	}
	public void setTimeCreate(String timeCreate) {
		TimeCreate = timeCreate;
	}
}
