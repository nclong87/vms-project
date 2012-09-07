package vms.db.dto;

public class CatalogDTO {
	//properties
	protected long Id;
	protected String Name;
	protected boolean IsDeleted;
	protected long STT;
	public long getSTT() {
		return STT;
	}
	public void setSTT(long sTT) {
		STT = sTT;
	}
	//getter & setter
	public long getId() {
		return Id;
	}
	public void setId(long l) {
		Id = l;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public boolean isIsDeleted() {
		return IsDeleted;
	}
	public void setIsDeleted(boolean isDeleted) {
		IsDeleted = isDeleted;
	}
}
