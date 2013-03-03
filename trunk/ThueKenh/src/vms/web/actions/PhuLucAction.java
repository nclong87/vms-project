package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
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
import vms.db.dao.HopDongDAO;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.SuCoDAO;
import vms.db.dto.HopDongDTO;
import vms.db.dto.PhuLucDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class PhuLucAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private PhuLucDTO phuLucDTO;
	
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<Map<String,Object>> doiTacDTOs;
	private String id;
	private String[] ids;
	private String[] arrPhuLucThayThe;
	private Map<String,Object> json;
	private Map<String,Map<String,Object>> hopDongDTOs;
	public String hopdong_id;
	public String doisoatcuoc_id;
	
	private PhuLucDAO phuLucDAO;
	private boolean permission = true;

	public PhuLucAction( DaoFactory factory) {
		daoFactory = factory;
		phuLucDAO = new PhuLucDAO(factory);
	}
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.QUAN_LY_PHULUC) == false) {
			permission = false;
		}
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		HopDongDAO dao = new HopDongDAO(daoFactory);
		hopDongDTOs = dao.findAllHopDongByDoitac();
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
			List<Map<String,Object>> items = phuLucDAO.search(iDisplayStart, 
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
			//DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			//doiTacDTOs = doiTacDAO.findAll();
			HopDongDAO dao = new HopDongDAO(daoFactory);
			hopDongDTOs = dao.findAllHopDongByDoitac();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				phuLucDTO = phuLucDAO.findById(id);
				Map<String,String> map = phuLucDTO.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	public String doSave() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			HopDongDAO hopDongDAO = new HopDongDAO(daoFactory);
			HopDongDTO hopDongDTO = hopDongDAO.findById(phuLucDTO.getHopdong_id());
			List<String> listTuyenKenhLoi = phuLucDAO.validateBeforeSavePhuLuc(phuLucDTO, arrPhuLucThayThe, phuLucDTO.getNgayhieuluc(),hopDongDTO) ;
			if(listTuyenKenhLoi.isEmpty() == false) {
				String errMessage = "Lỗi xảy ra khi lưu phụ lục :<ul style=\"margin:0\">";
				for(int i=0;i<listTuyenKenhLoi.size();i++) {
					errMessage += "<li>"+listTuyenKenhLoi.get(i)+"</li>";
				}
				errMessage+="</ul>";
				throw new Exception(errMessage);
			}
			phuLucDTO.setUsercreate(account.get("username").toString());
			phuLucDTO.setTimecreate(String.valueOf(System.currentTimeMillis()));
			phuLucDTO.setNgayky(DateUtils.parseStringDateSQL(phuLucDTO.getNgayky(), "dd/MM/yyyy"));
			Date date = DateUtils.parseDate(phuLucDTO.getNgayhieuluc(), "dd/MM/yyyy");
			phuLucDTO.setNgayhieuluc(DateUtils.parseStringDateSQL(phuLucDTO.getNgayhieuluc(), "dd/MM/yyyy"));
			id = phuLucDAO.save(phuLucDTO);
			if(id == null) throw new Exception(Constances.MSG_ERROR);
			SuCoDAO suCoDAO = new SuCoDAO(daoFactory);
			if(phuLucDTO.getId().isEmpty() == false) { //update phu luc
				suCoDAO.resetSuco(id);
			}
			List<Map<String,Object>> listSuco = suCoDAO.findSuCoByPhuLuc(id);
			if(listSuco.isEmpty()==false) {
				System.out.println("listSuco.size()="+listSuco.size());
				for(int i=0; i < listSuco.size(); i++) {
					Map<String,Object> map = listSuco.get(i);
					if(map.get("suco_phuluc").toString().isEmpty()) { //su co chua co phu luc
						System.out.println("1");
						suCoDAO.updatePhuLuc(map, id, 0);
					} else {
						System.out.println("2");
						suCoDAO.updatePhuLuc(map, id, 1);
					}
				}
			}
			phuLucDTO.setId(id);
			if(phuLucDTO.getLoaiphuluc() == Constances.PHU_LUC_THAY_THE) {
				if(arrPhuLucThayThe!= null && arrPhuLucThayThe.length>0) {
					date = DateUtils.add(date, Calendar.DATE, -1);
					phuLucDAO.updatePhuLucThayThe(phuLucDTO, arrPhuLucThayThe,date,account.get("username").toString());
				}
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
	
	public String delete() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				phuLucDAO.deleteByIds(ids,account.get("username").toString());
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
		json = phuLucDAO.getDetail(id);
		if(json == null) return Action.ERROR;
		return Action.SUCCESS;
	}
	
	public String popupSearch() {
		HopDongDAO dao = new HopDongDAO(daoFactory);
		hopDongDTOs = dao.findAllHopDongByDoitac();
		return Action.SUCCESS;
	}
	
	public String findphulucByhopdong() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(hopdong_id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				System.out.println("hopdong_id:"+hopdong_id);
				conditions.put("hopdong_id", hopdong_id);
				conditions.put("ischeckAvailable","1");
				String thang=request.getParameter("thang");
				String nam=request.getParameter("nam");
				String ngayDSC=nam+"-"+thang+"-1";
				conditions.put("ngayDSC",ngayDSC );
				PhuLucDAO phulucDao = new PhuLucDAO(daoFactory);
				List<Map<String, Object>> items = phulucDao.search(0, 1000, conditions);
				jsonData.put("result", "OK");
				jsonData.put("aaData", items);
				return Action.SUCCESS;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			jsonData.put("result", "ERROR");
		}
		return Action.SUCCESS;
	}
	public String findphulucByhopdong2() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(hopdong_id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				System.out.println("hopdong_id:"+hopdong_id);
				conditions.put("hopdong_id", hopdong_id);
				String thang=request.getParameter("thang");
				String nam=request.getParameter("nam");
				String ngayDSC=nam+"-"+thang+"-1";
				conditions.put("ngayDSC",ngayDSC );
				PhuLucDAO phulucDao = new PhuLucDAO(daoFactory);
				List<Map<String, Object>> items = phulucDao.search(0, 1000, conditions);
				jsonData.put("result", "OK");
				jsonData.put("aaData", items);
				return Action.SUCCESS;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			jsonData.put("result", "ERROR");
		}
		return Action.SUCCESS;
	}
	
	public String findphulucByhopdonganddoisoatcuoc() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(hopdong_id!= null && doisoatcuoc_id!=null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				System.out.println("hopdong_id:"+hopdong_id);
				conditions.put("hopdong_id", hopdong_id);
				conditions.put("doisoatcuoc_id", doisoatcuoc_id);
				PhuLucDAO phulucDao = new PhuLucDAO(daoFactory);
				List<Map<String, Object>> items = phulucDao.searchByHopDongDoiSoatCuoc(0, 1000, conditions);
				jsonData.put("result", "OK");
				jsonData.put("aaData", items);
				return Action.SUCCESS;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			jsonData.put("result", "ERROR");
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
	public PhuLucDTO getPhuLucDTO() {
		return phuLucDTO;
	}
	public void setPhuLucDTO(PhuLucDTO phuLucDTO) {
		this.phuLucDTO = phuLucDTO;
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
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public Map<String, Object> getJson() {
		return json;
	}
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
	public List<Map<String, Object>> getDoiTacDTOs() {
		return doiTacDTOs;
	}
	public void setDoiTacDTOs(List<Map<String, Object>> doiTacDTOs) {
		this.doiTacDTOs = doiTacDTOs;
	}
	public Map<String, Map<String, Object>> getHopDongDTOs() {
		return hopDongDTOs;
	}
	public void setHopDongDTOs(Map<String, Map<String, Object>> hopDongDTOs) {
		this.hopDongDTOs = hopDongDTOs;
	}
	public String[] getArrPhuLucThayThe() {
		return arrPhuLucThayThe;
	}
	public void setArrPhuLucThayThe(String[] arrPhuLucThayThe) {
		this.arrPhuLucThayThe = arrPhuLucThayThe;
	}
	public String getHopdong_id() {
		return hopdong_id;
	}
	public void setHopdong_id(String hopdong_id) {
		this.hopdong_id = hopdong_id;
	}
	public String getDoisoatcuoc_id() {
		return doisoatcuoc_id;
	}
	public void setDoisoatcuoc_id(String doisoatcuoc_id) {
		this.doisoatcuoc_id = doisoatcuoc_id;
	}
}