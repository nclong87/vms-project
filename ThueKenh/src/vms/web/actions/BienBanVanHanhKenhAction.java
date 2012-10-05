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

import vms.db.dao.DaoFactory;
import vms.db.dao.SuCoDAO;
import vms.db.dao.TuyenKenhDeXuatDAO;
import vms.db.dao.VanHanhSuCoKenhDAO;

import vms.db.dao.BienBanVanHanhKenhDAO;
import vms.db.dto.Account;
import vms.db.dto.BienBanVanHanhKenhDTO;
import vms.db.dto.SuCoDTO;
import vms.db.dto.VanHanhSuCoKenhDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class BienBanVanHanhKenhAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Account account;
	private InputStream inputStream;
	
	private String form_data;
	private String id;
	private String[] ids;
	private String[] suco_ids;
	private Map<String,Object> detail;
	
	public String[] getSuco_ids() {
		return suco_ids;
	}
	public void setSuco_ids(String[] suco_ids) {
		this.suco_ids = suco_ids;
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
	private BienBanVanHanhKenhDTO bienbanvhkDto;
	private LinkedHashMap<String, Object> jsonData;
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	
	
	public BienBanVanHanhKenhDTO getBienbanvhkDto() {
		return bienbanvhkDto;
	}
	public void setBienbanvhkDto(BienBanVanHanhKenhDTO bienbanvhkDto) {
		this.bienbanvhkDto = bienbanvhkDto;
	}
	public BienBanVanHanhKenhAction( DaoFactory factory) {
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
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		System.out.println("BienBanVanHanhKenhAction");
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Account) session.getAttribute(Constances.SESS_USERLOGIN);
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
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
				BienBanVanHanhKenhDAO bienbanvhkDao = new BienBanVanHanhKenhDAO(daoFactory);
				bienbanvhkDto = bienbanvhkDao.findById(id);
				System.out.println(bienbanvhkDto.getId());
				Map<String,String> map = bienbanvhkDto.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	// save bien ban van hanh kenh
	public String doSave() {
		System.out.println("Begin save Bienbanvanhanhkenh");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			BienBanVanHanhKenhDAO bienbanvhkDao=new BienBanVanHanhKenhDAO(daoFactory);
			System.out.println("suco_ids:"+suco_ids);
			if(suco_ids!= null && suco_ids.length > 0) {
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				// update bienbanvanhanh_id cho suco
				SuCoDTO sucoDto=null;
				String ids="";
				SuCoDTO lstSuCo[]=new SuCoDTO[suco_ids.length];
				// kiem tra su co da ton tai trong bien ban van hanh nao chua
				for(int i=0;i<suco_ids.length;i++)
				{
					sucoDto=sucoDao.findById(suco_ids[i]);
					if(sucoDto!=null)
					{
						lstSuCo[i]=sucoDto;
						// co bien ban van hanh roi
						System.out.println("sucoDto.getBienbanvanhanh_id()"+sucoDto.getBienbanvanhanh_id());
						if(Integer.parseInt(sucoDto.getBienbanvanhanh_id())!=0 )
						{
							System.out.println("suco_"+i+":"+suco_ids[i]);
							
							if(ids!="")
								ids+=",";
							ids+="{'id':'suco_id_"+suco_ids[i]+"'}";
						}
					}
				}
				if(ids!="")
				{
					setInputStream("["+ids+"]");
					return Action.SUCCESS;
				}
				else
				{
					// save bien ban van hanh kenh
					bienbanvhkDto.setUsercreate(account.getUsername());
					bienbanvhkDto.setTimecreate(DateUtils.getCurrentDateSQL());
					if(bienbanvhkDao.findBySoBienBan(bienbanvhkDto.getSobienban())!=null)
					{
						setInputStream("exist");
						return Action.SUCCESS;
					}
					String id=bienbanvhkDao.save(bienbanvhkDto);
					if(id==null) throw new Exception(Constances.MSG_ERROR);
					
					//update sucokenh
					for(int i=0;i<lstSuCo.length;i++)
					{
						sucoDto=sucoDao.findById(lstSuCo[i].getId());
						if(sucoDto!=null)
						{
							// update su co
							sucoDto.setBienbanvanhanh_id(id);
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
	
	// load bien ban van hanh kenh
	public String ajLoadBienbanvanhanhkenh() {
		try {
			System.out.println("begin ajLoadBienbanvanhanhkenh");
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
			System.out.println("conditions="+conditions);
			BienBanVanHanhKenhDAO bienbanvhkDao = new BienBanVanHanhKenhDAO(daoFactory);
			List<BienBanVanHanhKenhDTO> lstBienbanvhk = bienbanvhkDao.findBienBanVanHanhKenh(iDisplayStart, iDisplayLength+1, conditions);
			int iTotalRecords=lstBienbanvhk.size();
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<lstBienbanvhk.size() && i<iDisplayLength;i++) {
				Map<String, String> map = lstBienbanvhk.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				items.add(map);
			}
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart+iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart+iTotalRecords);
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
				BienBanVanHanhKenhDAO bienbanvhkDao = new BienBanVanHanhKenhDAO(daoFactory);
				bienbanvhkDao.deleteByIds(ids);
				
				
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		BienBanVanHanhKenhDAO bienbanvhkDao = new BienBanVanHanhKenhDAO(daoFactory);
		if(id == null) return Action.ERROR;
		detail = bienbanvhkDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		return Action.SUCCESS;
	}
	
}