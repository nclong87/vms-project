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

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.HopDongDAO;
import vms.db.dto.HopDongDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class HopDongAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	
	private String form_data;
	private List<Map<String,Object>> doiTacs;
	private String id;
	private String thanhtoan_id;
	private String[] ids;
	private Map<String,Object> detail;
	private boolean permission = true;
	private String doitac;
	
	public String getDoitac() {
		return doitac;
	}
	public void setDoitac(String doitac) {
		this.doitac = doitac;
	}
	public String getThanhtoan_id() {
		return thanhtoan_id;
	}
	public void setThanhtoan_id(String thanhtoan_id) {
		this.thanhtoan_id = thanhtoan_id;
	}

	public List<Map<String,Object>> getDoiTacs() {
		return doiTacs;
	}
	public void setDoiTacs(List<Map<String,Object>> doiTacs) {
		this.doiTacs = doiTacs;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	private HopDongDTO hopdongDTO;
	private LinkedHashMap<String, Object> jsonData;
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	
	public HopDongDTO getHopdongDTO() {
		return hopdongDTO;
	}
	public void setHopdongDTO(HopDongDTO hopdongDTO) {
		this.hopdongDTO = hopdongDTO;
	}
	public HopDongAction( DaoFactory factory) {
		daoFactory = factory;
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
	
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.QUAN_LY_HOPDONG) == false) {
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
		log("HopDongAction.execute");
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		DoiTacDAO doitacDao = new DoiTacDAO(daoFactory);
		doiTacs = doitacDao.findAll();
		return Action.SUCCESS;
	}
	
	//load form
	public String form() {
		log("HopDongAction.form");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			DoiTacDAO doitacDao = new DoiTacDAO(daoFactory);
			doiTacs = doitacDao.findAll();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				log("id=" + id);
				HopDongDAO hopdongDao = new HopDongDAO(daoFactory);
				hopdongDTO = hopdongDao.findById(id);
				Map<String,String> map = hopdongDTO.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	// save hop dong
	public String doSave() {
		log("HopDongAction.doSave");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			if(permission == false) return "error_permission";
			// validation
			long ngayky=DateUtils.parseDate(hopdongDTO.getNgayky(), "dd/MM/yyyy").getTime();
			if(!hopdongDTO.getNgayhethan().isEmpty())
			{
				long ngayhethan=DateUtils.parseDate(hopdongDTO.getNgayhethan(), "dd/MM/yyyy").getTime();
				if(ngayky>ngayhethan) // ngay ky lon hon ngay het han
				{
					setInputStream("Date");
					return Action.SUCCESS;
				}
			}
			HopDongDAO hopdongDao=new HopDongDAO(daoFactory);
			if(hopdongDTO.getId().isEmpty())
			{
				if(hopdongDao.findBySohopdong(hopdongDTO.getSohopdong())!=null)
				{
					setInputStream("exist");
					return Action.SUCCESS;
				}
			}
			
			log("hopdongDTO.getSohopdong():"+hopdongDTO.getSohopdong());
			hopdongDTO.setUsercreate(account.get("username").toString());
			hopdongDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			hopdongDTO.setNgayky(DateUtils.parseStringDateSQL(hopdongDTO.getNgayky(), "dd/MM/yyyy"));
			if(!hopdongDTO.getNgayhethan().isEmpty())
				hopdongDTO.setNgayhethan(DateUtils.parseStringDateSQL(hopdongDTO.getNgayhethan(), "dd/MM/yyyy"));
			String id=hopdongDao.save(hopdongDTO);
			if(id==null) throw new Exception(Constances.MSG_ERROR);
			setInputStream("OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			//session.setAttribute("message", e.getMessage());
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	// load hop dong
	public String ajLoadHopDong() {
		log("HopDongAction.ajLoadHopDong");
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
			HopDongDAO hopdongDao = new HopDongDAO(daoFactory);
			List<Map<String, Object>> items = hopdongDao.search(iDisplayStart, iDisplayLength+1, conditions);
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
			//setInputStream(str)
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
		
	public String delete() {
		log("HopDongAction.delete");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				HopDongDAO hopdongDao = new HopDongDAO(daoFactory);
				hopdongDao.deleteByIds(ids);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		log("HopDongAction.detail");
		HopDongDAO hopdongDao = new HopDongDAO(daoFactory);
		if(id == null) return Action.ERROR;
		detail = hopdongDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		return Action.SUCCESS;
	}
}