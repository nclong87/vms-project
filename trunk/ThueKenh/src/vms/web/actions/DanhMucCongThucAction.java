package vms.web.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import vms.db.dao.DaoFactory;
import vms.db.dao.CongThucDAO;
import vms.db.dto.Account;
import vms.db.dto.CatalogDTO;
import vms.db.dto.CongThucDTO;
import vms.utils.Constances;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class DanhMucCongThucAction implements Preparable {

	private LinkedHashMap<String, Object> jsonData;

	private DaoFactory factory;

	private boolean isDeleted;

	private HttpServletRequest request;

	private CongThucDAO congThucDAO;

	private CongThucDTO opEdit;

	public CongThucDTO getOpEdit() {
		return opEdit;
	}

	public void setOpEdit(CongThucDTO opEdit) {
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

	public DanhMucCongThucAction(DaoFactory factory) {
		this.factory = factory;
		this.congThucDAO = new CongThucDAO(factory);
		this.jsonData = new LinkedHashMap<String, Object>();
	}

	public String index() {
		// CongThucDAO dao = new CongThucDAO(factory);
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
		isDeleted = this.congThucDAO.delete(strIds.split(","));
		jsonData.put("isDeleted", isDeleted);

		return Action.SUCCESS;
	}

	public String edit() {
		String id = "";

		// edit page post
		if (this.opEdit != null) {
			// edit
			
			System.out.println("edit mode id=" + this.opEdit.getId());
			if (this.opEdit.getId() != "") {
				System.out.println("Begin Edit");
				if (this.congThucDAO.update(this.opEdit.getId(), this.opEdit)) {
					this.flag = "1";// updated
					System.out.println("Cập nhật thành công");
				} else {
					this.flag = "-1";// failure
					System.out.println("Cập nhật lỗi");
				}
			} else {
				// new
				System.out.println("Begin New");
				if(this.congThucDAO.insert(this.opEdit)){
					this.flag = "1";// updated
					System.out.println("Thêm thành công");
				}else{
					this.flag = "-1";// failure
					System.out.println("Thêm lỗi");
				}
			}
			System.out.println("result=" + flag);

		} else {
			// get page
			System.out.println("Begin Get Page");
			try {
				this.request = ServletActionContext.getRequest();
				id = request.getParameter("id");
				System.out.println("load edit id=" + id);
				this.opEdit = (CongThucDTO) this.congThucDAO.get(id);
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

	public String ajLoadPhongBan() throws JSONException {
		this.request = ServletActionContext.getRequest();
		// CongThucDAO CongThucDAO = new CongThucDAO(factory);
		List<CatalogDTO> lstPhongBan = congThucDAO.get();
		String strSearch = this.request.getParameter("sSearch");
		if (strSearch.isEmpty() == false) {
			JSONArray arrayJson = (JSONArray) new JSONObject(strSearch)
					.get("array");

			String name = arrayJson.getJSONObject(0).getString("value");
			lstPhongBan = congThucDAO.search(name);
			System.out.println("strSearch=" + strSearch);

		} else
			lstPhongBan = congThucDAO.get();

		jsonData = new LinkedHashMap<String, Object>();
		List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
		for (int i = 0; i < lstPhongBan.size(); i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			CongThucDTO pb = (CongThucDTO) lstPhongBan.get(i);
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
