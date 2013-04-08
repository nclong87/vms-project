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


import vms.db.dao.AccountDao;
import vms.db.dao.DaoFactory;
import vms.db.dao.KhuVucDao;
import vms.db.dao.MenuDao;
import vms.db.dao.PhongBanDao;
import vms.db.dao.VmsgroupDao;
import vms.db.dto.Account;
import vms.db.dto.KhuVuc;
import vms.db.dto.Menu;
import vms.db.dto.PhongBanDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class UserAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	
	private InputStream inputStream;
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<PhongBanDTO> phongbans;
	private List<KhuVuc> khuvucs;
	private List<Map<String, Object>> vmsgroups;
	private List<Menu> menus;
	private String id;
	private String[] ids;
	private Account user;
	private boolean permission = true;
	public UserAction( DaoFactory factory) {
		daoFactory = factory;
	}
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.QUAN_LY_USER) == false) {
			permission = false;
		}
	}
	private void log(String message){
		if(account != null) {
			message = "["+DateUtils.getCurrentTime()+"] ["+account.get("username").toString() + "] "+message;
		} else {
			message = "["+DateUtils.getCurrentTime()+"] "+message;
		}
		System.out.println(message);
	}
	public String execute() throws Exception {
		log("UserAction.execute");
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
		phongbans = phongBanDao.getAll();
		KhuVucDao khuVucDao = new KhuVucDao(daoFactory);
		khuvucs = khuVucDao.getAll();
		return Action.SUCCESS;
	}
	
	public String ajLoadAccounts() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			//log("UserAction.ajLoadAccounts");
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
			AccountDao accountDao = new AccountDao(daoFactory);
			List<Map<String, Object>> items = accountDao.findAccounts(iDisplayStart, iDisplayLength + 1, conditions);
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
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String form() {
		try {
			log("UserAction.form");
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			if(permission == false) return "error_permission";
			PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
			phongbans = phongBanDao.getAll();
			KhuVucDao khuVucDao = new KhuVucDao(daoFactory);
			khuvucs = khuVucDao.getAll();
			VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
			vmsgroups = vmsgroupDao.getAll();
			MenuDao menuDao = new MenuDao(daoFactory);
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				AccountDao accountDao = new AccountDao(daoFactory);
				user = accountDao.findById(id);
				Map<String,String> map = user.getMap();
				form_data = JSONValue.toJSONString(map);
				Long idGroup = NumberUtil.parseLong(user.getIdgroup());
				menus = menuDao.getAllByUser(user.getId(), idGroup.toString());
			} else {
				menus = menuDao.getAll();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("message", e.getMessage());
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	public String doSave() {
		log("UserAction.doSave");
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			AccountDao accountDao = new AccountDao(daoFactory);
			id = String.valueOf(accountDao.save(user));
			if(id == null) throw new Exception("ERROR");
			jsonData.put("result", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String lockAccounts() {
		log("UserAction.lockAccounts");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				String active = request.getParameter("active");
				AccountDao accountDao = new AccountDao(daoFactory);
				accountDao.lock(ids, active);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String chonKhuVucPhuTrach() throws Exception {
		log("UserAction.chonKhuVucPhuTrach");
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		KhuVucDao khuVucDao = new KhuVucDao(daoFactory);
		khuvucs = khuVucDao.getAll();
		return Action.SUCCESS;
	}
	
	public String updateAccount() {
		try {
			log("UserAction.updateAccount");
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			//if(permission == false) return "error_permission";
			PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
			phongbans = phongBanDao.getAll();
			KhuVucDao khuVucDao = new KhuVucDao(daoFactory);
			khuvucs = khuVucDao.getAll();
			VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
			vmsgroups = vmsgroupDao.getAll();
			MenuDao menuDao = new MenuDao(daoFactory);
			menus = menuDao.getAllByUser(account.get("id").toString(),account.get("idgroup").toString());
			AccountDao accountDao = new AccountDao(daoFactory);
			user = accountDao.findById(account.get("id").toString());
			Map<String,String> map = user.getMap();
			form_data = JSONValue.toJSONString(map);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("message", e.getMessage());
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	public String doUpdateAccount() {
		log("UserAction.doUpdateAccount");
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			AccountDao accountDao = new AccountDao(daoFactory);
			user.setUsername(account.get("username").toString());
			user.setIdgroup(account.get("idgroup").toString());
			user.setIdphongban(account.get("idphongban").toString());
			user.setActive(Integer.valueOf(account.get("active").toString()));
			id = String.valueOf(accountDao.save(user));
			if(id == null) throw new Exception("ERROR");
			jsonData.put("result", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
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
			log("ERROR :" + e.getMessage());
		}
	}
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	public List<PhongBanDTO> getPhongbans() {
		return phongbans;
	}
	public void setPhongbans(List<PhongBanDTO> phongbans) {
		this.phongbans = phongbans;
	}
	public List<KhuVuc> getKhuvucs() {
		return khuvucs;
	}
	public void setKhuvucs(List<KhuVuc> khuvucs) {
		this.khuvucs = khuvucs;
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
	public List<Map<String, Object>> getVmsgroups() {
		return vmsgroups;
	}
	public void setVmsgroups(List<Map<String, Object>> vmsgroups) {
		this.vmsgroups = vmsgroups;
	}
	public List<Menu> getMenus() {
		return menus;
	}
	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}
	
}