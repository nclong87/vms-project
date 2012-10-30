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
	private Map<String,Object> json;
	private ChiTietPhuLucDTO chiTietPhuLucDTO;
	
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
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			CongThucDAO congThucDAO = new CongThucDAO(daoFactory);
			List<Map<String,Object>> list = congThucDAO.findAll();
			Map<String,String> mapCongThuc = new LinkedHashMap<String, String>();
			for(int i=0;i<list.size();i++) {
				mapCongThuc.put(list.get(i).get("id").toString(), list.get(i).get("chuoicongthuc").toString());
			}
			System.out.println("chiTietPhuLucTuyenKenhDTOs.length = " + chiTietPhuLucTuyenKenhDTOs.size());
			Map<String,Object> result = chiTietPhuLucDAO.saveChiTietPhuLucTuyenKenh(chiTietPhuLucTuyenKenhDTOs, mapCongThuc);
			jsonData.put("status", "OK");
			jsonData.put("data", result);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("status", "ERROR");
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String form() {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		json = new LinkedHashMap<String, Object>();
		json.put("cuocDauNoi", request.getParameter("cuocDauNoi"));
		json.put("giaTriTruocThue", request.getParameter("giaTriTruocThue"));
		json.put("giaTriSauThue", request.getParameter("giaTriSauThue"));
		json.put("soLuongKenh", request.getParameter("soLuongKenh"));
		return Action.SUCCESS;
	}
	
	public String doSaveChiTietPhuLuc() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(chiTietPhuLucDTO == null) throw new Exception("ERROR");
			if(chiTietPhuLucDAO.findByKey(chiTietPhuLucDTO.getTenchitietphuluc()) != null) {
				throw new Exception("DUPLICATE");
			}
			chiTietPhuLucDTO.setUsercreate(account.get("username").toString());
			chiTietPhuLucDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			chiTietPhuLucDAO.saveChiTietPhuLuc(chiTietPhuLucDTO);
			jsonData.put("status", "OK");
			jsonData.put("data", "");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("status", "ERROR");
			jsonData.put("data", e.getMessage());
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
	
	public Map<String, Object> getJson() {
		return json;
	}
	public void setJson(Map<String, Object> json) {
		this.json = json;
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
	public ChiTietPhuLucDTO getChiTietPhuLucDTO() {
		return chiTietPhuLucDTO;
	}
	public void setChiTietPhuLucDTO(ChiTietPhuLucDTO chiTietPhuLucDTO) {
		this.chiTietPhuLucDTO = chiTietPhuLucDTO;
	}
	
	
	
	
	
}