package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;


import vms.db.dao.AccountDao;
import vms.db.dao.DaoFactory;
import vms.db.dao.KhuVucDao;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhongBanDao;
import vms.db.dao.VmsgroupDao;
import vms.db.dto.Account;
import vms.db.dto.KhuVuc;
import vms.db.dto.LoaiGiaoTiep;
import vms.db.dto.PhongBan;
import vms.db.dto.TuyenKenh;
import vms.db.dto.Vmsgroup;
import vms.utils.Constances;
import vms.utils.VMSUtil;
import vms.web.models.AccountExt;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class TuyenkenhAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Account account;
	private TuyenKenh tuyenKenh;
	
	private InputStream inputStream;
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<LoaiGiaoTiep> loaiGiaoTieps;
	private String id;
	private String[] ids;
	private Account user;
	public TuyenkenhAction( DaoFactory factory) {
		daoFactory = factory;
	}
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Account) session.getAttribute(Constances.SESS_USERLOGIN);
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
		loaiGiaoTieps = loaiGiaoTiepDao.getAll();
		return Action.SUCCESS;
	}
	
	public String ajLoadTuyenkenh() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch="+sSearch);
			String username = "";
			String phongban_id = "";
			String khuvuc_id = "";
			String active = "";
			if(sSearch.isEmpty() == false) {
				JSONArray arrayJson = (JSONArray) new JSONObject(sSearch).get("array");
				for(int i=0;i<arrayJson.length();i++) {
					String name = arrayJson.getJSONObject(i).getString("name");
					String value = arrayJson.getJSONObject(i).getString("value");
					if(value.isEmpty()==false) {
						if(name.equals("username"))
							username = value;
						if(name.equals("phongban_id"))
							phongban_id = value;
						if(name.equals("khuvuc_id"))
							khuvuc_id = value;
						if(name.equals("active"))
							active = value;
					}
				}
			}
			AccountDao accountDao = new AccountDao(daoFactory);
			List<AccountExt> lstAccount = accountDao.findAccounts(iDisplayStart, iDisplayLength + 1, username, phongban_id, khuvuc_id, active);
			jsonData = new LinkedHashMap<String, Object>();
			List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
			for(int i=0;i<lstAccount.size() && i<iDisplayLength;i++) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				AccountExt account_ext = lstAccount.get(i);
				map.put("stt", i+1);
				map.put("id", account_ext.getId());
				map.put("username", account_ext.getUsername());
				map.put("phongban", account_ext.getTenphongban());
				map.put("khuvuc", account_ext.getTenkhuvuc());
				map.put("active", account_ext.getActive());
				items.add(map);
			}
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", lstAccount.size());
			jsonData.put("iTotalDisplayRecords", lstAccount.size());
			jsonData.put("aaData", items);
			return Action.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			//setInputStream(str)
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
			String flag = request.getParameter("f");
			if(flag != null ) {
				message = new MessageStore();
				message.setType(1);
				message.setMessage(Constances.MSG_SUCCESS);
			}
			LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
			loaiGiaoTieps = loaiGiaoTiepDao.getAll();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				AccountDao accountDao = new AccountDao(daoFactory);
				user = accountDao.findById(id);
				Map<String,String> map = user.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("message", e.getMessage());
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
			AccountDao accountDao = new AccountDao(daoFactory);
			id = String.valueOf(accountDao.save(user));
			if(id == null) throw new Exception(Constances.MSG_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("message", e.getMessage());
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	
	/* Getter and Setter */
	
	public MessageStore getMessage() {
		
		return message;
	}

	public void setMessage(MessageStore message) {
	
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Account getUser() {
		return user;
	}
	public void setUser(Account user) {
		this.user = user;
	}
	public String getForm_data() {
		return form_data;
	}
	public void setForm_data(String form_data) {
		this.form_data = form_data;
	}
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public TuyenKenh getTuyenKenh() {
		return tuyenKenh;
	}
	public void setTuyenKenh(TuyenKenh tuyenKenh) {
		this.tuyenKenh = tuyenKenh;
	}
	public List<LoaiGiaoTiep> getLoaiGiaoTieps() {
		return loaiGiaoTieps;
	}
	public void setLoaiGiaoTieps(List<LoaiGiaoTiep> loaiGiaoTieps) {
		this.loaiGiaoTieps = loaiGiaoTieps;
	}
	
}