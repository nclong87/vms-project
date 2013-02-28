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

import oracle.sql.DATE;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;

import vms.db.dao.DaoFactory;
import vms.db.dao.DeXuatDao;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.TuyenKenhDeXuatDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.DeXuatDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhDeXuatDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;
import vms.web.models.FIND_DEXUAT;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class DeXuatAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private DeXuatDTO deXuatDTO;
	
	private InputStream inputStream;
	private InputStream excelStream;
	private String filename = "";
	private MessageStore message ;
	private LinkedHashMap<String, Object> jsonData;
	private String form_data;
	
	private List<Map<String,Object>> doiTacDTOs;
	private String id;
	private String[] ids;
	private String[] dexuat_ids;
	private Map<String,Object> detail;
	
	private DeXuatDao deXuatDao;
	private boolean permission = true;

	public DeXuatAction( DaoFactory factory) {
		daoFactory = factory;
		deXuatDao = new DeXuatDao(factory);
	}
	
	private String[] fields;
	private String[] fieldNames;
	
	
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.QUAN_LY_VANBANDEXUAT) == false) {
			permission = false;
		}
	}
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		//DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
		//doiTacDTOs = doiTacDAO.findAll();
		if(permission == false) return "error_permission";
		return Action.SUCCESS;
	}
	
	public String load() {
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
			List<FIND_DEXUAT> list = deXuatDao.search(iDisplayStart, iDisplayLength + 1, conditions);
			int iTotalRecords = list.size();
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<list.size() && i<iDisplayLength;i++) {
				Map<String, String> map = list.get(i).getMap();
				map.put("stt", String.valueOf(i+1));
				items.add(map);
			}
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
			DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
			doiTacDTOs = doiTacDAO.findAll();
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				System.out.println("id=" + id);
				deXuatDTO = deXuatDao.findById(id);
				Map<String,String> map = deXuatDTO.getMap();
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
			deXuatDTO.setUsercreate(account.get("username").toString());
			deXuatDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			deXuatDTO.setNgaydenghibangiao(DateUtils.parseStringDateSQL(deXuatDTO.getNgaydenghibangiao(), "dd/MM/yyyy"));
			deXuatDTO.setNgaygui(DateUtils.parseStringDateSQL(deXuatDTO.getNgaygui(), "dd/MM/yyyy"));
			id = deXuatDao.save(deXuatDTO);
			if(id == null) throw new Exception(Constances.MSG_ERROR);
			System.out.println("dexuat_ids.length" + dexuat_ids.length);
			if(dexuat_ids!= null && dexuat_ids.length > 0) {
				TuyenKenhDeXuatDAO tuyenKenhDeXuatDAO = new TuyenKenhDeXuatDAO(daoFactory);
				tuyenKenhDeXuatDAO.updateDexuatByIds(dexuat_ids, id);
				
				// send sms and email
				TuyenKenhDeXuatDTO tkdxDto=tuyenKenhDeXuatDAO.findById(dexuat_ids[0]);
				if(tkdxDto!=null)
				{
					String content="";
					for(int i=0;i<dexuat_ids.length;i++)
					{
						TuyenkenhDao tkDao=new TuyenkenhDao(daoFactory);
						TuyenKenhDeXuatDTO temptkdxDto=tuyenKenhDeXuatDAO.findById(dexuat_ids[0]);
						if(temptkdxDto!=null)
						{
							if(!content.isEmpty())
								content+=", ";
						}
						content+=temptkdxDto.getTuyenkenh_id();
					}
					VMSUtil.sendMail(daoFactory,tkdxDto.getTuyenkenh_id(), 1, "Danh sách các tuyến kênh đề xuất: " +content);
					VMSUtil.sendSMS(daoFactory, tkdxDto.getTuyenkenh_id(), 1, "Danh sach cac tuyen kenh de xuat: "+content);
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
	
	public String delete() {
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				deXuatDao.deleteByIds(ids);
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
		detail = deXuatDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		return Action.SUCCESS;
	}
	
	public String doexport() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		/*for(int i=0;i<fieldNames.length;i++)
			System.out.println("fieldNames[i]:"+fields[i]);*/
		if(fields != null && fields.length >0 && fieldNames!=null && fieldNames.length>0) {
			DeXuatDao dao = new DeXuatDao(daoFactory);
			String xmlData = dao.exportExcel(fields, fieldNames);
			String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/export.xsl");
			String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
			//System.out.println("transformedString = "+transformedString);
			//FileUtils.writeStringToFile(new File("D:\\log2.txt"), "Nguyễn Chí Long "+fieldNames[0],"UTF-8");
			setExcelStream(transformedString);
			filename = "DanhSachDeXuat_"+System.currentTimeMillis()+".xls";
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
	
	public void setExcelStream(String str) {
		try {
			this.excelStream =  new ByteArrayInputStream( str.getBytes("UTF-8") );
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
	
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public DeXuatDTO getDeXuatDTO() {
		return deXuatDTO;
	}
	public void setDeXuatDTO(DeXuatDTO deXuatDTO) {
		this.deXuatDTO = deXuatDTO;
	}
	
	public String getForm_data() {
		return form_data;
	}
	public void setForm_data(String form_data) {
		this.form_data = form_data;
	}
	public List<Map<String,Object>> getDoiTacDTOs() {
		return doiTacDTOs;
	}
	public void setDoiTacDTOs(List<Map<String,Object>> doiTacDTOs) {
		this.doiTacDTOs = doiTacDTOs;
	}
	public String[] getDexuat_ids() {
		return dexuat_ids;
	}
	public void setDexuat_ids(String[] dexuat_ids) {
		this.dexuat_ids = dexuat_ids;
	}
	public Map<String, Object> getDetail() {
		return detail;
	}
	public void setDetail(Map<String, Object> detail) {
		this.detail = detail;
	}

	public String[] getFields() {
		return fields;
	}

	public void setFields(String[] fields) {
		this.fields = fields;
	}

	public String[] getFieldNames() {
		return fieldNames;
	}

	public void setFieldNames(String[] fieldNames) {
		this.fieldNames = fieldNames;
	}

	public InputStream getExcelStream() {
		return excelStream;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
	
}