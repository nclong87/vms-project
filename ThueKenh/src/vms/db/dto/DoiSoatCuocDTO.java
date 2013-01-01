package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the CHITIETPHULUC database table.
 * Sau khi tinh gia tri phu luc se luu vao bang nay
 * 
 */
public class DoiSoatCuocDTO {

	private String id;
	private String tendoisoatcuoc;
	private String doitac_id;
	private String tungay;
	private String denngay;
	private Long giamtrumll;
	private Long thanhtien;
	private String usercreate;
	private String timecreate;
	private Integer deleted;
	private String matlienlactu;
	private String matlienlacden;
	private Long tongdaunoihoamang;
	private Long tongdathanhtoan;
	private Long tongconthanhtoan;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTendoisoatcuoc() {
		return tendoisoatcuoc;
	}

	public void setTendoisoatcuoc(String tendoisoatcuoc) {
		this.tendoisoatcuoc = tendoisoatcuoc;
	}

	public String getDoitac_id() {
		return doitac_id;
	}

	public void setDoitac_id(String doitac_id) {
		this.doitac_id = doitac_id;
	}

	public String getTungay() {
		return tungay;
	}

	public void setTungay(String tungay) {
		this.tungay = tungay;
	}

	public String getDenngay() {
		return denngay;
	}

	public void setDenngay(String denngay) {
		this.denngay = denngay;
	}

	public Long getGiamtrumll() {
		return giamtrumll;
	}

	public void setGiamtrumll(Long giamtrumll) {
		this.giamtrumll = giamtrumll;
	}

	public Long getThanhtien() {
		return thanhtien;
	}

	public void setThanhtien(Long thanhtien) {
		this.thanhtien = thanhtien;
	}

	public String getUsercreate() {
		return usercreate;
	}

	public void setUsercreate(String usercreate) {
		this.usercreate = usercreate;
	}

	public String getTimecreate() {
		return timecreate;
	}

	public void setTimecreate(String timecreate) {
		this.timecreate = timecreate;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public String getMatlienlactu() {
		return matlienlactu;
	}

	public void setMatlienlactu(String matlienlactu) {
		this.matlienlactu = matlienlactu;
	}

	public String getMatlienlacden() {
		return matlienlacden;
	}

	public void setMatlienlacden(String matlienlacden) {
		this.matlienlacden = matlienlacden;
	}

	public Long getTongdaunoihoamang() {
		return tongdaunoihoamang;
	}

	public void setTongdaunoihoamang(Long tongdaunoihoamang) {
		this.tongdaunoihoamang = tongdaunoihoamang;
	}

	public Long getTongdathanhtoan() {
		return tongdathanhtoan;
	}

	public void setTongdathanhtoan(Long tongdathanhtoan) {
		this.tongdathanhtoan = tongdathanhtoan;
	}

	public Long getTongconthanhtoan() {
		return tongconthanhtoan;
	}

	public void setTongconthanhtoan(Long tongconthanhtoan) {
		this.tongconthanhtoan = tongconthanhtoan;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("tendoisoatcuoc", this.tendoisoatcuoc);
		map.put("doitac_id", this.doitac_id);
		map.put("tungay", this.tungay);
		map.put("denngay", this.denngay);
		map.put("giamtrumll", String.valueOf(this.giamtrumll));
		map.put("thanhtien", String.valueOf(this.thanhtien));
		map.put("usercreate", this.usercreate);
		map.put("timecreate", this.timecreate);
		map.put("deleted", String.valueOf(this.deleted));
		map.put("matlienlactu", this.matlienlactu);
		map.put("matlienlacden",this.matlienlacden);
		map.put("tongdaunoihoamang",String.valueOf( this.tongdaunoihoamang));
		map.put("tongdathanhtoan",String.valueOf( this.tongdathanhtoan));
		map.put("tongconthanhtoan",String.valueOf( this.tongconthanhtoan));
		return map;
	}
	
	public static DoiSoatCuocDTO mapObject(ResultSet rs) throws SQLException {
		DoiSoatCuocDTO dto = new DoiSoatCuocDTO();
		dto.setId(rs.getString("ID"));
		dto.setTendoisoatcuoc(rs.getString("tendoisoatcuoc"));
		dto.setDoitac_id(rs.getString("doitac_id"));
		dto.setTungay(rs.getString("tungay"));
		dto.setDenngay(rs.getString("denngay"));
		dto.setGiamtrumll(rs.getLong("giamtrumll"));
		dto.setThanhtien(rs.getLong("thanhtien"));
		dto.setDeleted(rs.getInt("DELETED"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setMatlienlactu(rs.getString("matlienlactu"));
		dto.setMatlienlacden(rs.getString("matlienlacden"));
		dto.setTongdathanhtoan(rs.getLong("tongdathanhtoan"));
		dto.setTongconthanhtoan(rs.getLong("tongconthanhtoan"));
        return dto;
	}
	

}