package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;

import vms.db.dao.ChiTietPhuLucDAO;
import vms.db.dao.CongThucDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.DeXuatDao;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.TuyenKenhDeXuatDAO;
import vms.db.dto.ChiTietPhuLucDTO;
import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.db.dto.DeXuatDTO;
import vms.db.dto.DoiTacDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FIND_DEXUAT;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class ChiTietPhuLucAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private List<ChiTietPhuLucTuyenKenhDTO> chiTietPhuLucTuyenKenhDTOs;
	
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	private String congThucs;
	
	private String id;
	private String[] ids;
	private Map<String,Object> detail;
	
	private ChiTietPhuLucDAO chiTietPhuLucDAO;
	public ChiTietPhuLucAction( DaoFactory factory) {
		daoFactory = factory;
		chiTietPhuLucDAO = new ChiTietPhuLucDAO(factory);
	}
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		return Action.SUCCESS;
	}
	
	
	public String doSave() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			CongThucDAO congThucDAO = new CongThucDAO(daoFactory);
			List<Map<String,Object>> list = congThucDAO.findAll();
			Map<String,String> mapCongThuc = new LinkedHashMap<String, String>();
			for(int i=0;i<list.size();i++) {
				mapCongThuc.put(list.get(i).get("id").toString(), list.get(i).get("chuoicongthuc").toString());
			}
			System.out.println("chiTietPhuLucTuyenKenhDTOs.length = " + chiTietPhuLucTuyenKenhDTOs.size());
			chiTietPhuLucDAO.saveChiTietPhuLucTuyenKenh(chiTietPhuLucTuyenKenhDTOs, mapCongThuc);
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	
	/* Getter and Setter */
	
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public String getForm_data() {
		return form_data;
	}
	public void setForm_data(String form_data) {
		this.form_data = form_data;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
	}
	public List<ChiTietPhuLucTuyenKenhDTO> getChiTietPhuLucTuyenKenhDTOs() {
		return chiTietPhuLucTuyenKenhDTOs;
	}
	public void setChiTietPhuLucTuyenKenhDTOs(
			List<ChiTietPhuLucTuyenKenhDTO> chiTietPhuLucTuyenKenhDTOs) {
		this.chiTietPhuLucTuyenKenhDTOs = chiTietPhuLucTuyenKenhDTOs;
	}
	public String getCongThucs() {
		return congThucs;
	}
	public void setCongThucs(String congThucs) {
		this.congThucs = congThucs;
	}
	
	
	
	
	
}