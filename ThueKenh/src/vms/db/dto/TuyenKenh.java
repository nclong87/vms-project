package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class TuyenKenh {

	private String id = "";
	private String madiemdau = "";
	private String madiemcuoi = "";
	private String giaotiep_id = "";
	private String duan_id = "";
	private String phongban_id = "";
	private String doitac_id = "";
	private Double dungluong;
	private Integer soluong = 0;
	private Integer trangthai = 0;
	private String usercreate = "";
	private String timecreate = "";
	private Integer deleted = 0;

    public TuyenKenh() {

    }
    
	

	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
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



	public String getGiaotiep_id() {
		return giaotiep_id;
	}



	public void setGiaotiep_id(String giaotiep_id) {
		this.giaotiep_id = giaotiep_id;
	}



	public String getDuan_id() {
		return duan_id;
	}



	public void setDuan_id(String duan_id) {
		this.duan_id = duan_id;
	}



	public String getPhongban_id() {
		return phongban_id;
	}



	public void setPhongban_id(String phongban_id) {
		this.phongban_id = phongban_id;
	}
	
	public String getDoitac_id() {
		return doitac_id;
	}



	public void setDoitac_id(String doitac_id) {
		this.doitac_id = doitac_id;
	}

	public Integer getSoluong() {
		return soluong;
	}

	public void setSoluong(Integer soluong) {
		this.soluong = soluong;
	}

	public Integer getTrangthai() {
		return trangthai;
	}

	public void setTrangthai(Integer trangthai) {
		this.trangthai = trangthai;
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
	public Double getDungluong() {
		return dungluong;
	}
	public void setDungluong(Double dungluong) {
		this.dungluong = dungluong;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("madiemdau", this.madiemdau);
		map.put("madiemcuoi", this.madiemcuoi);
		map.put("giaotiep_id", this.giaotiep_id);
		map.put("duan_id", this.duan_id);
		map.put("phongban_id", this.phongban_id);
		map.put("doitac_id", this.doitac_id);
		map.put("dungluong", String.valueOf(this.dungluong));
		map.put("soluong", String.valueOf(this.soluong));
		map.put("trangthai", String.valueOf(this.trangthai));
		map.put("usercreate", this.usercreate);
		map.put("timecreate", this.timecreate);
		map.put("deleted", String.valueOf(this.deleted));
		return map;
	}
	
	public static TuyenKenh mapObject(ResultSet rs) throws SQLException {
		TuyenKenh dto = new TuyenKenh();
		dto.setId(rs.getString("ID"));
		dto.setMadiemdau(rs.getString("MADIEMDAU"));
		dto.setMadiemcuoi(rs.getString("MADIEMCUOI"));
		dto.setGiaotiep_id(rs.getString("GIAOTIEP_ID"));
		dto.setDuan_id(rs.getString("DUAN_ID"));
		dto.setPhongban_id(rs.getString("PHONGBAN_ID"));
		dto.setDoitac_id(rs.getString("DOITAC_ID"));
		dto.setDungluong(rs.getDouble("DUNGLUONG"));
		dto.setSoluong(rs.getInt("SOLUONG"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
	

}