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

import vms.db.dao.BanGiaoDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.TuyenKenhDeXuatDAO;
import vms.db.dto.BanGiaoDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class BanGiaoAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private BanGiaoDTO banGiaoDTO;
	
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private String id;
	private String[] ids;
	private String[] bangiao_ids;
	private Map<String,Object> detail;
	
	private BanGiaoDAO banGiaoDAO;
	public BanGiaoAction( DaoFactory factory) {
		daoFactory = factory;
		banGiaoDAO = new BanGiaoDAO(factory);
	}
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
	
	public String load() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch="+sSearch);
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
			List<BanGiaoDTO> list = banGiaoDAO.search(conditions.get("tenvanban"),iDisplayStart, iDisplayLength + 1);
			int iTotalRecords = list.size();
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<list.size() && i<iDisplayLength;i++) {
				Map<String, String> map = list.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				items.add(map);
			}
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart + iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart + iTotalRecords);
			jsonData.put("aaData", items);
			return Action.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String form() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				banGiaoDTO = banGiaoDAO.findById(id);
				Map<String,String> map = banGiaoDTO.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	public String doSave() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			banGiaoDTO.setUsercreate(account.get("username").toString());
			banGiaoDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			id = banGiaoDAO.save(banGiaoDTO);
			if(id == null) throw new Exception(Constances.MSG_ERROR);
			System.out.println("dexuat_ids.length" + bangiao_ids.length);
			if(bangiao_ids!= null && bangiao_ids.length > 0) {
				TuyenKenhDeXuatDAO tuyenKenhDeXuatDAO = new TuyenKenhDeXuatDAO(daoFactory);
				tuyenKenhDeXuatDAO.updateBangiaoByIds(bangiao_ids, id);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
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
				banGiaoDAO.deleteByIds(ids);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		if(id == null) return Action.ERROR;
		detail = banGiaoDAO.getDetail(id);
		if(detail == null) return Action.ERROR;
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
	public BanGiaoDTO getBanGiaoDTO() {
		return banGiaoDTO;
	}
	public void setBanGiaoDTO(BanGiaoDTO banGiaoDTO) {
		this.banGiaoDTO = banGiaoDTO;
	}
	public String getForm_data() {
		return form_data;
	}
	public void setForm_data(String form_data) {
		this.form_data = form_data;
	}
	public String[] getBangiao_ids() {
		return bangiao_ids;
	}
	public void setBangiao_ids(String[] bangiao_ids) {
		this.bangiao_ids = bangiao_ids;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
	}
	
}