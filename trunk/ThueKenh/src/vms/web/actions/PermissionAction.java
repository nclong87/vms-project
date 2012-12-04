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

import vms.db.dao.AccountDao;
import vms.db.dao.DaoFactory;
import vms.db.dao.MenuDao;
import vms.db.dao.VmsgroupDao;
import vms.db.dto.Rootmenu;
import vms.utils.Constances;
import vms.utils.VMSUtil;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class PermissionAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	
	private InputStream inputStream;
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private String id;
	private String[] menu_id;
	private String[] khuvucs;
	private List<Rootmenu> rootmenus;
	public PermissionAction( DaoFactory factory) {
		daoFactory = factory;
	}
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
	}
	
	public String execute() {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		return Action.SUCCESS;
	}
	
	public String popup() {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "redirect-login";
		}
		MenuDao menuDao = new MenuDao(daoFactory);
		rootmenus = menuDao.getRootmenu();
		return Action.SUCCESS;
	}
	
	public String saveGroupMenu() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			if(account == null) throw new Exception("END_SESSION");
			if(id==null) throw new Exception("ERROR");
			if(menu_id == null) menu_id = new String[] {};
			VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
			vmsgroupDao.saveGroupMenus(menu_id, id);
			jsonData.put("status", 1);
			jsonData.put("data", "");
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String saveAccountMenu() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			if(account == null) throw new Exception("END_SESSION");
			if(id==null) throw new Exception("ERROR");
			if(menu_id == null) menu_id = new String[] {};
			AccountDao dao = new AccountDao(daoFactory);
			dao.saveAccountMenus(menu_id, id);
			jsonData.put("status", 1);
			jsonData.put("data", "");
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String saveAccountKhuvuc() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			if(account == null) throw new Exception("END_SESSION");
			if(id==null) throw new Exception("ERROR");
			if(khuvucs == null) khuvucs = new String[] {};
			AccountDao dao = new AccountDao(daoFactory);
			dao.saveAccountKhuvuc(khuvucs, id);
			jsonData.put("status", 1);
			jsonData.put("data", "");
		} catch (Exception e) {
			jsonData.put("status", 0);
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
			System.out.println("ERROR :" + e.getMessage());
		}
	}
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	public String getForm_data() {
		return form_data;
	}
	public void setForm_data(String form_data) {
		this.form_data = form_data;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String[] getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String[] menu_id) {
		this.menu_id = menu_id;
	}
	public List<Rootmenu> getRootmenus() {
		return rootmenus;
	}
	public void setRootmenus(List<Rootmenu> rootmenus) {
		this.rootmenus = rootmenus;
	}
	public String[] getKhuvucs() {
		return khuvucs;
	}
	public void setKhuvucs(String[] khuvucs) {
		this.khuvucs = khuvucs;
	}
	
	
}