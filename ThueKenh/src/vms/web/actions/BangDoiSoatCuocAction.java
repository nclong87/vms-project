package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import vms.db.dao.DaoFactory;
import vms.db.dao.DoiSoatCuocDAO;
import vms.db.dao.DoiTacDAO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class BangDoiSoatCuocAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	
	private String form_data;
	private String phuluchopdongs_data;
	private String id;
	private String[] ids;
	private String[] suco_ids;
	private Map<String,Object> detail;
	private String[] phuluc_ids;
	private List<Map<String,Object>> doiTacs;
	private LinkedHashMap<String, Object> jsonData;
	private Map<String,Object> json;
	
	
	public Map<String, Object> getJson() {
		return json;
	}
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
	public List<Map<String, Object>> getDoiTacs() {
		return doiTacs;
	}
	public void setDoiTacs(List<Map<String, Object>> doiTacs) {
		this.doiTacs = doiTacs;
	}
	public String getPhuluchopdongs_data() {
		return phuluchopdongs_data;
	}
	public void setPhuluchopdongs_data(String phuluchopdongs_data) {
		this.phuluchopdongs_data = phuluchopdongs_data;
	}
	public String[] getSuco_ids() {
		return suco_ids;
	}
	public void setSuco_ids(String[] suco_ids) {
		this.suco_ids = suco_ids;
	}
	
	public String[] getPhuluc_ids() {
		return phuluc_ids;
	}
	public void setPhuluc_ids(String[] phuluc_ids) {
		this.phuluc_ids = phuluc_ids;
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
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	
	
	public BangDoiSoatCuocAction( DaoFactory factory) {
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
	private boolean permission = true;
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("HoSoThanhToanAction");
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.BAOCAO_DOISOATCUOC) == false) {
			permission = false;
		}
	}
	
	public String execute() throws Exception {
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
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		json = new LinkedHashMap<String, Object>();
		json.put("thanhtien", request.getParameter("thanhtien"));
		json.put("giamtrumll", request.getParameter("giamtrumll"));
		json.put("id", request.getParameter("id"));
		return Action.SUCCESS;
	}
	
	// save ho so thanh toan
	public String doSave() {
		jsonData=new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			String doitac_id=request.getParameter("doitac_id");
			String thang=request.getParameter("thang");
			String nam=request.getParameter("nam");
			String mlltu=request.getParameter("thoidiembatdautu");
			String mllden=request.getParameter("thoidiembatdauden");
			int year = NumberUtil.parseInt(nam);
			int month = NumberUtil.parseInt(thang)-1;
			int date = 1;
			Calendar calendar = Calendar.getInstance();
			calendar.set(year, month, date);
			int maxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
			Date sqlTuNgay = DateUtils.parseToSQLDate("01/"+thang+"/"+nam,"dd/MM/yyyy");
			Date sqlDenNgay = DateUtils.parseToSQLDate(maxDay+"/"+thang+"/"+nam,"dd/MM/yyyy");
			Date sqlmatlienlactu=null;
			if(!mlltu.isEmpty())
				sqlmatlienlactu= DateUtils.parseToSQLDate(mlltu,"dd/MM/yyyy");
			Date sqlmatlienlacden=null;
			if(!mllden.isEmpty())
				sqlmatlienlacden=DateUtils.parseToSQLDate(mllden,"dd/MM/yyyy");
			DoiSoatCuocDAO reportdao=new DoiSoatCuocDAO(daoFactory);
			for(int i=0;i<phuluc_ids.length;i++)
				System.out.println("phuluc_ids[i]:"+phuluc_ids[i]);
			Map<String, Object> map = reportdao.saveDoiSoatCuoc(doitac_id, sqlTuNgay, sqlDenNgay, phuluc_ids, suco_ids,sqlmatlienlactu,sqlmatlienlacden);
			System.out.println("Doi soat cuoc ID =" +map.get("id"));
			System.out.println("Tong tien thanh toan = "+map.get("thanhtien"));
			System.out.println("Tong tien giam tru mat lien lac =" +map.get("giamtrumll"));
			jsonData.put("status", "OK");
			jsonData.put("data", map);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("status", "ERROR");
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String doSavebangdoisoatcuoc() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			String tenbangdoisoatcuoc=request.getParameter("tenbangdoisoatcuoc");
			String check=request.getParameter("check");
			String id=request.getParameter("id");
			DoiSoatCuocDAO doisoatcuocDao=new DoiSoatCuocDAO(daoFactory);
			if(check.compareTo("1")==0) // luu
			{
				doisoatcuocDao.updateDoiSoatCuoc(tenbangdoisoatcuoc, id);
			}
			else
			{
				doisoatcuocDao.deleteDoiSoatCuoc(id);
			}
			jsonData.put("status", "OK");
			jsonData.put("data", "");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("status", "ERROR");
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	public String load() {
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
			DoiSoatCuocDAO dscuocDao=new DoiSoatCuocDAO(daoFactory);
			List<Map<String,Object>> items = dscuocDao.search(iDisplayStart, 
					iDisplayLength + 1, conditions);
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
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
}