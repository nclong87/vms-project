package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.simple.JSONValue;


import vms.db.dao.AccountDao;
import vms.db.dao.DaoFactory;
import vms.db.dao.MenuDao;
import vms.utils.Constances;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class LoginAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	
	private InputStream inputStream;
	private String message;
	private String jsonData;
	private Map<String,String> map;
	private String url;
	public LoginAction( DaoFactory factory) {
		daoFactory = factory;
	}
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
	}
	
	public String execute() throws Exception {
		jsonData = "";
		HttpSession session = request.getSession();
		if(request.getMethod().equals("POST")) {
			map = VMSUtil.getMap(request);
			String username = map.get("username");
			String password = map.get("password");
			jsonData = JSONValue.toJSONString(map);
			if(username.isEmpty()==false) {
				AccountDao accountDao = new AccountDao(daoFactory);
				boolean flag = VMSUtil.checkLDAP(username, password);
				if(flag == false) {
					System.out.println("Check LDAP false, try check in DB");
					flag = accountDao.checkLogin(username, password);
				}
				if( flag == false) {
					message = Constances.MSG_LOGINFAIL;
					return Action.SUCCESS;
				} else {
					Map<String, Object> account = accountDao.findByUsername(username);
					if(account == null) {
						message = Constances.MSG_LOGINFAIL;
						return Action.SUCCESS;
					}
					accountDao.loginSuccess(account.get("id").toString());
					session.setAttribute(Constances.SESS_USERLOGIN, account);
					String sMenu = accountDao.getMenu(account);
					session.setAttribute(Constances.SESS_MENU, sMenu);
				}
				
			} else {
				message = "Username not empty!";
				return Action.SUCCESS;
			}
		}
		if(session.getAttribute(Constances.SESS_USERLOGIN) != null) {
			url = (String) session.getAttribute("URL");
			MenuDao menuDao = new MenuDao(daoFactory);
			@SuppressWarnings("unchecked")
			Map<String, Object> account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
			session.setAttribute(Constances.SESS_MENUIDS, menuDao.getListMenuByUser(account));
			if(url == null) {
				url = menuDao.getDefaultMenu(account);
				if(url == null) {
					url = Constances.DEFAULT_HOME_PAGE;
				}
			}
			System.out.println("url="+url);
			return "index_page";
		}
		return Action.SUCCESS;
	}
	public String doLogout() {
		HttpSession session = request.getSession();
		session.invalidate();
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
	public String getJsonData() {
		return jsonData;
	}
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}