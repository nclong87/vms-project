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
import org.json.simple.JSONValue;
import vms.db.dao.DaoFactory;
import vms.db.dao.MenuDao;
import vms.db.dao.TuyenkenhDao;
import vms.db.dao.VmsgroupDao;
import vms.db.dto.Account;
import vms.db.dto.Menu;
import vms.db.dto.Vmsgroup;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.MessageStore;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class GroupAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Account account;
	
	private InputStream inputStream;
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<Menu> menus;
	
	private String id;
	private String[] ids;
	private Vmsgroup vmsgroup;
	public GroupAction( DaoFactory factory) {
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
		return Action.SUCCESS;
	}
	
	public String list() {
		try {
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
			List<Map<String, Object>> items = vmsgroupDao.getAll();
			int iTotalRecords = items.size();
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
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			MenuDao menuDao = new MenuDao(daoFactory);
			menus = menuDao.getAll();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
				vmsgroup = vmsgroupDao.findById(id);
				Map<String,String> map = vmsgroup.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	public String doSave() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
			id = String.valueOf(vmsgroupDao.save(vmsgroup));
			if(id == null) throw new Exception("ERROR");
			jsonData.put("result", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String doLock() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				String active = request.getParameter("active");
				VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
				vmsgroupDao.lock(ids, active);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
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
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public Vmsgroup getVmsgroup() {
		return vmsgroup;
	}
	public void setVmsgroup(Vmsgroup vmsgroup) {
		this.vmsgroup = vmsgroup;
	}
	public List<Menu> getMenus() {
		return menus;
	}
	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}
	
	
	
	
}