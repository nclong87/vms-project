package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;


import vms.db.dao.DaoFactory;
import vms.utils.Constances;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class IndexAction implements Preparable {
	@SuppressWarnings("unused")
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	
	private InputStream inputStream;
	private String message;
	private String jsonData;
	public IndexAction( DaoFactory factory) {
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
	
	public String execute() throws Exception {
		if(account == null)
			return "login_page";
		return Action.SUCCESS;
	}
	
	public String error() throws Exception {
		message = (String) session.getAttribute("message");
		session.removeAttribute("message");
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
	
}