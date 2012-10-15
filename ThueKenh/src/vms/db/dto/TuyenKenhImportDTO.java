package vms.db.dto;

import java.util.Date;




/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class TuyenKenhImportDTO {

	private Integer stt = 0;
	private String madiemdau = "";
	private String madiemcuoi = "";
	private String giaotiep_ma = "";
	private String duan_ma = "";
	private String phongban_ma = "";
	private String doitac_ma = "";
	private String dungluong = "";
	private String soluong = "";
	private String trangthai = "";
	private Date dateimport = null;
	
    public TuyenKenhImportDTO() {

    }
    
	public Integer getStt() {
		return stt;
	}

	public void setStt(Integer stt) {
		this.stt = stt;
	}

	public String getMadiemdau() {
		return madiemdau;
	}

	public void setMadiemdau(String madiemdau) {
		this.madiemdau = madiemdau;
	}

	public String getMadiemcuoi() {
		return madiemcuoi;
	}

	public void setMadiemcuoi(String madiemcuoi) {
		this.madiemcuoi = madiemcuoi;
	}

	public String getGiaotiep_ma() {
		return giaotiep_ma;
	}

	public void setGiaotiep_ma(String giaotiep_ma) {
		this.giaotiep_ma = giaotiep_ma;
	}

	public String getDuan_ma() {
		return duan_ma;
	}

	public void setDuan_ma(String duan_ma) {
		this.duan_ma = duan_ma;
	}

	public String getPhongban_ma() {
		return phongban_ma;
	}

	public void setPhongban_ma(String phongban_ma) {
		this.phongban_ma = phongban_ma;
	}
	
	public String getDoitac_ma() {
		return doitac_ma;
	}

	public void setDoitac_ma(String doitac_ma) {
		this.doitac_ma = doitac_ma;
	}

	public String getTrangthai() {
		return trangthai;
	}

	public void setTrangthai(String trangthai) {
		this.trangthai = trangthai;
	}

	public String getDungluong() {
		return dungluong;
	}

	public void setDungluong(String dungluong) {
		this.dungluong = dungluong;
	}

	public String getSoluong() {
		return soluong;
	}

	public void setSoluong(String soluong) {
		this.soluong = soluong;
	}

	public Date getDateimport() {
		return dateimport;
	}

	public void setDateimport(Date dateimport) {
		this.dateimport = dateimport;
	}
	
}