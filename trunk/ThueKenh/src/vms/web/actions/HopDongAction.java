package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
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
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.SuCoDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.DoiTacDTO;
import vms.db.dto.HopDongDTO;
import vms.db.dto.LoaiGiaoTiep;
import vms.db.dto.SuCoDTO;
import vms.db.dto.TuyenKenh;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FN_FIND_SUCO;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class HopDongAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	
	private String form_data;
	private List<DoiTacDTO> doiTacs;
	private String id;
	private String[] ids;
	private Map<String,Object> detail;
	
	public List<DoiTacDTO> getDoiTacs() {
		return doiTacs;
	}
	public void setDoiTacs(List<DoiTacDTO> doiTacs) {
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
			System.out.println("ERROR :" + e.getMessage());
		}
	}
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("SuCoAction");
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		DoiTacDAO doitacDao = new DoiTacDAO(daoFactory);
		doiTacs = doitacDao.findAll();
		return Action.SUCCESS;
	}
	
	//load form
	public String form() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			DoiTacDAO doitacDao = new DoiTacDAO(daoFactory);
			doiTacs = doitacDao.findAll();
			form_data = "";
			System.out.println("id:"+id);
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				HopDongDAO hopdongDao = new HopDongDAO(daoFactory);
				hopdongDTO = hopdongDao.findById(id);
				System.out.println(hopdongDTO.getId());
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
		
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			// validation
			long ngayky=DateUtils.parseDate(hopdongDTO.getNgayky(), "dd/MM/yyyy").getTime();
			long ngayhethan=DateUtils.parseDate(hopdongDTO.getNgayhethan(), "dd/MM/yyyy").getTime();
			if(ngayky>ngayhethan) // ngay ky lon hon ngay het han
			{
				setInputStream("Date");
				return Action.SUCCESS;
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
			
			System.out.println("hopdongDTO.getSohopdong():"+hopdongDTO.getSohopdong());
			hopdongDTO.setUsercreate(account.get("username").toString());
			hopdongDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			hopdongDTO.setNgayky(DateUtils.parseStringDateSQL(hopdongDTO.getNgayky(), "dd/MM/yyyy"));
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
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch:"+sSearch);
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
			System.out.println("conditions="+conditions);
			List<Map<String, Object>> items = hopdongDao.search(iDisplayStart, iDisplayLength, conditions);
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
		HopDongDAO hopdongDao = new HopDongDAO(daoFactory);
		if(id == null) return Action.ERROR;
		detail = hopdongDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		return Action.SUCCESS;
	}
	
}