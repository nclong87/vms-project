package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dto.DoiTacDTO;
import vms.utils.Constances;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class DanhMucDoiTacAction implements Preparable {

	private LinkedHashMap<String, Object> jsonData;

	private DaoFactory factory;

	private boolean isDeleted;

	private HttpServletRequest request;

	private DoiTacDAO DoiTacDAO;

	private DoiTacDTO opEdit;

	public DoiTacDTO getOpEdit() {
		return opEdit;
	}

	public void setOpEdit(DoiTacDTO opEdit) {
		this.opEdit = opEdit;
	}

	private String flag = "0";

	private HttpSession session;

	private Map<String,Object> account;

	private InputStream inputStream;
	
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

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		this.session = request.getSession();
		this.account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
	}

	public DanhMucDoiTacAction(DaoFactory factory) {
		this.factory = factory;
		this.DoiTacDAO = new DoiTacDAO(factory);
		this.jsonData = new LinkedHashMap<String, Object>();
	}

	public String index() {
		// DoiTacDAO dao = new DoiTacDAO(factory);
		// xoa
		// dao.delete(new String[] { "1" });
		/*
		 * List<DoiTacDTO> lst = dao.get(); for (int i = 0; i < lst.size();
		 * i++) { System.out.println(lst.get(i).getName()); }
		 */
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		return Action.SUCCESS;
	}

	public String delete() {
		System.out.println("delete");
		this.request = ServletActionContext.getRequest();
		String strIds = request.getParameter("ids");
		System.out.println(strIds);
		jsonData = new LinkedHashMap<String, Object>();
		isDeleted = this.DoiTacDAO.delete(strIds.split(","));
		jsonData.put("isDeleted", isDeleted);

		return Action.SUCCESS;
	}

	public String edit() throws SQLException {
		String id = "";

		// edit page post
		if (this.opEdit != null) {
			// edit
			System.out.println("edit mode id=" + this.opEdit.getId());
			if (!this.opEdit.getId().isEmpty()) {
				if (this.DoiTacDAO.update(this.opEdit.getId(), this.opEdit)) {
					this.flag = "1";// updated
					
				} else
					this.flag = "-1";// failure
			} else {
				// new
				this.DoiTacDAO.insert(this.opEdit);
			}
			System.out.println("result=" + flag);

		} else {
			// get page
			try {
				this.request = ServletActionContext.getRequest();
				id =request.getParameter("id");
				System.out.println("load edit id=" + id);
				this.opEdit =  this.DoiTacDAO.get(id);
				System.out.println("finish load edit");
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}

		return Action.SUCCESS;
	}
	
	public String dosave() throws SQLException {
		//String id = "";

		// edit page post
		if (this.opEdit != null) {
			// edit
			System.out.println("edit mode id=" + this.opEdit.getId());
			if (!this.opEdit.getId().isEmpty()) {
				if (this.DoiTacDAO.update(this.opEdit.getId(), this.opEdit)) {
					this.flag = "1";// updated
					setInputStream("OK");
				} else
					this.flag = "-1";// failure
			} else {
				// new
				if(this.DoiTacDAO.insert(this.opEdit))
					setInputStream("OK");
			}
			System.out.println("result=" + flag);

		} 

		return Action.SUCCESS;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String ajLoaddoitac() throws JSONException {
		this.request = ServletActionContext.getRequest();
		// DoiTacDAO DoiTacDAO = new DoiTacDAO(factory);
		
		
		List<DoiTacDTO> lstkhuvuc = null;
		String strSearch=this.request.getParameter("sSearch");
		if(strSearch.isEmpty() == false) {
			JSONArray arrayJson = (JSONArray) new JSONObject(strSearch).get("array");
			
				String name = arrayJson.getJSONObject(0).getString("value");
				lstkhuvuc = DoiTacDAO.search(name);
				System.out.println("strSearch="+strSearch);
			
		}else
			lstkhuvuc = DoiTacDAO.get();
		
		jsonData = new LinkedHashMap<String, Object>();
		List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
		for (int i = 0; i < lstkhuvuc.size(); i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			DoiTacDTO pb = lstkhuvuc.get(i);
			map.putAll(pb.getMap());
			items.add(map);
		}
		// jsonData.put("sEcho",
		// Integer.parseInt(request.getParameter("sEcho")));
		jsonData.put("iTotalRecords", lstkhuvuc.size());
		jsonData.put("iTotalDisplayRecords", lstkhuvuc.size());
		jsonData.put("aaData", items);

		return Action.SUCCESS;
	}

	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}

	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}

	public DaoFactory getFactory() {
		return factory;
	}

	public void setFactory(DaoFactory factory) {
		this.factory = factory;
	}
}
