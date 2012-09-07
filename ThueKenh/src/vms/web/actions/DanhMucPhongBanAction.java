package vms.web.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import vms.db.dao.AccountDao;
import vms.db.dao.DaoFactory;
import vms.db.dao.PhongBanDao;
import vms.db.dto.Account;
import vms.db.dto.CatalogDTO;
import vms.db.dto.PhongBanDTO;
import vms.utils.Constances;
import vms.utils.VMSUtil;
import vms.web.models.AccountExt;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class DanhMucPhongBanAction implements Preparable {

	private LinkedHashMap<String, Object> jsonData;

	private DaoFactory factory;

	private boolean isDeleted;

	private HttpServletRequest request;

	private PhongBanDao phongbanDAO;

	private PhongBanDTO opEdit;

	public PhongBanDTO getOpEdit() {
		return opEdit;
	}

	public void setOpEdit(PhongBanDTO opEdit) {
		this.opEdit = opEdit;
	}

	private String flag = "0";

	private HttpSession session;

	private Account account;

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		this.session = request.getSession();
		this.account = (Account) session
				.getAttribute(Constances.SESS_USERLOGIN);
	}

	public DanhMucPhongBanAction(DaoFactory factory) {
		this.factory = factory;
		this.phongbanDAO = new PhongBanDao(factory);
		this.jsonData = new LinkedHashMap<String, Object>();
	}

	public String index() {
		// PhongBanDao dao = new PhongBanDao(factory);
		// xoa
		// dao.delete(new String[] { "1" });
		/*
		 * List<CatalogDTO> lst = dao.get(); for (int i = 0; i < lst.size();
		 * i++) { System.out.println(lst.get(i).getName()); }
		 */
		if (account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		return Action.SUCCESS;
	}

	public String delete() {
		System.out.println("delete");
		this.request = ServletActionContext.getRequest();
		String strIds = request.getParameter("ids");
		System.out.println(strIds);
		jsonData = new LinkedHashMap<String, Object>();
		isDeleted = this.phongbanDAO.delete(strIds.split(","));
		jsonData.put("isDeleted", isDeleted);

		return Action.SUCCESS;
	}

	public String edit() {
		int id = 0;

		// edit page post
		if (this.opEdit != null) {
			// edit
			System.out.println("edit mode id=" + this.opEdit.getId());
			if (this.opEdit.getId() > 0) {
				if (this.phongbanDAO.update(this.opEdit.getId(), this.opEdit)) {
					this.flag = "1";// updated
				} else
					this.flag = "-1";// failure
			} else {
				// new
				this.phongbanDAO.insert(this.opEdit);
			}
			System.out.println("result=" + flag);

		} else {
			// get page
			try {
				this.request = ServletActionContext.getRequest();
				id = Integer.parseInt(request.getParameter("id"));
				System.out.println("load edit id=" + id);
				this.opEdit = (PhongBanDTO) this.phongbanDAO.get(id);
				System.out.println("finish load edit");
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}

		return Action.SUCCESS;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String ajLoadPhongBan() {
		this.request = ServletActionContext.getRequest();
		// PhongBanDao phongbanDAO = new PhongBanDao(factory);
		List<CatalogDTO> lstPhongBan = phongbanDAO.get();
		jsonData = new LinkedHashMap<String, Object>();
		List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
		for (int i = 0; i < lstPhongBan.size(); i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			PhongBanDTO pb = (PhongBanDTO) lstPhongBan.get(i);
			map.put("stt", i + 1);
			map.put("id", pb.getId());
			map.put("name", pb.getName());
			items.add(map);
		}
		// jsonData.put("sEcho",
		// Integer.parseInt(request.getParameter("sEcho")));
		jsonData.put("iTotalRecords", lstPhongBan.size());
		jsonData.put("iTotalDisplayRecords", lstPhongBan.size());
		jsonData.put("aaData", items);

		return Action.SUCCESS;
	}

	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}

	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}

	public DaoFactory getFactory() {
		return factory;
	}

	public void setFactory(DaoFactory factory) {
		this.factory = factory;
	}
}
