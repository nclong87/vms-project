package vms.db.dto;

import java.util.Date;




/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class TuyenKenhDeXuatImportDTO {

	private Integer stt = 0;
	private String madiemdau = "";
	private String madiemcuoi = "";
	private String giaotiep_ma = "";
	private String dungluong = "";
	private String soluongdexuat = "";
	private String duan_ma = "";
	private String donvinhankenh="";
	private String doitac_ma = "";
	private String ngayhenbangiao = "";
	private String ngaydenghibangiao = "";
	private String loaikenh = "";
	private String thongtinlienhe = "";
	private Date dateimport = null;
	private String duplicate="";
	private String tuyenkenh_id="";
	private Integer soluong_old=0;
    public TuyenKenhDeXuatImportDTO() {

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

	public String getDungluong() {
		return dungluong;
	}

	public void setDungluong(String dungluong) {
		this.dungluong = dungluong;
	}

	public String getSoluongdexuat() {
		return soluongdexuat;
	}

	public void setSoluongdexuat(String soluongdexuat) {
		this.soluongdexuat = soluongdexuat;
	}

	public String getDuan_ma() {
		return duan_ma;
	}

	public void setDuan_ma(String duan_ma) {
		this.duan_ma = duan_ma;
	}

	public String getDonvinhankenh() {
		return donvinhankenh;
	}

	public void setDonvinhankenh(String donvinhankenh) {
		this.donvinhankenh = donvinhankenh;
	}

	public String getDoitac_ma() {
		return doitac_ma;
	}

	public void setDoitac_ma(String doitac_ma) {
		this.doitac_ma = doitac_ma;
	}

	public String getNgayhenbangiao() {
		return ngayhenbangiao;
	}

	public void setNgayhenbangiao(String ngayhenbangiao) {
		this.ngayhenbangiao = ngayhenbangiao;
	}

	public String getNgaydenghibangiao() {
		return ngaydenghibangiao;
	}

	public void setNgaydenghibangiao(String ngaydenghibangiao) {
		this.ngaydenghibangiao = ngaydenghibangiao;
	}

	public String getLoaikenh() {
		return loaikenh;
	}

	public void setLoaikenh(String loaikenh) {
		this.loaikenh = loaikenh;
	}

	public String getThongtinlienhe() {
		return thongtinlienhe;
	}

	public void setThongtinlienhe(String thongtinlienhe) {
		this.thongtinlienhe = thongtinlienhe;
	}

	public Date getDateimport() {
		return dateimport;
	}

	public void setDateimport(Date dateimport) {
		this.dateimport = dateimport;
	}

	public String getDuplicate() {
		return duplicate;
	}

	public void setDuplicate(String duplicate) {
		this.duplicate = duplicate;
	}

	public String getTuyenkenh_id() {
		return tuyenkenh_id;
	}

	public void setTuyenkenh_id(String tuyenkenh_id) {
		this.tuyenkenh_id = tuyenkenh_id;
	}

	public Integer getSoluong_old() {
		return soluong_old;
	}

	public void setSoluong_old(Integer soluong_old) {
		this.soluong_old = soluong_old;
	}
    
}