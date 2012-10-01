package vms.db.dto;

import java.util.Date;




/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class SuCoImportDTO {

	private Integer stt = 0;
	private String madiemdau = "";
	private String madiemcuoi = "";
	private String magiaotiep = "";
	private String thoidiembatdau = "";
	private String thoidiemketthuc = "";
	private String nguyennhan = "";
	private String phuonganxuly = "";
	private String id = "";
	private String tuyenkenh_id = "";
	private String phuluc_id="";
	private String thoigianmll="";
	private String giamtrumll="";
	
    public String getPhuluc_id() {
		return phuluc_id;
	}

	public void setPhuluc_id(String phuluc_id) {
		this.phuluc_id = phuluc_id;
	}

	public String getThoigianmll() {
		return thoigianmll;
	}

	public void setThoigianmll(String thoigianmll) {
		this.thoigianmll = thoigianmll;
	}

	public String getGiamtrumll() {
		return giamtrumll;
	}

	public void setGiamtrumll(String giamtrumll) {
		this.giamtrumll = giamtrumll;
	}

	public SuCoImportDTO() {

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

	public String getMagiaotiep() {
		return magiaotiep;
	}

	public void setMagiaotiep(String magiaotiep) {
		this.magiaotiep = magiaotiep;
	}

	public String getThoidiembatdau() {
		return thoidiembatdau;
	}

	public void setThoidiembatdau(String thoidiembatdau) {
		this.thoidiembatdau = thoidiembatdau;
	}

	public String getThoidiemketthuc() {
		return thoidiemketthuc;
	}

	public void setThoidiemketthuc(String thoidiemketthuc) {
		this.thoidiemketthuc = thoidiemketthuc;
	}

	public String getNguyennhan() {
		return nguyennhan;
	}

	public void setNguyennhan(String nguyennhan) {
		this.nguyennhan = nguyennhan;
	}

	public String getPhuonganxuly() {
		return phuonganxuly;
	}

	public void setPhuonganxuly(String phuonganxuly) {
		this.phuonganxuly = phuonganxuly;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTuyenkenh_id() {
		return tuyenkenh_id;
	}

	public void setTuyenkenh_id(String tuyenkenh_id) {
		this.tuyenkenh_id = tuyenkenh_id;
	}
	
}