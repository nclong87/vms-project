package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;

import vms.db.dao.BanGiaoDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.DeXuatDao;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.TuyenKenhDeXuatDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.Account;
import vms.db.dto.BanGiaoDTO;
import vms.db.dto.DeXuatDTO;
import vms.db.dto.DoiTacDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.FIND_DEXUAT;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class BanGiaoAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Account account;
	private DeXuatDTO deXuatDTO;
	
	private InputStream inputStream;
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<DoiTacDTO> doiTacDTOs;
	private String id;
	private String[] ids;
	private String[] dexuat_ids;
	private Map<String,Object> detail;
	
	private DeXuatDao deXuatDao;
	public BanGiaoAction( DaoFactory factory) {
		daoFactory = factory;
		deXuatDao = new DeXuatDao(factory);
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
		DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
		doiTacDTOs = doiTacDAO.findAll();
		return Action.SUCCESS;
	}
	
	public String load() {
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
			BanGiaoDAO bg=new BanGiaoDAO(daoFactory);
			List<BanGiaoDTO> list = bg.search(conditions.get("tenvanban"),iDisplayStart, iDisplayLength + 1);
			int iTotalRecords = list.size();
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<list.size() && i<iDisplayLength;i++) {
				Map<String, String> map = list.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				items.add(map);
			}
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
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			doiTacDTOs = doiTacDAO.findAll();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				deXuatDTO = deXuatDao.findById(id);
				Map<String,String> map = deXuatDTO.getMap();
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
			deXuatDTO.setUsercreate(account.getUsername());
			deXuatDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			deXuatDTO.setNgaydenghibangiao(DateUtils.parseStringDateSQL(deXuatDTO.getNgaydenghibangiao(), "dd/MM/yyyy"));
			deXuatDTO.setNgaygui(DateUtils.parseStringDateSQL(deXuatDTO.getNgaygui(), "dd/MM/yyyy"));
			id = deXuatDao.save(deXuatDTO);
			if(id == null) throw new Exception(Constances.MSG_ERROR);
			System.out.println("dexuat_ids.length" + dexuat_ids.length);
			if(dexuat_ids!= null && dexuat_ids.length > 0) {
				TuyenKenhDeXuatDAO tuyenKenhDeXuatDAO = new TuyenKenhDeXuatDAO(daoFactory);
				tuyenKenhDeXuatDAO.updateDexuatByIds(dexuat_ids, id);
			}
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
				deXuatDao.deleteByIds(ids);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		if(id == null) return Action.ERROR;
		detail = deXuatDao.getDetail(id);
		if(detail == null) return Action.ERROR;
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
	public DeXuatDTO getDeXuatDTO() {
		return deXuatDTO;
	}
	public void setDeXuatDTO(DeXuatDTO deXuatDTO) {
		this.deXuatDTO = deXuatDTO;
	}
	
	public String getForm_data() {
		return form_data;
	}
	public void setForm_data(String form_data) {
		this.form_data = form_data;
	}
	public List<DoiTacDTO> getDoiTacDTOs() {
		return doiTacDTOs;
	}
	public void setDoiTacDTOs(List<DoiTacDTO> doiTacDTOs) {
		this.doiTacDTOs = doiTacDTOs;
	}
	public String[] getDexuat_ids() {
		return dexuat_ids;
	}
	public void setDexuat_ids(String[] dexuat_ids) {
		this.dexuat_ids = dexuat_ids;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
	}
	
}