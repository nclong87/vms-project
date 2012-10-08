package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
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
import vms.db.dao.DuAnDAO;
import vms.db.dao.KhuVucDao;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhongBanDao;
import vms.db.dao.TieuChuanDAO;
import vms.db.dao.TuyenKenhBanGiaoDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.Account;
import vms.db.dto.DuAnDTO;
import vms.db.dto.KhuVucDTO;
import vms.db.dto.LoaiGiaoTiep;
import vms.db.dto.PhongBan;
import vms.db.dto.PhongBanDTO;
import vms.db.dto.TieuChuanDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhDeXuatDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;
import vms.web.models.FIND_TUYENKENHBANGIAO;
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

	private List<LoaiGiaoTiep> loaiGiaoTieps;
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

	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
	}

	public String execute() throws Exception {
		if (account == null) {
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

	public String ajLoad() {
		if (account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		System.out.println("ajLoad");
		try {
			// if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request
					.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request
					.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch=" + sSearch);
			Map<String, String> conditions = new LinkedHashMap<String, String>();
			conditions.put("khuvuc_id", account.get("idkhuvuc").toString());
			conditions.put("phongban_id", account.get("idphongban").toString());
			// kiem tra neu la phong KT
			if(account.get("maphongban")!= null && account.get("maphongban").equals("KTKT")) {
				System.out.println("La nhan vien phong KTKT => thay duoc toan bo tuyen kenh dang ban giao");
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
					System.out.println(name + ":" + value);
					if (value.isEmpty() == false) {
						conditions.put(name, value);
						System.out.println(name + "-:-" + value);
					}
				}
			}
			TuyenKenhBanGiaoDAO TuyenKenhBanGiaoDAO = new TuyenKenhBanGiaoDAO(
					daoFactory);
			List<FIND_TUYENKENHBANGIAO> list = TuyenKenhBanGiaoDAO.search(
					iDisplayStart, iDisplayLength, conditions);
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for (int i = 0; i < list.size() && i < iDisplayLength; i++) {
				Map<String, String> map = list.get(i).getMap();
				map.put("stt", String.valueOf(i + 1));
				items.add(map);
			}
			jsonData.put("sEcho",
					Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", list.size());
			jsonData.put("iTotalDisplayRecords", list.size());
			jsonData.put("aaData", items);
			return Action.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	public String form() {
		if (account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		id = request.getParameter("id");

		
		
		

		TieuChuanDAO tieuChuanDAO = new TieuChuanDAO(daoFactory);
		this.listTieuChuan = tieuChuanDAO.getAll();
		TuyenKenhBanGiaoDAO dao = new TuyenKenhBanGiaoDAO(daoFactory);
		this.listTieuChuanDatDuoc = dao.getTieuChuanDatDuoc(id);
		return Action.SUCCESS;/*
							 * try { if(account == null) {
							 * session.setAttribute("URL",
							 * VMSUtil.getFullURL(request)); return
							 * "login_page"; } LoaiGiaoTiepDao loaiGiaoTiepDao =
							 * new LoaiGiaoTiepDao(daoFactory); loaiGiaoTieps =
							 * loaiGiaoTiepDao.getAll(); DuAnDAO duAnDAO = new
							 * DuAnDAO(daoFactory); duAnDTOs =
							 * duAnDAO.findAll(); KhuVucDao khuVucDao = new
							 * KhuVucDao(daoFactory); khuVucDTOs =
							 * khuVucDao.findAll(); PhongBanDao phongBanDao =
							 * new PhongBanDao(daoFactory); phongBans =
							 * phongBanDao.getAll(); tuyenKenh_data = "";
							 * tuyenKenhDeXuatDTO_data = ""; if(id != null &&
							 * id.isEmpty()==false) { System.out.println("id=" +
							 * id); TuyenKenhBanGiaoDAO TuyenKenhBanGiaoDAO =
							 * new TuyenKenhBanGiaoDAO(daoFactory);
							 * tuyenKenhDeXuatDTO =
							 * TuyenKenhBanGiaoDAO.findById(id); TuyenkenhDao
							 * tuyenkenhDao = new TuyenkenhDao(daoFactory);
							 * tuyenKenh =
							 * tuyenkenhDao.findById(tuyenKenhDeXuatDTO
							 * .getTuyenkenh_id());
							 * //System.out.println(tuyenKenhDeXuatDTO.getId());
							 * Map<String,String> map =
							 * tuyenKenhDeXuatDTO.getMap();
							 * tuyenKenhDeXuatDTO_data =
							 * JSONValue.toJSONString(map); map =
							 * tuyenKenh.getMap(); tuyenKenh_data =
							 * JSONValue.toJSONString(map); } } catch (Exception
							 * e) { e.printStackTrace(); return Action.ERROR; }
							 * return Action.SUCCESS;
							 */
	}

	public List<TieuChuanDTO> getListTieuChuanDatDuoc() {
		return listTieuChuanDatDuoc;
	}

	public void setListTieuChuanDatDuoc(List<TieuChuanDTO> listTieuChuanDatDuoc) {
		this.listTieuChuanDatDuoc = listTieuChuanDatDuoc;
	}

	public String doSave() {
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
			// session.setAttribute("message", e.getMessage());
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}

	public String delete() {
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

	public String popupSearch() {
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

	public String findByDexuat() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if (id != null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("dexuat_id", id);
				TuyenKenhBanGiaoDAO TuyenKenhBanGiaoDAO = new TuyenKenhBanGiaoDAO(
						daoFactory);
				List<FIND_TUYENKENHBANGIAO> list = TuyenKenhBanGiaoDAO.search(
						0, 1000, conditions);
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