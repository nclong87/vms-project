package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;


import vms.db.dao.AccountDao;
import vms.db.dao.DaoFactory;
import vms.db.dao.DuAnDAO;
import vms.db.dao.KhuVucDao;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhongBanDao;
import vms.db.dao.TuyenkenhDao;
import vms.db.dao.VmsgroupDao;
import vms.db.dto.Account;
import vms.db.dto.DuAnDTO;
import vms.db.dto.KhuVuc;
import vms.db.dto.KhuVucDTO;
import vms.db.dto.LoaiGiaoTiep;
import vms.db.dto.PhongBan;
import vms.db.dto.PhongBanDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.Vmsgroup;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.AccountExt;
import vms.web.models.FN_FIND_TUYENKENH;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class TuyenkenhAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Account account;
	private TuyenKenh tuyenKenh;
	
	private InputStream inputStream;
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<LoaiGiaoTiep> loaiGiaoTieps;
	private List<DuAnDTO> duAnDTOs;
	private List<KhuVucDTO> khuVucDTOs;
	private List<PhongBan> phongBans;
	private String id;
	private String[] ids;
	public TuyenkenhAction( DaoFactory factory) {
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
		LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
		loaiGiaoTieps = loaiGiaoTiepDao.getAll();
		DuAnDAO duAnDAO = new DuAnDAO(daoFactory);
		duAnDTOs = duAnDAO.findAll();
		KhuVucDao khuVucDao = new KhuVucDao(daoFactory);
		khuVucDTOs = khuVucDao.findAll();
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
			List<FN_FIND_TUYENKENH> lstTuyenkenh = tuyenkenhDao.findTuyenkenh(iDisplayStart, iDisplayLength, conditions);
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<lstTuyenkenh.size() && i<iDisplayLength;i++) {
				Map<String, String> map = lstTuyenkenh.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				items.add(map);
			}
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", lstTuyenkenh.size());
			jsonData.put("iTotalDisplayRecords", lstTuyenkenh.size());
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
			LoaiGiaoTiepDao loaiGiaoTiepDao = new LoaiGiaoTiepDao(daoFactory);
			loaiGiaoTieps = loaiGiaoTiepDao.getAll();
			DuAnDAO duAnDAO = new DuAnDAO(daoFactory);
			duAnDTOs = duAnDAO.findAll();
			KhuVucDao khuVucDao = new KhuVucDao(daoFactory);
			khuVucDTOs = khuVucDao.findAll();
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
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			if(tuyenkenhDao.findByKey(tuyenKenh.getMadiemdau(), tuyenKenh.getMadiemcuoi(), tuyenKenh.getGiaotiep_id()) != null) {
				throw new Exception("EXIST");
			}
			tuyenKenh.setNgaydenghibangiao(DateUtils.parseStringDateSQL(tuyenKenh.getNgaydenghibangiao(), "dd/MM/yyyy"));
			tuyenKenh.setNgayhenbangiao(DateUtils.parseStringDateSQL(tuyenKenh.getNgayhenbangiao(), "dd/MM/yyyy"));
			tuyenKenh.setUsercreate(account.getUsername());
			tuyenKenh.setTimecreate(DateUtils.getCurrentDateSQL());
			System.out.println(tuyenKenh.getNgaydenghibangiao());
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
	public List<LoaiGiaoTiep> getLoaiGiaoTieps() {
		return loaiGiaoTieps;
	}
	public void setLoaiGiaoTieps(List<LoaiGiaoTiep> loaiGiaoTieps) {
		this.loaiGiaoTieps = loaiGiaoTieps;
	}
	public List<DuAnDTO> getDuAnDTOs() {
		return duAnDTOs;
	}
	public void setDuAnDTOs(List<DuAnDTO> duAnDTOs) {
		this.duAnDTOs = duAnDTOs;
	}
	public List<KhuVucDTO> getKhuVucDTOs() {
		return khuVucDTOs;
	}
	public void setKhuVucDTOs(List<KhuVucDTO> khuVucDTOs) {
		this.khuVucDTOs = khuVucDTOs;
	}
	public List<PhongBan> getPhongBans() {
		return phongBans;
	}
	public void setPhongBans(List<PhongBan> phongBans) {
		this.phongBans = phongBans;
	}
	
	
}