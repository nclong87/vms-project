package vms.db.dto;

import java.sql.ResultSet;

public class CongThucDTO extends CatalogDTO {
	public CongThucDTO(ResultSet rs) {
		super(rs);
		try {
			setChoiCongThuc(rs.getString("chuoicongthuc"));
			setName(rs.getString("tencongthuc"));
			setSTT(rs.getInt("stt"));
			setTimeCreate(rs.getString("timecreate"));
			setUserCreate(rs.getString("usercreate"));
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Khong tao dc doi tuong CONGTHUC");
		}
	}

	private String ChoiCongThuc;
	private String UserCreate;
	private String TimeCreate;
	private int STT;

	public String getChoiCongThuc() {
		return ChoiCongThuc;
	}

	public void setChoiCongThuc(String choiCongThuc) {
		ChoiCongThuc = choiCongThuc;
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

	public int getSTT() {
		return STT;
	}

	public void setSTT(int sTT) {
		STT = sTT;
	}
}
