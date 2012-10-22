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
import org.json.JSONException;
import org.json.JSONObject;

import vms.db.dao.DaoFactory;
import vms.db.dao.DiemDauCuoiDao;
import vms.db.dto.DiemDauCuoiDTO;
import vms.utils.Constances;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class DanhMucDiemDauCuoiAction implements Preparable {

	private LinkedHashMap<String, Object> jsonData;

	private DaoFactory factory;

	private boolean isDeleted;

	private HttpServletRequest request;

	private DiemDauCuoiDao DiemDauCuoiDao;

	private DiemDauCuoiDTO opEdit;
	private InputStream inputStream;

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

	public DiemDauCuoiDTO getOpEdit() {
		return opEdit;
	}

	public void setOpEdit(DiemDauCuoiDTO opEdit) {
		this.opEdit = opEdit;
	}

	private String flag = "0";

	private HttpSession session;

	private Map<String,Object> account;

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		this.session = request.getSession();
		this.account = (Map<String, Object>) session
				.getAttribute(Constances.SESS_USERLOGIN);
	}

	public DanhMucDiemDauCuoiAction(DaoFactory factory) {
		this.factory = factory;
		this.DiemDauCuoiDao = new DiemDauCuoiDao(factory);
		this.jsonData = new LinkedHashMap<String, Object>();
	}

	public String index() {
		// DiemDauCuoiDao dao = new DiemDauCuoiDao(factory);
		// xoa
		// dao.delete(new String[] { "1" });
		/*
		 * List<DiemDauCuoiDTO> lst = dao.get(); for (int i = 0; i < lst.size();
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
		isDeleted = this.DiemDauCuoiDao.delete(strIds.split(","));
		jsonData.put("isDeleted", isDeleted);
		return Action.SUCCESS;
	}

	public String edit() {
		String id = "";

		// edit page post
		if (this.opEdit != null) {
			// edit
			
			System.out.println("edit mode id=" + this.opEdit.getId());
			if (!this.opEdit.getId().isEmpty()) {
				System.out.println("Begin Edit");
				if (this.DiemDauCuoiDao.update(this.opEdit.getId(), this.opEdit)) {
					this.flag = "1";// updated
					setInputStream("OK");
				} else {
					this.flag = "-1";// failure
					System.out.println("Cập nhật lỗi");
				}
			} else {
				// new
				System.out.println("Begin New");
				if(this.DiemDauCuoiDao.insert(this.opEdit)){
					this.flag = "1";// updated
					setInputStream("OK");
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
				this.opEdit = (DiemDauCuoiDTO) this.DiemDauCuoiDao.get(id);
				System.out.println("finish load edit");
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
			}
		}

		return Action.SUCCESS;
	}
	
	public String dosave(){
		// edit page post
				if (this.opEdit != null) {
					// edit
					
					System.out.println("edit mode id=" + this.opEdit.getId());
					if (!this.opEdit.getId().isEmpty()) {
						System.out.println("Begin Edit");
						if (this.DiemDauCuoiDao.update(this.opEdit.getId(), this.opEdit)) {
							this.flag = "1";// updated
							setInputStream("OK");
						} else {
							this.flag = "-1";// failure
							System.out.println("Cập nhật lỗi");
						}
					} else {
						// new
						System.out.println("Begin New");
						if(this.DiemDauCuoiDao.insert(this.opEdit)){
							this.flag = "1";// updated
							setInputStream("OK");
						}else{
							this.flag = "-1";// failure
							System.out.println("Thêm lỗi");
						}
					}
					System.out.println("result=" + flag);

				
				}
		return Action.SUCCESS;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String ajLoad() throws JSONException {
		this.request = ServletActionContext.getRequest();
		// DiemDauCuoiDao DiemDauCuoiDao = new DiemDauCuoiDao(factory);
		List<DiemDauCuoiDTO> lstPhongBan = DiemDauCuoiDao.get();
		String strSearch = this.request.getParameter("sSearch");
		if (strSearch.isEmpty() == false) {
			JSONArray arrayJson = (JSONArray) new JSONObject(strSearch)
					.get("array");

			String name = arrayJson.getJSONObject(0).getString("value");
			lstPhongBan = DiemDauCuoiDao.search(name);
			System.out.println("strSearch=" + strSearch);

		} else
			lstPhongBan = DiemDauCuoiDao.get();
//asd
		jsonData = new LinkedHashMap<String, Object>();
		List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
		for (int i = 0; i < lstPhongBan.size(); i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			DiemDauCuoiDTO pb = lstPhongBan.get(i);
			map.putAll(pb.getMap());
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