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
import org.json.simple.JSONValue;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiSoatCuocDAO;
import vms.db.dao.SuCoDAO;
import vms.db.dao.ThanhToanDAO;
import vms.db.dto.HopDongDetailDTO;
import vms.db.dto.SuCoDTO;
import vms.db.dto.ThanhToanDTO;
import vms.db.dto.PhuLucHopDongDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class ThanhToanAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	
	private String form_data;
	private String doisoatcuoc_info;
	private String id;
	private String[] ids;
	private String[] suco_ids;
	private Map<String,Object> detail;
	private List<PhuLucHopDongDTO> phuluchopdongDtos;
	private boolean permission = true;
	
	public String getDoisoatcuoc_info() {
		return doisoatcuoc_info;
	}
	public void setDoisoatcuoc_info(String doisoatcuoc_info) {
		this.doisoatcuoc_info = doisoatcuoc_info;
	}
	
	public String[] getSuco_ids() {
		return suco_ids;
	}
	public void setSuco_ids(String[] suco_ids) {
		this.suco_ids = suco_ids;
	}
	public List<PhuLucHopDongDTO> getPhuluchopdongDtos() {
		return phuluchopdongDtos;
	}
	public void setPhuluchopdongDtos(List<PhuLucHopDongDTO> phuluchopdongDtos) {
		this.phuluchopdongDtos = phuluchopdongDtos;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
	}
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
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
	private ThanhToanDTO thanhtoanDTO;
	private LinkedHashMap<String, Object> jsonData;
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	
	public ThanhToanDTO getThanhtoanDTO() {
		return thanhtoanDTO;
	}
	public void setThanhtoanDTO(ThanhToanDTO thanhtoanDTO) {
		this.thanhtoanDTO = thanhtoanDTO;
	}
	public ThanhToanAction( DaoFactory factory) {
		daoFactory = factory;
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
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("HoSoThanhToanAction");
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.QUAN_LY_HOSOTHANHTOAN) == false) {
			permission = false;
		}
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		return Action.SUCCESS;
	}
	
	//load form
	public String form() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			form_data = "";
			System.out.println("id:"+id);
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				ThanhToanDAO hosothanhtoanDao = new ThanhToanDAO(daoFactory);
				thanhtoanDTO = hosothanhtoanDao.findById(id);
				System.out.println(thanhtoanDTO.getId());
				Map<String,String> map = thanhtoanDTO.getMap();
				form_data = JSONValue.toJSONString(map);
				DoiSoatCuocDAO dscDao=new DoiSoatCuocDAO(daoFactory);
				Map<String, String> conditions=new LinkedHashMap<String, String>();
				conditions.put("id", thanhtoanDTO.getDoisoatcuoc_id());
				List<Map<String,Object>> doisoatcuoc=dscDao.search(0, 1000, conditions);
				doisoatcuoc_info=JSONValue.toJSONString(doisoatcuoc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	//load form
	public String loadformbydoisoatcuoc() {
		System.out.println("Begin load form by doi soat cuoc id");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			if(permission == false) return "error_permission";
			String doisoatcuoc_id=request.getParameter("doisoatcuoc_id");
			System.out.println("doisoatcuoc_id:"+doisoatcuoc_id);
			if(doisoatcuoc_id != null && doisoatcuoc_id.isEmpty()==false) {
				DoiSoatCuocDAO dscDao=new DoiSoatCuocDAO(daoFactory);
				List<HopDongDetailDTO> lstHopDong=dscDao.findHopDongByDoiSoatCuocId(doisoatcuoc_id);
				String phuluchopdongs_data="";
				for(int i=0;i<lstHopDong.size();i++)
				{
					System.out.println("lstHopDong.get(i).getId():"+lstHopDong.get(i).getId());
					if(!phuluchopdongs_data.isEmpty())
						phuluchopdongs_data+=",";
					phuluchopdongs_data+="{\"id\":"+lstHopDong.get(i).getId()+",";
					phuluchopdongs_data+="\"sohopdong\":\""+lstHopDong.get(i).getSohopdong()+"\",";
					phuluchopdongs_data+="\"loaihopdong\":\""+lstHopDong.get(i).getLoaihopdong()+"\",";
					phuluchopdongs_data+="\"tendoitac\":\""+lstHopDong.get(i).getTendoitac()+"\",";
					phuluchopdongs_data+="\"ngayky\":\""+lstHopDong.get(i).getNgayky()+"\",";
					phuluchopdongs_data+="\"ngayhethan\":\""+lstHopDong.get(i).getNgayhethan()+"\",";
					List<String> lstPhuLuc=dscDao.findPhuLucByDoiSoatCuoc_HopDong(doisoatcuoc_id, lstHopDong.get(i).getId());
					phuluchopdongs_data+="\"phuluc_id\":[";
					String phuluc_ids="";
					for(int j=0;j<lstPhuLuc.size();j++)
					{
						System.out.println(lstPhuLuc.get(j));
						if(!phuluc_ids.isEmpty())
							phuluc_ids+=",";
						phuluc_ids+="{\"id\":"+lstPhuLuc.get(j)+"}";
					}
					phuluchopdongs_data+=phuluc_ids;
					phuluchopdongs_data+="]";
					phuluchopdongs_data+="}";
				}
				phuluchopdongs_data="["+phuluchopdongs_data+"]";
				// suco
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("doisoatcuoc_id", doisoatcuoc_id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				List<Map<String,Object>> listsuco = sucoDao.findSuCoByDoiSoatCuoc(0, 1000, conditions);
				
				jsonData = new LinkedHashMap<String, Object>();
				jsonData.put("result", "OK");
				jsonData.put("phuluc_hopdongs", phuluchopdongs_data);
				jsonData.put("sucos", listsuco);
				
				return Action.SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		System.out.println("End load form by doi soat cuoc id");
		return Action.SUCCESS;
	}
	
	// save ho so thanh toan
	public String doSave() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			thanhtoanDTO.setNgaychuyenkt(DateUtils.parseStringDateSQL(thanhtoanDTO.getNgaychuyenkt(), "dd/MM/yyyy"));
			thanhtoanDTO.setTrangthai(0);
			thanhtoanDTO.setUsercreate(account.get("username").toString());
			thanhtoanDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			ThanhToanDAO hosothanhtoanDao=new ThanhToanDAO(daoFactory);
			System.out.println("thanhtoanDTO.getId():"+thanhtoanDTO.getId());
			System.out.println("thanhtoanDTO.getDoisoatcuoc_id():"+thanhtoanDTO.getDoisoatcuoc_id());
			if(thanhtoanDTO.getId().isEmpty())
			{
				if(hosothanhtoanDao.findBySoHoSo(thanhtoanDTO.getSohoso())!=null)
				{
					setInputStream("exist");
					return Action.SUCCESS;
				}
			}
			String thanhtoan_id=hosothanhtoanDao.save(thanhtoanDTO);
			if(thanhtoan_id==null) 
				throw new Exception(Constances.MSG_ERROR);
			else
			{
				SuCoDAO sucoDao=new SuCoDAO(daoFactory);
				SuCoDTO sucoDto=null;
				if(thanhtoanDTO.getId().isEmpty()==false)
				{
					// reset su co kenh ve trang thai chua co thanhtoan_id
					List<SuCoDTO> listsuco_old=sucoDao.findSuCoByThanhToanId(thanhtoanDTO.getId());
					System.out.println("Begin reset thanhtoan_id");
					if(listsuco_old!=null && listsuco_old.size()>0)
					{
						for(int i=0;i<listsuco_old.size();i++)
						{
							sucoDto=listsuco_old.get(i);
							// update su co
							sucoDto.setThanhtoan_id("0");
							Long thoidiembatdau=DateUtils.parseDate(sucoDto.getThoidiembatdau(), "dd/MM/yyyy HH:mm:ss").getTime();
							Long thoidiemketthuc=DateUtils.parseDate(sucoDto.getThoidiemketthuc(), "dd/MM/yyyy HH:mm:ss").getTime();
							sucoDto.setThoidiembatdau(thoidiembatdau.toString());
							sucoDto.setThoidiemketthuc(thoidiemketthuc.toString());
							sucoDao.save(sucoDto);
						}
					}
					System.out.println("end reset thanhtoan_id");
				}
				// save su co kenh
				System.out.println("begin save su co");
				if(suco_ids!= null && suco_ids.length > 0) {
					// update thanhtoan_id cho suco
					for(int i=0;i<suco_ids.length;i++)
					{
						System.out.println("suco_id:"+suco_ids[i]);
						sucoDto=sucoDao.findById(suco_ids[i]);
						if(sucoDto!=null)
						{
							// update su co
							sucoDto.setThanhtoan_id(thanhtoan_id);
							Long thoidiembatdau=DateUtils.parseDate(sucoDto.getThoidiembatdau(), "dd/MM/yyyy HH:mm:ss").getTime();
							Long thoidiemketthuc=DateUtils.parseDate(sucoDto.getThoidiemketthuc(), "dd/MM/yyyy HH:mm:ss").getTime();
							sucoDto.setThoidiembatdau(thoidiembatdau.toString());
							sucoDto.setThoidiemketthuc(thoidiemketthuc.toString());
							sucoDao.save(sucoDto); 
						}
					}
				}
			}
			setInputStream("OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			//session.setAttribute("message", e.getMessage());
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	// load ho so thanh toan
	public String ajLoadThanhToan() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			String sSearch = request.getParameter("sSearch").trim();
			System.out.println("sSearch:"+sSearch);
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
			ThanhToanDAO thanhtoanDao = new ThanhToanDAO(daoFactory);
			System.out.println("conditions="+conditions);
			List<Map<String, Object>> items = thanhtoanDao.search(iDisplayStart, iDisplayLength, conditions);
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
		
	public String delete() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				ThanhToanDAO hosothanhtoanDao = new ThanhToanDAO(daoFactory);
				hosothanhtoanDao.deleteByIds(ids);
				
				
				SuCoDAO sucoDao=new SuCoDAO(daoFactory);
				SuCoDTO sucoDto=null;
				for(int i=0;i<ids.length;i++)
				{
					// cap nhat su co 
					// reset thanhtoan_id
					List<SuCoDTO> listsuco_old=sucoDao.findSuCoByThanhToanId(ids[i]);
					System.out.println("Begin reset thanhtoan_id - delete sucokenh");
					if(listsuco_old!=null && listsuco_old.size()>0)
					{
						for(int j=0;j<listsuco_old.size();j++)
						{
							sucoDto=listsuco_old.get(j);
							// update su co
							sucoDto.setThanhtoan_id("0");
							Long thoidiembatdau=DateUtils.parseDate(sucoDto.getThoidiembatdau(), "dd/MM/yyyy HH:mm:ss").getTime();
							Long thoidiemketthuc=DateUtils.parseDate(sucoDto.getThoidiemketthuc(), "dd/MM/yyyy HH:mm:ss").getTime();
							sucoDto.setThoidiembatdau(thoidiembatdau.toString());
							sucoDto.setThoidiemketthuc(thoidiemketthuc.toString());
							sucoDao.save(sucoDto);
						}
					}
				}
				
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		System.out.println("Begin get detail");
		ThanhToanDAO hosothanhtoanDao = new ThanhToanDAO(daoFactory);
		if(id == null) return Action.ERROR;
		detail = hosothanhtoanDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		System.out.println("end get detail");
		return Action.SUCCESS;
	}
	
}