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


import vms.db.dao.AccountDao;
import vms.db.dao.ChiTietPhuLucDAO;
import vms.db.dao.CongThucDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.DeXuatDao;
import vms.db.dao.HopDongDAO;
import vms.db.dao.KhuVucDao;
import vms.db.dao.LichSuPhuLucDAO;
import vms.db.dao.LichSuTuyenKenhDAO;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.MenuDao;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.ThanhToanDAO;
import vms.db.dao.TramDAO;
import vms.db.dao.VmsgroupDao;
import vms.db.dto.Menu;
import vms.db.dto.Rootmenu;
import vms.utils.Constances;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class AjaxAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData;
	
	private String id;
	public AjaxAction( DaoFactory factory) {
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
	
	public String uniqueUsername() throws Exception {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			String username = request.getParameter("username");
			if(username == null || username.isEmpty()) throw new Exception("NOT_OK");
			AccountDao accountDao = new AccountDao(daoFactory);
			int flag = accountDao.checkUsername(username);
			if(flag == 0)
				setInputStream("OK");
			else
				setInputStream("NOT_OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			if(e.getMessage() == null) setInputStream(Constances.MSG_ERROR);
			else
				setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String getRootMenu() throws Exception {
		MenuDao menuDao = new MenuDao(daoFactory);
		List<Rootmenu> list = menuDao.getRootmenu();
		jsonData =  new LinkedHashMap<String, Object>();
		List<Map<String, String>> result = new ArrayList<Map<String,String>>();
		for(int i =0 ;i<list.size(); i++) {
			result.add(list.get(i).getMap());
		}
		jsonData.put("status", 1);
		jsonData.put("data", result);
		return Action.SUCCESS;
	}
	
	public String getMenusByRoot() throws Exception {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			MenuDao menuDao = new MenuDao(daoFactory);
			String idrootmenu = request.getParameter("idrootmenu");
			List<Menu> list = menuDao.getMenusByRoot(idrootmenu);
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			for(int i =0 ;i<list.size(); i++) {
				result.add(list.get(i).getMap());
			}
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		
		return Action.SUCCESS;
	}
	
	public String getMenusByGroup(){
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
			String idgroup = request.getParameter("idgroup");
			List<Menu> list = vmsgroupDao.getMenuOfGroup(idgroup);
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			for(int i =0 ;i<list.size(); i++) {
				result.add(list.get(i).getMap());
			}
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String getMenusByAccount() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			AccountDao accountDao = new AccountDao(daoFactory);
			String account_id = request.getParameter("account_id");
			List<Menu> list = accountDao.getMenuOfAccount(account_id);
			List<Map<String, String>> result = new ArrayList<Map<String,String>>();
			for(int i =0 ;i<list.size(); i++) {
				result.add(list.get(i).getMap());
			}
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findMaTram() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			TramDAO tramDAO = new TramDAO(daoFactory);
			String matram = request.getParameter("matram");
			Map<String, String> conditions = new LinkedHashMap<String, String>();
			conditions.put("matram", matram);
			List<Map<String, Object>> result = tramDAO.search(0, 10, conditions);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String getAllCongThuc() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			CongThucDAO dao = new CongThucDAO(daoFactory);
			List<Map<String, Object>> result = dao.findAll();
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String getAllLoaiGiaoTiep() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			LoaiGiaoTiepDao dao = new LoaiGiaoTiepDao(daoFactory);
			List<Map<String, Object>> result = dao.getAll();
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findHopDongByDoiTac() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String doitac_id = request.getParameter("doitac_id");
			HopDongDAO dao = new HopDongDAO(daoFactory);
			List<Map<String, Object>> result = dao.findByDoitac(doitac_id);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findTuyenKenhByChiTietPhuLuc() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String chitietphuluc_id = request.getParameter("id");
			ChiTietPhuLucDAO dao = new ChiTietPhuLucDAO(daoFactory);
			List<Map<String, Object>> result = dao.findTuyenKenhByChiTietPhuLuc(chitietphuluc_id);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findTuyenKenhByPhuLuc() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String phuluc_id = request.getParameter("id");
			PhuLucDAO dao = new PhuLucDAO(daoFactory);
			List<Map<String, Object>> result = dao.findTuyenKenhByPhuLuc(phuluc_id);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findPhuLucThayThe() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String phuluc_id = request.getParameter("id");
			PhuLucDAO dao = new PhuLucDAO(daoFactory);
			List<Map<String, Object>> result = dao.findPhuLucThayThe(phuluc_id);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findVanBanDeXuatByTuyenKenhDeXuat() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String tuyenkenhdexuat_id = request.getParameter("id");
			DeXuatDao dao = new DeXuatDao(daoFactory);
			Map<String, Object> result = dao.findVanBanDeXuatByTuyenKenhDeXuat(tuyenkenhdexuat_id);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String lichSuTuyenKenh() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String tuyenkenh_id = request.getParameter("id");
			int page = NumberUtil.parseInt(request.getParameter("p"));
			LichSuTuyenKenhDAO dao = new LichSuTuyenKenhDAO(daoFactory);
			List<Map<String, Object>> result = dao.getData(page, tuyenkenh_id);
			jsonData.put("status", 1);
			jsonData.put("LS_MAX_PAGE_LENGHT", Constances.LS_MAX_PAGE_LENGHT);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String lichSuPhuLuc() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String phuluc_id = request.getParameter("id");
			int page = NumberUtil.parseInt(request.getParameter("p"));
			LichSuPhuLucDAO dao = new LichSuPhuLucDAO(daoFactory);
			List<Map<String, Object>> result = dao.getData(page, phuluc_id);
			jsonData.put("status", 1);
			jsonData.put("LS_MAX_PAGE_LENGHT", Constances.LS_MAX_PAGE_LENGHT);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findKhuVucByAccount() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String accountId = request.getParameter("id");
			KhuVucDao dao = new KhuVucDao(daoFactory);
			List<Map<String, String>> result = dao.findKhuVucByAccount(accountId);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String updateTrangThaiThanhToan() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String sohoso = request.getParameter("sohoso");
			String sNgaykyunc = request.getParameter("ngaykyunc");
			String sNgaychuyenkhoan = request.getParameter("ngaychuyenkhoan");
			ThanhToanDAO dao = new ThanhToanDAO(daoFactory);
			dao.updateTrangThaiThanhToan(sohoso, sNgaykyunc, sNgaychuyenkhoan);
			jsonData.put("status", 1);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String findPhuLucByHopDong() {
		jsonData =  new LinkedHashMap<String, Object>();
		try {
			String hopdong_id = request.getParameter("hopdong_id");
			PhuLucDAO dao = new PhuLucDAO(daoFactory);
			Map<String,String> conditions = new LinkedHashMap<String, String>();
			conditions.put("hopdong_id", hopdong_id);
			List<Map<String, Object>> result = dao.search(0, 1000, conditions);
			jsonData.put("status", 1);
			jsonData.put("data", result);
		} catch (Exception e) {
			jsonData.put("status", 0);
			jsonData.put("data", e.getMessage());
		}
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
	
	
	
	
}