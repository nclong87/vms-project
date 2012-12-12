package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
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
import vms.db.dao.ChiTietPhuLucTuyenKenhDAO;
import vms.db.dao.CongThucDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dto.ChiTietPhuLucDTO;
import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
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
	private boolean permission = true;
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
		if(permission == false) return "error_permission";
		return Action.SUCCESS;
	}
	
	public String load() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			Map<String, String> conditions = new LinkedHashMap<String, String>();
			if(sSearch.isEmpty() == false) {
				JSONArray arrayJson = (JSONArray) new JSONObject(sSearch).get("array");
				for(int i=0;i<arrayJson.length();i++) {
					String name = arrayJson.getJSONObject(i).getString("name");
					String value = arrayJson.getJSONObject(i).getString("value");
					if(value.isEmpty()==false) {
						conditions.put(name, value);
					}
				}
			}
			List<Map<String,Object>> items = chiTietPhuLucDAO.search(iDisplayStart, 
					iDisplayLength + 1, conditions);
			int iTotalRecords = items.size();
			if(iTotalRecords > iDisplayLength) {
				items.remove(iTotalRecords - 1);
			}
			jsonData = new LinkedHashMap<String, Object>();
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart + iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart + iTotalRecords);
			jsonData.put("aaData", items);
			return Action.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
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
		if(permission == false) return "error_permission";
		json = new LinkedHashMap<String, Object>();
		json.put("cuocDauNoi", request.getParameter("cuocDauNoi"));
		json.put("giaTriTruocThue", request.getParameter("giaTriTruocThue"));
		json.put("giaTriSauThue", request.getParameter("giaTriSauThue"));
		json.put("soLuongKenh", request.getParameter("soLuongKenh"));

		id=request.getParameter("id");
		json.put("id", id);
		
		String tenchitietphuluc="";
		if(id!=null)
		{
			ChiTietPhuLucDTO ctplDto=chiTietPhuLucDAO.findById(id);
			if(ctplDto!=null)
				tenchitietphuluc=ctplDto.getTenchitietphuluc();
		}
		json.put("tenchitietphuluc", tenchitietphuluc);
		return Action.SUCCESS;
	}
	
	//load form
	public String index() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			form_data = "";
			System.out.println("id:"+id);
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				ChiTietPhuLucDAO chitietPLDao = new ChiTietPhuLucDAO(daoFactory);
				List<Map<String,Object>> result = chitietPLDao.FindChiTietPhuLucById(0, 1000, id);
				form_data = JSONValue.toJSONString(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
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
			if(chiTietPhuLucDTO.getId()==null && chiTietPhuLucDAO.findByKey(chiTietPhuLucDTO.getTenchitietphuluc()) != null) {
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
	
	public String delete() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				ChiTietPhuLucDAO chitietplDao = new ChiTietPhuLucDAO(daoFactory);
				chitietplDao.deleteByIds(ids);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	/*
	 * Tim kiem chi tiet phu luc (gia tri phu luc) dang popup
	 */
	public String popupSearch() {
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