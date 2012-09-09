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
	private String diemdau_id = "";
	private String diemcuoi_id = "";
	private String giaotiep_id = "";
	private String duan_id = "";
	private String phongban_id = "";
	private String khuvuc_id = "";
	private Integer dungluong = 0;
	private Integer soluong = 0;
	private String ngaydenghibangiao = "";
	private String ngayhenbangiao = "";
	private String thongtinlienhe = "";
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



	public String getDiemdau_id() {
		return diemdau_id;
	}



	public void setDiemdau_id(String diemdau_id) {
		this.diemdau_id = diemdau_id;
	}



	public String getDiemcuoi_id() {
		return diemcuoi_id;
	}



	public void setDiemcuoi_id(String diemcuoi_id) {
		this.diemcuoi_id = diemcuoi_id;
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



	public String getKhuvuc_id() {
		return khuvuc_id;
	}



	public void setKhuvuc_id(String khuvuc_id) {
		this.khuvuc_id = khuvuc_id;
	}



	public Integer getDungluong() {
		return dungluong;
	}

	public void setDungluong(Integer dungluong) {
		this.dungluong = dungluong;
	}

	public Integer getSoluong() {
		return soluong;
	}

	public void setSoluong(Integer soluong) {
		this.soluong = soluong;
	}

	public String getNgaydenghibangiao() {
		return ngaydenghibangiao;
	}

	public void setNgaydenghibangiao(String ngaydenghibangiao) {
		this.ngaydenghibangiao = ngaydenghibangiao;
	}

	public String getNgayhenbangiao() {
		return ngayhenbangiao;
	}

	public void setNgayhenbangiao(String ngayhenbangiao) {
		this.ngayhenbangiao = ngayhenbangiao;
	}

	public String getThongtinlienhe() {
		return thongtinlienhe;
	}

	public void setThongtinlienhe(String thongtinlienhe) {
		this.thongtinlienhe = thongtinlienhe;
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

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("ID", this.id);
		map.put("DIEMDAU_ID", this.diemdau_id);
		map.put("DIEMCUOI_ID", this.diemcuoi_id);
		map.put("GIAOTIEP_ID", this.giaotiep_id);
		map.put("DUAN_ID", this.duan_id.toString());
		map.put("PHONGBAN_ID", this.phongban_id);
		map.put("KHUVUC_ID", this.khuvuc_id);
		map.put("DUNGLUONG", this.dungluong.toString());
		map.put("SOLUONG", this.soluong.toString());
		map.put("NGAYDENGHIBANGIAO", this.ngaydenghibangiao);
		map.put("NGAYHENBANGIAO", this.ngayhenbangiao);
		map.put("THONGTINLIENHE", this.thongtinlienhe);
		map.put("TRANGTHAI", this.trangthai.toString());
		map.put("USERCREATE", this.usercreate);
		map.put("TIMECREATE", this.timecreate);
		map.put("DELETED", this.deleted.toString());
		return map;
	}
	
	public static TuyenKenh mapObject(ResultSet rs) throws SQLException {
		TuyenKenh dto = new TuyenKenh();
		dto.setId(rs.getString("ID"));
		dto.setDiemdau_id(rs.getString("DIEMDAU_ID"));
		dto.setDiemcuoi_id(rs.getString("DIEMCUOI_ID"));
		dto.setGiaotiep_id(rs.getString("GIAOTIEP_ID"));
		dto.setDuan_id(rs.getString("DUAN_ID"));
		dto.setPhongban_id(rs.getString("PHONGBAN_ID"));
		dto.setKhuvuc_id(rs.getString("KHUVUC_ID"));
		dto.setDungluong(rs.getInt("DUNGLUONG"));
		dto.setSoluong(rs.getInt("SOLUONG"));
		dto.setNgaydenghibangiao(rs.getString("NGAYDENGHIBANGIAO"));
		dto.setNgayhenbangiao(rs.getString("NGAYHENBANGIAO"));
		dto.setThongtinlienhe(rs.getString("THONGTINLIENHE"));
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
		dto.setUsercreate(rs.getString("USERCREATE"));
		dto.setTimecreate(rs.getString("TIMECREATE"));
		dto.setDeleted(rs.getInt("DELETED"));
        return dto;
	}
	

}