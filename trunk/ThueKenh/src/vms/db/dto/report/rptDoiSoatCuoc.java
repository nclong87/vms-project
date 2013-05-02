package vms.db.dto.report;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.xml.sax.SAXException;

import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;

public class rptDoiSoatCuoc {
	public static String toXML(ResultSet rs) throws SQLException {
		StringBuffer buffer = new StringBuffer(512);
		buffer.append(VMSUtil.xml("tenphuluc", rs.getString("TENPHULUC")));
		buffer.append(VMSUtil.xml("giatriphuluc", rs.getString("GIATRITRUOCTHUE")));
		buffer.append(VMSUtil.xml("tungay", DateUtils.formatDate(rs.getDate("TUNGAY"), DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("denngay", DateUtils.formatDate(rs.getDate("DENNGAY"), DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("ngaycohieuluc", DateUtils.formatDate(rs.getDate("NGAYHIEULUC"), DateUtils.SDF_DDMMYYYY)));
		buffer.append(VMSUtil.xml("sothang", rs.getString("SOTHANG")));
		buffer.append(VMSUtil.xml("songay", rs.getString("SONGAY")));
		buffer.append(VMSUtil.xml("soluongkenh", rs.getString("SOLUONGKENH")));
		buffer.append(VMSUtil.xml("thanhtien", rs.getString("THANHTIEN")));
		buffer.append(VMSUtil.xml("giamtrumll", ""));
		buffer.append(VMSUtil.xml("cuocdaunoi", rs.getString("DAUNOIHOAMANG")));
		buffer.append(VMSUtil.xml("dathanhtoan", rs.getString("DATHANHTOAN")));
		buffer.append(VMSUtil.xml("conthanhtoan", rs.getString("CONTHANHTOAN")));
		String ghichu = "";
		int flag = 0;
		List<Map<String,String>> lst = null;
		try {
			lst = XMLUtil.parseXMLString(rs.getString("PHULUCBITHAYTHE"));
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(lst.isEmpty() == false) {
			List<String> tmpList = new ArrayList<String>();
			for(int i = 0;i<lst.size();i++) {
				Map<String, String> map = lst.get(i);
				tmpList.add(map.get("tenphuluc"));
			}
			ghichu = "Thay thế " + StringUtils.join(tmpList, ",");
			flag = 1;
		}
		buffer.append(VMSUtil.xml("ghichu", ghichu));
		buffer.append(VMSUtil.xml("plthaythe", String.valueOf(flag)));
		return buffer.toString();
	}
}
