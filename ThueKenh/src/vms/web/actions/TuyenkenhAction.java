package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.DuAnDAO;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhongBanDao;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.DuAnDTO;
import vms.db.dto.PhongBanDTO;
import vms.db.dto.TuyenKenh;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class TuyenkenhAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private TuyenKenh tuyenKenh;
	
	private InputStream inputStream;
	private InputStream excelStream;
	private String filename = "";
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<Map<String,Object>> loaiGiaoTieps;
	private List<DuAnDTO> duAnDTOs;
	private List<Map<String,Object>> doiTacDTOs;
	private List<PhongBanDTO> phongBans;
	private String id;
	private String[] ids;
	private Map<String,Object> detail;
	private boolean permission = true;
	public TuyenkenhAction( DaoFactory factory) {
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
		if(menus == null || menus.contains(Constances.QUAN_LY_TUYEN_KENH) == false) {
			permission = false;
		}
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
		loaiGiaoTieps = loaiGiaoTiepDao.getAll();
		DuAnDAO duAnDAO = new DuAnDAO(daoFactory);
		duAnDTOs = duAnDAO.findAll();
		DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
		doiTacDTOs = doiTacDAO.findAll();
		PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
		phongBans = phongBanDao.getAll();
		return Action.SUCCESS;
	}
	
	public String ajLoadTuyenkenh() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch="+sSearch);
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
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			List<Map<String,Object>> items = tuyenkenhDao.findTuyenkenh(iDisplayStart, 
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
			//setInputStream(str)
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
			if(permission == false) return "error_permission";
			LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
			loaiGiaoTieps = loaiGiaoTiepDao.getAll();
			DuAnDAO duAnDAO = new DuAnDAO(daoFactory);
			duAnDTOs = duAnDAO.findAll();
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			doiTacDTOs = doiTacDAO.findAll();
			PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
			phongBans = phongBanDao.getAll();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
				tuyenKenh = tuyenkenhDao.findById(id);
				System.out.println(tuyenKenh.getId());
				Map<String,String> map = tuyenKenh.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	public String doSave() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			System.out.println("Do save");
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			TuyenKenh tk = tuyenkenhDao.findByKey(tuyenKenh.getMadiemdau(), tuyenKenh.getMadiemcuoi(), tuyenKenh.getGiaotiep_id(),tuyenKenh.getDungluong());
			if(tk != null) {
				if(tuyenKenh.getId().isEmpty()) { //them moi
					throw new Exception("EXIST");
				} else { //update
					if(tuyenKenh.getId().equals(tk.getId()) == false) { //update trung voi 1 tuyen kenh khac
						throw new Exception("EXIST");
					} else {
						
					}
				}
			}
			
			//tuyenKenh.setNgaydenghibangiao(DateUtils.parseStringDateSQL(tuyenKenh.getNgaydenghibangiao(), "dd/MM/yyyy"));
			//tuyenKenh.setNgayhenbangiao(DateUtils.parseStringDateSQL(tuyenKenh.getNgayhenbangiao(), "dd/MM/yyyy"));
			tuyenKenh.setUsercreate(account.get("username").toString());
			tuyenKenh.setTimecreate(DateUtils.getCurrentDateSQL());
			id = tuyenkenhDao.save(tuyenKenh);
			if(id == null) throw new Exception(Constances.MSG_ERROR);
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			//session.setAttribute("message", e.getMessage());
			setInputStream(e.getMessage());
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
				TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
				tuyenkenhDao.deleteByIds(ids,account);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String export() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(ids != null && ids.length >0 ) {
			File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/TuyenKenhChuaBanGiao.xml")); 
			String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
			String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/tuyenkenhchuabangiao.xsl");
			String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
			//System.out.println("transformedString = "+transformedString);
			FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
			setExcelStream(transformedString);
			filename = "TuyenKenhChuaBanGiao_"+System.currentTimeMillis()+".xls";
		}	
		return Action.SUCCESS;
	}
	
	public String popupSearch() {
		LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
		loaiGiaoTieps = loaiGiaoTiepDao.getAll();
		DuAnDAO duAnDAO = new DuAnDAO(daoFactory);
		duAnDTOs = duAnDAO.findAll();
		DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
		doiTacDTOs = doiTacDAO.findAll();
		PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
		phongBans = phongBanDao.getAll();
		return Action.SUCCESS;
	}
	
	public String detail() {
		TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
		if(id == null) return Action.ERROR;
		detail = tuyenkenhDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		return Action.SUCCESS;
	}
	
	/*
	 * Tim kiem tuyen kenh de tinh gia tri phu luc
	 * Chi lay tuyen kenh dang hoat dong hoac da ban giao
	 */
	public String popupSearch2() {
		LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
		loaiGiaoTieps = loaiGiaoTiepDao.getAll();
		DuAnDAO duAnDAO = new DuAnDAO(daoFactory);
		duAnDTOs = duAnDAO.findAll();
		DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
		doiTacDTOs = doiTacDAO.findAll();
		PhongBanDao phongBanDao = new PhongBanDao(daoFactory);
		phongBans = phongBanDao.getAll();
		return Action.SUCCESS;
	}
	
	public String ajLoadTuyenkenhForSuCo() {
		System.out.println("Begin ajLoadTuyenkenhForSuCo");
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch="+sSearch);
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
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			List<Map<String,Object>> items = tuyenkenhDao.findTuyenkenhSuCo(iDisplayStart, iDisplayLength + 1, conditions);
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
		System.out.println("End ajLoadTuyenkenhForSuCo");
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
	public void setExcelStream(String str) {
		try {
			this.excelStream =  new ByteArrayInputStream( str.getBytes("UTF-8") );
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
	public TuyenKenh getTuyenKenh() {
		return tuyenKenh;
	}
	public void setTuyenKenh(TuyenKenh tuyenKenh) {
		this.tuyenKenh = tuyenKenh;
	}
	public List<Map<String,Object>> getLoaiGiaoTieps() {
		return loaiGiaoTieps;
	}
	public void setLoaiGiaoTieps(List<Map<String,Object>> loaiGiaoTieps) {
		this.loaiGiaoTieps = loaiGiaoTieps;
	}
	public List<DuAnDTO> getDuAnDTOs() {
		return duAnDTOs;
	}
	public void setDuAnDTOs(List<DuAnDTO> duAnDTOs) {
		this.duAnDTOs = duAnDTOs;
	}
	
	public List<Map<String,Object>> getDoiTacDTOs() {
		return doiTacDTOs;
	}
	public void setDoiTacDTOs(List<Map<String,Object>> doiTacDTOs) {
		this.doiTacDTOs = doiTacDTOs;
	}
	public List<PhongBanDTO> getPhongBans() {
		return phongBans;
	}
	public void setPhongBans(List<PhongBanDTO> phongBans) {
		this.phongBans = phongBans;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
	}
	public InputStream getExcelStream() {
		return excelStream;
	}
	public void setExcelStream(InputStream excelStream) {
		this.excelStream = excelStream;
	}
	public String getFilename() {
		return filename;
	}
}