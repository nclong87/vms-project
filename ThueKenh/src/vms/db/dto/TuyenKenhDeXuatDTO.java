package vms.db.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import vms.utils.DateUtils;


/**
 * The persistent class for the ACCOUNTS database table.
 * 
 */
public class TuyenKenhDeXuatDTO {

	private String id = "";
	private String dexuat_id = "";
	private String tuyenkenh_id = "";
	private String bangiao_id = "";
	private String ngaydenghibangiao = "";
	private String ngayhenbangiao = "";
	private String thongtinlienhe = "";
	private Integer trangthai = 0;
	private Integer soluong = 0;
	
    public TuyenKenhDeXuatDTO() {

    }
    
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDexuat_id() {
		return dexuat_id;
	}

	public void setDexuat_id(String dexuat_id) {
		this.dexuat_id = dexuat_id;
	}

	public String getTuyenkenh_id() {
		return tuyenkenh_id;
	}

	public void setTuyenkenh_id(String tuyenkenh_id) {
		this.tuyenkenh_id = tuyenkenh_id;
	}

	public String getBangiao_id() {
		return bangiao_id;
	}

	public void setBangiao_id(String bangiao_id) {
		this.bangiao_id = bangiao_id;
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

	public Integer getSoluong() {
		return soluong;
	}

	public void setSoluong(Integer soluong) {
		this.soluong = soluong;
	}

	public Map<String,String> getMap() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("id", this.id);
		map.put("dexuat_id", this.dexuat_id);
		map.put("tuyenkenh_id", this.tuyenkenh_id);
		map.put("bangiao_id", this.bangiao_id);
		map.put("soluong", String.valueOf(this.soluong));
		map.put("ngaydenghibangiao", this.ngaydenghibangiao);
		map.put("ngayhenbangiao", this.ngayhenbangiao);
		map.put("thongtinlienhe", this.thongtinlienhe);
		map.put("trangthai", String.valueOf(this.trangthai));
		return map;
	}
	
	public static TuyenKenhDeXuatDTO mapObject(ResultSet rs) throws SQLException {
		TuyenKenhDeXuatDTO dto = new TuyenKenhDeXuatDTO();
		dto.setId(rs.getString("ID"));
		dto.setDexuat_id(rs.getString("DEXUAT_ID"));
		dto.setTuyenkenh_id(rs.getString("TUYENKENH_ID"));
		dto.setBangiao_id(rs.getString("BANGIAO_ID"));
		dto.setSoluong(rs.getInt("SOLUONG"));
		dto.setNgaydenghibangiao(DateUtils.formatDate(rs.getDate("NGAYDENGHIBANGIAO"), DateUtils.SDF_DDMMYYYY));
		dto.setNgayhenbangiao(DateUtils.formatDate(rs.getDate("NGAYHENBANGIAO"), DateUtils.SDF_DDMMYYYY));
		String thongtinlienhe=rs.getString("THONGTINLIENHE");
		System.out.println("thongtinlienhe:"+thongtinlienhe);
		if(thongtinlienhe=="null")
			thongtinlienhe="";
		dto.setThongtinlienhe(thongtinlienhe);
		dto.setTrangthai(rs.getInt("TRANGTHAI"));
        return dto;
	}
	

}