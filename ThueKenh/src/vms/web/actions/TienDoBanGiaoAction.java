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
import vms.db.dao.DaoFactory;
import vms.db.dao.DuAnDAO;
import vms.db.dao.KhuVucDao;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhongBanDao;
import vms.db.dao.TieuChuanDAO;
import vms.db.dao.TuyenKenhBanGiaoDAO;
import vms.db.dao.TuyenKenhDeXuatDAO;
import vms.db.dto.DuAnDTO;
import vms.db.dto.KhuVucDTO;
import vms.db.dto.PhongBanDTO;
import vms.db.dto.TieuChuanDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhDeXuatDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class TienDoBanGiaoAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private TuyenKenhDeXuatDTO tuyenKenhDeXuatDTO;
	private TuyenKenh tuyenKenh;

	private InputStream inputStream;
	private MessageStore message;
	private LinkedHashMap<String, Object> jsonData;
	private String tuyenKenh_data;
	private String tuyenKenhDeXuatDTO_data;

	private List<Map<String, Object>> loaiGiaoTieps;
	private List<DuAnDTO> duAnDTOs;
	private List<KhuVucDTO> khuVucDTOs;
	private List<PhongBanDTO> phongBans;
	private String id;
	private String[] ids;
	private List<TieuChuanDTO> listTieuChuan;
	private List<TieuChuanDTO> listTieuChuanDatDuoc;

	public List<TieuChuanDTO> getListTieuChuan() {
		return listTieuChuan;
	}

	public void setListTieuChuan(List<TieuChuanDTO> listTieuChuan) {
		this.listTieuChuan = listTieuChuan;
	}

	public TienDoBanGiaoAction(DaoFactory factory) {
		daoFactory = factory;
	}
	private boolean permission = true;

	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.QUAN_LY_TIENDOBANGIAO) == false) {
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
		log("TienDoBanGiaoAction.execute");
		if (account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
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

	public String ajLoad() {
		log("TienDoBanGiaoAction.ajLoad");
		if (account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		try {
			// if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request
					.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request
					.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			Map<String, String> conditions = new LinkedHashMap<String, String>();
			conditions.put("account_id", account.get("id").toString());
			conditions.put("phongban_id", account.get("idphongban").toString());
			// kiem tra neu la phong KT
			if(account.get("maphongban")!= null && account.get("maphongban").equals("KTKT")) {
				log("La nhan vien phong KTKT => thay duoc toan bo tuyen kenh dang ban giao");
				conditions.put("isAllow", "1");
			} else {
				conditions.put("isAllow", "0");
			}

			conditions.put("iDisplayStart", "0");
			conditions.put("iDisplayLength", "10");
			/*
			 * iDisplayLength 10 iDisplayStart 0
			 */
			if (sSearch.isEmpty() == false) {
				JSONArray arrayJson = (JSONArray) new JSONObject(sSearch)
						.get("array");
				for (int i = 0; i < arrayJson.length(); i++) {
					String name = arrayJson.getJSONObject(i).getString("name");
					String value = arrayJson.getJSONObject(i)
							.getString("value");
					if (value.isEmpty() == false) {
						conditions.put(name, value);
					}
				}
			}
			TuyenKenhBanGiaoDAO TuyenKenhBanGiaoDAO = new TuyenKenhBanGiaoDAO(
					daoFactory);
			List<Map<String, Object>> items = TuyenKenhBanGiaoDAO.search(
					iDisplayStart, iDisplayLength + 1, conditions);
			int iTotalRecords = items.size();
			if(iTotalRecords > iDisplayLength) {
				items.remove(iTotalRecords - 1);
			}
			jsonData = new LinkedHashMap<String, Object>();
			jsonData.put("sEcho",Integer.parseInt(request.getParameter("sEcho")));
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
		log("TienDoBanGiaoAction.form");
		if (account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		id = request.getParameter("id");
		TieuChuanDAO tieuChuanDAO = new TieuChuanDAO(daoFactory);
		this.listTieuChuan = tieuChuanDAO.getAll();
		TuyenKenhBanGiaoDAO dao = new TuyenKenhBanGiaoDAO(daoFactory);
		this.listTieuChuanDatDuoc = dao.getTieuChuanDatDuoc(id);
		TuyenKenhDeXuatDAO tkdx=new TuyenKenhDeXuatDAO(daoFactory);
		this.tuyenKenhDeXuatDTO=tkdx.findById(id);
		return Action.SUCCESS;
	}

	public List<TieuChuanDTO> getListTieuChuanDatDuoc() {
		return listTieuChuanDatDuoc;
	}

	public void setListTieuChuanDatDuoc(List<TieuChuanDTO> listTieuChuanDatDuoc) {
		this.listTieuChuanDatDuoc = listTieuChuanDatDuoc;
	}

	public String doSave() {
		log("TienDoBanGiaoAction.doSave");
		try {
			if (account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			try {
				id = request.getParameter("id");
				TuyenKenhBanGiaoDAO TuyenKenhBanGiaoDAO = new TuyenKenhBanGiaoDAO(
						daoFactory);
				if(ids == null) {
					ids = new String[0];
				}
				TuyenKenhBanGiaoDAO.capNhatTienDo(id, ids,account.get("username").toString());
				setInputStream("OK");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}

	public String delete() {
		log("TienDoBanGiaoAction.delete");
		try {
			if (account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if (ids != null && ids.length > 0) {
				TuyenKenhBanGiaoDAO TuyenKenhBanGiaoDAO = new TuyenKenhBanGiaoDAO(
						daoFactory);
				TuyenKenhBanGiaoDAO.deleteByIds(ids);
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
			this.inputStream = new ByteArrayInputStream(str.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log("ERROR :" + e.getMessage());
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

	public String getTuyenKenh_data() {
		return tuyenKenh_data;
	}

	public void setTuyenKenh_data(String tuyenKenh_data) {
		this.tuyenKenh_data = tuyenKenh_data;
	}

	public String getTuyenKenhDeXuatDTO_data() {
		return tuyenKenhDeXuatDTO_data;
	}

	public void setTuyenKenhDeXuatDTO_data(String tuyenKenhDeXuatDTO_data) {
		this.tuyenKenhDeXuatDTO_data = tuyenKenhDeXuatDTO_data;
	}

	public String[] getIds() {
		return ids;
	}

	public void setIds(String[] ids) {
		this.ids = ids;
	}

	public TuyenKenhDeXuatDTO getTuyenKenhDeXuatDTO() {
		return tuyenKenhDeXuatDTO;
	}

	public void setTuyenKenhDeXuatDTO(TuyenKenhDeXuatDTO tuyenKenhDeXuatDTO) {
		this.tuyenKenhDeXuatDTO = tuyenKenhDeXuatDTO;
	}

	public List<Map<String, Object>> getLoaiGiaoTieps() {
		return loaiGiaoTieps;
	}

	public void setLoaiGiaoTieps(List<Map<String, Object>> loaiGiaoTieps) {
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

	public List<PhongBanDTO> getPhongBans() {
		return phongBans;
	}

	public void setPhongBans(List<PhongBanDTO> phongBans) {
		this.phongBans = phongBans;
	}

	public TuyenKenh getTuyenKenh() {
		return tuyenKenh;
	}

	public void setTuyenKenh(TuyenKenh tuyenKenh) {
		this.tuyenKenh = tuyenKenh;
	}

}