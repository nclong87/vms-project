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

public class PopupAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData;
	private Map<String,Object> json = new LinkedHashMap<String, Object>();
	
	private String id;
	private Integer action;
	public PopupAction( DaoFactory factory) {
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
			return "redirect-login";
		}
		switch (action) {
			case 1: //upload file de import tuyen kenh cho man hinh tinh gia tri phu luc
				return "import_gtpl";
			case 2: //update trang thai ho so thanh toan
				String sohoso = request.getParameter("sohoso");
				json.put("sohoso", sohoso);
				return "update_hsthanhtoan";
			default:
				break;
		}
		return Action.SUCCESS;
	}
	
	public String uploadFile() {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "redirect-login";
		}
		if(action == 1) { //upload file de import tuyen kenh cho man hinh tinh gia tri phu luc
			return "import_gtpl";
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
	public Integer getAction() {
		return action;
	}
	public void setAction(Integer action) {
		this.action = action;
	}
	public Map<String, Object> getJson() {
		return json;
	}
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
	
}