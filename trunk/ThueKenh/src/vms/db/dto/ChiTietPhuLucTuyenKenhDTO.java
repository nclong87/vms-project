package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the CHITIETPHULUC database table.
 * 
 */
public class ChiTietPhuLucTuyenKenhDTO {

	private String chitietphuluc_id;
	private String tuyenkenh_id;
	private String congthuc_id;
	private Integer soluong;
	private Long cuoccong;
	private Long cuocdaunoi;
	private Long dongia;
	private Integer giamgia;
	private Long thanhtien;
	
	private String loaigiaotiep;

    public ChiTietPhuLucTuyenKenhDTO() {

    }
    

	public String getChitietphuluc_id() {
		return chitietphuluc_id;
	}


	public void setChitietphuluc_id(String chitietphuluc_id) {
		this.chitietphuluc_id = chitietphuluc_id;
	}


	public String getTuyenkenh_id() {
		return tuyenkenh_id;
	}


	public void setTuyenkenh_id(String tuyenkenh_id) {
		this.tuyenkenh_id = tuyenkenh_id;
	}


	public String getCongthuc_id() {
		return congthuc_id;
	}


	public void setCongthuc_id(String congthuc_id) {
		this.congthuc_id = congthuc_id;
	}


	public Integer getSoluong() {
		return soluong;
	}


	public void setSoluong(Integer soluong) {
		this.soluong = soluong;
	}


	public Long getCuoccong() {
		return cuoccong;
	}


	public void setCuoccong(Long cuoccong) {
		this.cuoccong = cuoccong;
	}


	public Long getCuocdaunoi() {
		return cuocdaunoi;
	}


	public void setCuocdaunoi(Long cuocdaunoi) {
		this.cuocdaunoi = cuocdaunoi;
	}


	public Long getDongia() {
		return dongia;
	}


	public void setDongia(Long dongia) {
		this.dongia = dongia;
	}

	public Integer getGiamgia() {
		return giamgia;
	}

	public void setGiamgia(Integer giamgia) {
		this.giamgia = giamgia;
	}

	public Long getThanhtien() {
		return thanhtien;
	}

	public void setThanhtien(Long thanhtien) {
		this.thanhtien = thanhtien;
	}
	
	public String getLoaigiaotiep() {
		return loaigiaotiep;
	}


	public void setLoaigiaotiep(String loaigiaotiep) {
		this.loaigiaotiep = loaigiaotiep;
	}


	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("chitietphuluc_id", this.chitietphuluc_id);
		map.put("congthuc_id", this.congthuc_id);
		map.put("tuyenkenh_id", this.tuyenkenh_id);
		map.put("cuoccong", String.valueOf(this.cuoccong));
		map.put("cuocdaunoi", String.valueOf(this.cuocdaunoi));
		map.put("dongia", String.valueOf(this.dongia));
		map.put("giamgia", String.valueOf(this.giamgia));
		map.put("soluong", String.valueOf(this.soluong));
		map.put("thanhtien", String.valueOf(this.thanhtien));
		return map;
	}
	
	public static ChiTietPhuLucTuyenKenhDTO mapObject(ResultSet rs) throws SQLException {
		ChiTietPhuLucTuyenKenhDTO dto = new ChiTietPhuLucTuyenKenhDTO();
		dto.setChitietphuluc_id(rs.getString("CHITIETPHULUC_ID"));
		dto.setCongthuc_id(rs.getString("CONGTHUC_ID"));
		dto.setCuoccong(rs.getLong("CUOCCONG"));
		dto.setCuocdaunoi(rs.getLong("CUOCDAUNOI"));
		dto.setDongia(rs.getLong("DONGIA"));
		dto.setGiamgia(rs.getInt("GIAMGIA"));
		dto.setSoluong(rs.getInt("SOLUONG"));
		dto.setThanhtien(rs.getLong("THANHTIEN"));
		dto.setTuyenkenh_id(rs.getString("TUYENKENH_ID"));
        return dto;
	}
	

}