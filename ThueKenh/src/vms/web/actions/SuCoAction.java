package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import vms.db.dao.PhuLucDAO;
import vms.db.dao.SuCoDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.SuCoDTO;
import vms.db.dto.TuyenKenh;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FN_FIND_SUCO;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class SuCoAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	
	private String form_data;
	private String id;
	private String[] ids;
	private Map<String,Object> detail;
	
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
	private SuCoDTO sucoDTO;
	private LinkedHashMap<String, Object> jsonData;
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	public SuCoDTO getSucoDTO() {
		return sucoDTO;
	}
	public void setSucoDTO(SuCoDTO sucoDTO) {
		this.sucoDTO = sucoDTO;
	}
	
	public SuCoAction( DaoFactory factory) {
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
		return Action.SUCCESS;
	}
	
	//load form
	public String form() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			
			form_data = "";
			System.out.println("id:"+id);
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				sucoDTO = sucoDao.findById(id);
				System.out.println(sucoDTO.getId());
				Map<String,String> map = sucoDTO.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	// save su co
	public String doSave() {
		
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			// validation
			Date dateThoiDiemBatDau = DateUtils.parseDate(sucoDTO.getThoidiembatdau(), "dd/MM/yyyy HH:mm:ss");
			java.sql.Date sqlDateThoiDiemBatDau= DateUtils.convertToSQLDate(dateThoiDiemBatDau);
			
			long thoidiembatdau=dateThoiDiemBatDau.getTime();
			long thoidiemketthuc=DateUtils.parseDate(sucoDTO.getThoidiemketthuc(), "dd/MM/yyyy HH:mm:ss").getTime();
			if( sucoDTO.getId().isEmpty())
			{
				Long ngayhientai=Calendar.getInstance().getTime().getTime();
				if(thoidiembatdau>ngayhientai || thoidiemketthuc>ngayhientai)
				{
					setInputStream("ngayhientai");
					return Action.SUCCESS;
				}
			}
			if(thoidiembatdau>thoidiemketthuc) // thoi diem bat dau lon hon thoi diem ket thuc
			{
				setInputStream("Date");
				return Action.SUCCESS;
			}
			TuyenkenhDao tuyenkenhDao=new TuyenkenhDao(daoFactory);
			TuyenKenh tuyenkenhDto=tuyenkenhDao.findById(sucoDTO.getTuyenkenh_id());
			if(tuyenkenhDto==null)
			{
				setInputStream("TuyenKenhNotExist");
				return Action.SUCCESS;
			}    
			SuCoDAO sucoDao=new SuCoDAO(daoFactory);
			float thoigianmatll= (float)Math.round(((float)(thoidiemketthuc-thoidiembatdau)/(60000))*100)/100;
			System.out.println("thoigianmatlienlac:"+thoigianmatll);
			sucoDTO.setThoidiembatdau(String.valueOf(thoidiembatdau));
			sucoDTO.setThoidiemketthuc(String.valueOf(thoidiemketthuc));
			sucoDTO.setThoigianmll(thoigianmatll);
			sucoDTO.setUsercreate(account.get("username").toString());
			sucoDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			sucoDTO.setBienbanvanhanh_id("0");
			PhuLucDAO phuLucDAO = new PhuLucDAO(daoFactory);
			Map<String, Object> mapPhuluc = phuLucDAO.findPhuLucCoHieuLuc(sucoDTO.getTuyenkenh_id(), sqlDateThoiDiemBatDau);
			if(mapPhuluc == null) {
				throw new Exception("ERROR_PHULUCNOTFOUND");
			}
			sucoDTO.setPhuluc_id(mapPhuluc.get("id").toString());
			//Tim don gia tuyen kenh
			
			
 			String id=sucoDao.save(sucoDTO);
			if(id==null) throw new Exception(Constances.MSG_ERROR);
			setInputStream("OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			//session.setAttribute("message", e.getMessage());
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	// load su co
	public String ajLoadSuCo() {
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
			SuCoDAO sucoDao = new SuCoDAO(daoFactory);
			System.out.println("conditions="+conditions);
			List<FN_FIND_SUCO> lstSuCo = sucoDao.findSuCo(iDisplayStart, iDisplayLength+1, conditions);
			int iTotalRecords=lstSuCo.size();
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<lstSuCo.size() && i<iDisplayLength;i++) {
				Map<String, String> map = lstSuCo.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				items.add(map);
			}
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart+iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart+iTotalRecords);
			jsonData.put("aaData", items);
			return Action.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			//setInputStream(str)
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	// load su co chưa thuộc biên bản vận hành kênh nào
	public String ajLoadSuCoWithBBVH() {
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
			conditions.put("bienbanvanhanh_id", "0");
			SuCoDAO sucoDao = new SuCoDAO(daoFactory);
			System.out.println("conditions="+conditions);
			List<FN_FIND_SUCO> lstSuCo = sucoDao.findSuCo(iDisplayStart, iDisplayLength+1, conditions);
			int iTotalRecords=lstSuCo.size();
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<lstSuCo.size() && i<iDisplayLength;i++) {
				Map<String, String> map = lstSuCo.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				map.put("suco_id", lstSuCo.get(i).getSuco_id());
				items.add(map);
			}
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart+iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart+iTotalRecords);
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
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				sucoDao.deleteByIds(ids);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		SuCoDAO sucoDao = new SuCoDAO(daoFactory);
		if(id == null) return Action.ERROR;
		detail = sucoDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		return Action.SUCCESS;
	}
	
	public String findByBienbanvanhanh() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("bienbanvanhanh_id", id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				List<FN_FIND_SUCO> list = sucoDao.findSuCo(0, 1000, conditions);
				jsonData.put("result", "OK");
				jsonData.put("aaData", list);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			jsonData.put("result", "ERROR");
		}
		return Action.SUCCESS;
	}
	
	public String findBythanhtoan() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("thanhtoan_id", id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				List<FN_FIND_SUCO> list = sucoDao.findSuCo(0, 1000, conditions);
				jsonData.put("result", "OK");
				jsonData.put("aaData", list);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			jsonData.put("result", "ERROR");
		}
		return Action.SUCCESS;
	}
}