package vms.db.dto.report;

import java.sql.ResultSet;
import java.sql.SQLException;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

public class rptDoiSoatCuoc {
	public static String toXML(ResultSet rs) throws SQLException {
		StringBuffer buffer = new StringBuffer(512);
		buffer.append(VMSUtil.xml("tenphuluc", rs.getString("TENPHULUC")));
		buffer.append(VMSUtil.xml("giatriphuluc", rs.getString("GIATRITRUOCTHUE")));
		buffer.append(VMSUtil.xml("tungay", DateUtils.formatDate(rs.getDate("TUNGAY"), DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("denngay", DateUtils.formatDate(rs.getDate("DENNGAY"), DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("sothang", rs.getString("SOTHANG")));
		buffer.append(VMSUtil.xml("songay", rs.getString("SONGAY")));
		buffer.append(VMSUtil.xml("soluongkenh", rs.getString("SOLUONGKENH")));
		buffer.append(VMSUtil.xml("thanhtien", rs.getString("THANHTIEN")));
		buffer.append(VMSUtil.xml("giamtrumll", ""));
		buffer.append(VMSUtil.xml("cuocdaunoi", rs.getString("DAUNOIHOAMANG")));
		buffer.append(VMSUtil.xml("dathanhtoan", rs.getString("DATHANHTOAN")));
		buffer.append(VMSUtil.xml("conthanhtoan", rs.getString("CONTHANHTOAN")));
		return buffer.toString();
	}
}
