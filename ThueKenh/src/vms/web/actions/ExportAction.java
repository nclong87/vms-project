package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import vms.db.dao.CongThucDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.SuCoImportDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dao.TuyenkenhImportDAO;
import vms.db.dto.CongThucDTO;
import vms.db.dto.LoaiGiaoTiepDTO;
import vms.db.dto.SuCoImportDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class ExportAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	
	private InputStream inputStream;
	private String message;
	private LinkedHashMap<String, Object> jsonData;
	
	private Map<String, String> header;
	private String[] ids;
	private boolean permission = true;

	public ExportAction( DaoFactory factory) {
		daoFactory = factory;
	}
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
	}
	
	public String exportTuyenKenh() {
		header = new LinkedHashMap<String, String>();
		//header.put("", value)
		return Action.SUCCESS;
	}
	
	
	/* Getter and Setter */
	public String getMessage() {
		
		return message;
	}

	public void setMessage(String message) {
	
		this.message = message;
	}
	public InputStream getInputStream() {
		
		return inputStream;
	}

	public void setInputStream(String str) {
	
		try {
			this.inputStream =  new ByteArrayInputStream( str.getBytes("UTF-8") );
		} catch (UnsupportedEncodingException e) {			
			System.out.println("ERROR :" + e.getMessage());
		}
	}
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public Map<String, String> getHeader() {
		return header;
	}
	public void setHeader(Map<String, String> header) {
		this.header = header;
	}
	
}