package vms.db.dto.report;

import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class rptGiamTruMLL {
	public static String toXML(ResultSet rs) throws SQLException {
		StringBuffer buffer = new StringBuffer(512);
		buffer.append(VMSUtil.xml("id", rs.getString("ID")));
		buffer.append(VMSUtil.xml("madiemdau", rs.getString("MADIEMDAU")));
		buffer.append(VMSUtil.xml("madiemcuoi", rs.getString("MADIEMCUOI")));
		buffer.append(VMSUtil.xml("loaigiaotiep", rs.getString("LOAIGIAOTIEP")));
		buffer.append(VMSUtil.xml("soluong", rs.getString("SOLUONG")));
		Date dateFrom = new Date(rs.getLong("THOIDIEMBATDAU"));
		Date dateEnd = new Date(rs.getLong("THOIDIEMKETTHUC"));
		buffer.append(VMSUtil.xml("ngaybatdau", DateUtils.formatDate(dateFrom,DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("ngayketthuc", DateUtils.formatDate(dateEnd,DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("thoigianbatdau", DateUtils.formatDate(dateFrom,DateUtils.SDF_HHMMSS)));
		buffer.append(VMSUtil.xml("thoigianketthuc", DateUtils.formatDate(dateEnd,DateUtils.SDF_HHMMSS)));
		buffer.append(VMSUtil.xml("thoigianmll", rs.getString("THOIGIANMLL")));
		buffer.append(VMSUtil.xml("nguyennhan", rs.getString("NGUYENNHAN")));
		buffer.append(VMSUtil.xml("hopdong", rs.getString("SOHOPDONG")+" / "+rs.getString("TENPHULUC")));
		buffer.append(VMSUtil.xml("cuocthang", rs.getString("GIATRITRUOCTHUE")));
		buffer.append(VMSUtil.xml("giamtrumll", rs.getString("GIAMTRUMLL")));
		return buffer.toString();
	}
}
