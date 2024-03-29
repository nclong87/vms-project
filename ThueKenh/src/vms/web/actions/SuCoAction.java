package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONValue;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.LoaiGiaoTiepDao;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.SuCoDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dto.LoaiGiaoTiepDTO;
import vms.db.dto.SuCoDTO;
import vms.db.dto.TuyenKenh;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;
import vms.web.models.FN_FIND_SUCO;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
public class SuCoAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	
	private String form_data;
	private String id;
	private String[] ids;
	private Map<String,Object> detail;
	private String tungay;
	private String denngay;
	private String[] phulucids;
	private List<Map<String,Object>> doiTacDTOs;
	private String[] fields;
	private String[] fieldNames;
	private String filename = "";
	private InputStream excelStream;
	
	
	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
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
	public String[] getPhulucids() {
		return phulucids;
	}
	public void setPhulucids(String[] phulucids) {
		this.phulucids = phulucids;
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
	private SuCoDTO sucoDTO;
	private LinkedHashMap<String, Object> jsonData;
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	public SuCoDTO getSucoDTO() {
		return sucoDTO;
	}
	public void setSucoDTO(SuCoDTO sucoDTO) {
		this.sucoDTO = sucoDTO;
	}
	
	public String getTungay() {
		return tungay;
	}
	public void setTungay(String tungay) {
		this.tungay = tungay;
	}
	public String getDenngay() {
		return denngay;
	}
	public void setDenngay(String denngay) {
		this.denngay = denngay;
	}
	public SuCoAction( DaoFactory factory) {
		daoFactory = factory;
	}
	public InputStream getInputStream() {
		
		return inputStream;
	}
	public void setInputStream(String str) {
		
		try {
			this.inputStream =  new ByteArrayInputStream( str.getBytes("UTF-8") );
		} catch (UnsupportedEncodingException e) {			
			log("ERROR :" + e.getMessage());
		}
	}
	
	public InputStream getExcelStream() {
		return excelStream;
	}

	public void setExcelStream(String str) {
		try {
			this.excelStream =  new ByteArrayInputStream( str.getBytes("UTF-8") );
		} catch (UnsupportedEncodingException e) {			
			log("ERROR :" + e.getMessage());
		}
	}

	public List<Map<String,Object>> getDoiTacDTOs() {
		return doiTacDTOs;
	}
	public void setDoiTacDTOs(List<Map<String,Object>> doiTacDTOs) {
		this.doiTacDTOs = doiTacDTOs;
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
		if(menus == null || menus.contains(Constances.QUAN_LY_SUCOKENH) == false) {
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
		log("SuCoAction.execute");
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		DoiTacDAO doiTacDAO = new DoiTacDAO(daoFactory);
		doiTacDTOs = doiTacDAO.findAll();
		return Action.SUCCESS;
	}
	
	//load form
	public String form() {
		log("SuCoAction.form");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			if(permission == false) return "error_permission";
			form_data = "";
			if(id != null && id.isEmpty()==false) {
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				sucoDTO = sucoDao.findById(id);
				Map<String,String> map = sucoDTO.getMap();
				form_data = JSONValue.toJSONString(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Action.ERROR;
		}
		return Action.SUCCESS;
	}
	
	// save su co
	public String doSave() {
		log("SuCoAction.doSave");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				return "login_page";
			}
			// validation
			Date dateThoiDiemBatDau = DateUtils.parseDate(sucoDTO.getThoidiembatdau(), "dd/MM/yyyy HH:mm:ss");
			if(dateThoiDiemBatDau == null) throw new Exception("ERROR_FORMAT_BEGIN");
			java.sql.Date sqlDateThoiDiemBatDau= DateUtils.convertToSQLDate(dateThoiDiemBatDau);
			
			long thoidiembatdau=dateThoiDiemBatDau.getTime();
			Date dateThoiDiemKetThuc = DateUtils.parseDate(sucoDTO.getThoidiemketthuc(), "dd/MM/yyyy HH:mm:ss");
			if(dateThoiDiemKetThuc == null) throw new Exception("ERROR_FORMAT_END");
			
			long thoidiemketthuc=dateThoiDiemKetThuc.getTime();
			if( sucoDTO.getId().isEmpty())
			{
				Long ngayhientai=Calendar.getInstance().getTime().getTime();
				if(thoidiembatdau>ngayhientai || thoidiemketthuc>ngayhientai)
				{
					setInputStream("ngayhientai");
					return Action.SUCCESS;
				}
			}
			if(thoidiembatdau>thoidiemketthuc) // thoi diem bat dau lon hon thoi diem ket thuc
			{
				setInputStream("Date");
				return Action.SUCCESS;
			}
			TuyenkenhDao tuyenkenhDao=new TuyenkenhDao(daoFactory);
			TuyenKenh tuyenkenhDto=tuyenkenhDao.findById(sucoDTO.getTuyenkenh_id());
			if(tuyenkenhDto==null)
			{
				setInputStream("TuyenKenhNotExist");
				return Action.SUCCESS;
			}    
			SuCoDAO sucoDao=new SuCoDAO(daoFactory);
			LoaiGiaoTiepDao giaotiepDao=new LoaiGiaoTiepDao(daoFactory);
			LoaiGiaoTiepDTO giaotiepDto=giaotiepDao.get(tuyenkenhDto.getGiaotiep_id());
			log("loai giao tiep:"+giaotiepDto.getMa());
			float thoigianmatll= (float)Math.round(((float)(thoidiemketthuc-thoidiembatdau)/(60000))*100)/100;
			sucoDTO.setThoigianmllchuagiamtru(thoigianmatll);
			log("thoi gian mat lien lac before:"+thoigianmatll);
			if(giaotiepDto.getMa().equals("GE")==true || giaotiepDto.getMa().equals("FE")==true)
			{
				log("loai giao tiep la GE");
				int sodu=(int)thoigianmatll%60;
				log("so du ="+sodu);
				log("ket qua so chia:"+(int)thoigianmatll/60);
				if(sodu!=0)
				{
					if(sodu<30)
					{
						thoigianmatll=60*(int)(thoigianmatll/60);
					}
					else
					{
						if(thoigianmatll<=60)
							thoigianmatll=60;
						else
							thoigianmatll=60*(int)(thoigianmatll/60)+60;
					}
				}
				else 
				{
					thoigianmatll=60*(int)(thoigianmatll/60);
				}
			}
			else
			{
				log("loai giao tiep khong la GE hoac FE");
				if(thoigianmatll<30)
					thoigianmatll=0;
				else if(thoigianmatll>=30 && thoigianmatll<60)
					thoigianmatll=60;
			}
			log("thoi gian mat lien lac after:"+thoigianmatll);
			sucoDTO.setThoidiembatdau(String.valueOf(thoidiembatdau));	
			sucoDTO.setThoidiemketthuc(String.valueOf(thoidiemketthuc));
			sucoDTO.setThoigianmll(thoigianmatll);
			sucoDTO.setUsercreate(account.get("username").toString());
			sucoDTO.setTimecreate(DateUtils.getCurrentDateSQL());
			if(sucoDTO.getId().isEmpty())
				sucoDTO.setBienbanvanhanh_id("0");
			if(sucoDTO.getId().isEmpty() || sucoDTO.getThanhtoan_id().isEmpty())
				sucoDTO.setThanhtoan_id("0");
			log("thanhtoan:"+sucoDTO.getThanhtoan_id());
			log("bienbanvanhanh:"+sucoDTO.getBienbanvanhanh_id());
			PhuLucDAO phuLucDAO = new PhuLucDAO(daoFactory);
			log("sqlDateThoiDiemBatDau:"+sqlDateThoiDiemBatDau);
			log("sucoDTO.getTuyenkenh_id():"+sucoDTO.getTuyenkenh_id());
			double giamtrumatll=0;
			Map<String, Object> mapPhuluc = phuLucDAO.findPhuLucCoHieuLuc(sucoDTO.getTuyenkenh_id(), sqlDateThoiDiemBatDau);
			if(mapPhuluc == null) {
				sucoDTO.setGiamtrumll(0);
			} else {
				log("setPhuluc_id:"+mapPhuluc.get("id").toString());
				sucoDTO.setPhuluc_id(mapPhuluc.get("id").toString());	
				// tinh giam tru mat lien lac
				System.out.println("cuocthang:"+mapPhuluc.get("thanhtien").toString());
				Calendar cal = Calendar.getInstance();
				cal.setTime(dateThoiDiemBatDau);
				int dayOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				System.out.println("day of month:"+dayOfMonth);
				System.out.println("thanh tien:"+mapPhuluc.get("thanhtien"));
				System.out.println("thoi gian mat lien lac:"+thoigianmatll);
				giamtrumatll=Math.floor((thoigianmatll*NumberUtil.parseLong(mapPhuluc.get("thanhtien").toString()))/(dayOfMonth*24*60));
				System.out.println("giam tru mat ll:"+giamtrumatll);
				sucoDTO.setGiamtrumll(giamtrumatll);
				sucoDTO.setCuocthang(NumberUtil.parseLong(mapPhuluc.get("thanhtien").toString()));
			}
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			map.put("thoigianmll",thoigianmatll);
			map.put("giamtrumll", giamtrumatll);
			if(mapPhuluc!=null)
				map.put("cuocthang",NumberUtil.parseLong(mapPhuluc.get("thanhtien").toString()));
			else
				map.put("cuocthang", 0);
 			String id=sucoDao.save(sucoDTO);
			if(id==null) throw new Exception(Constances.MSG_ERROR);
			setInputStream("OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			//session.setAttribute("message", e.getMessage());
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	// load su co
	public String ajLoadSuCo() {
		//log("SuCoAction.ajLoadSuCo");
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
			session.setAttribute("sucokenh_conditions", conditions);
			SuCoDAO sucoDao = new SuCoDAO(daoFactory);
			List<Map<String,Object>> lstSuCo = sucoDao.findSuCo(iDisplayStart, iDisplayLength+1, conditions);
			int iTotalRecords = lstSuCo.size();
			if(iTotalRecords > iDisplayLength) {
				lstSuCo.remove(iTotalRecords - 1);
			}
			jsonData = new LinkedHashMap<String, Object>();
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart+iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart+iTotalRecords);
			jsonData.put("aaData", lstSuCo);
			return Action.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			//setInputStream(str)
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	// load su co chưa thuộc biên bản vận hành kênh nào
	public String ajLoadSuCoWithBBVH() {
		//log("SuCoAction.ajLoadSuCoWithBBVH");
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
			conditions.put("bienbanvanhanh_id", "0");
			SuCoDAO sucoDao = new SuCoDAO(daoFactory);
			List<Map<String,Object>> lstSuCo = sucoDao.findSuCo(iDisplayStart, iDisplayLength+1, conditions);
			int iTotalRecords = lstSuCo.size();
			if(iTotalRecords > iDisplayLength) {
				lstSuCo.remove(iTotalRecords - 1);
			}
			jsonData = new LinkedHashMap<String, Object>();
			jsonData.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			jsonData.put("iTotalRecords", iDisplayStart+iTotalRecords);
			jsonData.put("iTotalDisplayRecords", iDisplayStart+iTotalRecords);
			jsonData.put("aaData", lstSuCo);
			return Action.SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			//setInputStream(str)
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
		
	public String delete() {
		log("SuCoAction.delete ");
		try {
			if(account == null) {
				session.setAttribute("URL", VMSUtil.getFullURL(request));
				throw new Exception("END_SESSION");
			}
			if(ids != null && ids.length >0 ) {
				System.out.println(StringUtils.join(ids, ','));
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				sucoDao.deleteByIds(ids);
			}
			setInputStream("OK");
		} catch (Exception e) {
			e.printStackTrace();
			setInputStream(e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String detail() {
		log("SuCoAction.detail");
		SuCoDAO sucoDao = new SuCoDAO(daoFactory);
		if(id == null) return Action.ERROR;
		detail = sucoDao.getDetail(id);
		if(detail == null) return Action.ERROR;
		/*jsonData = new LinkedHashMap<String, Object>();
		jsonData.put("test", "Hello world!");*/
		return Action.SUCCESS;
	}
	
	public String findByBienbanvanhanh() {
		log("SuCoAction.findByBienbanvanhanh");
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("bienbanvanhanh_id", id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				List<Map<String,Object>> list = sucoDao.findSuCo(0, 1000, conditions);
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
	
	public String findBythanhtoan() {
		log("SuCoAction.findBythanhtoan");
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("thanhtoan_id", id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				List<Map<String,Object>> list = sucoDao.findSuCo(0, 1000, conditions);
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
	public String findByDoiSoatCuoc() {
		log("SuCoAction.findByDoiSoatCuoc");
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(id!= null) {
				Map<String, String> conditions = new LinkedHashMap<String, String>();
				conditions.put("doisoatcuoc_id", id);
				SuCoDAO sucoDao = new SuCoDAO(daoFactory);
				List<Map<String,Object>> list = sucoDao.findSuCo(0, 1000, conditions);
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
	public String popupSearchForThanhToan()
	{		
		return Action.SUCCESS;
	}
	
	// load su co
	public String ajLoadSuCoForThanhToan() {
		log("SuCoAction.ajLoadSuCoForThanhToan");
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
			SuCoDAO sucoDao = new SuCoDAO(daoFactory);
			List<FN_FIND_SUCO> lstSuCo = sucoDao.findSuCoforthanhtoan(iDisplayStart, iDisplayLength+1, conditions);
			int iTotalRecords = lstSuCo.size();
			if(iTotalRecords > iDisplayLength) {
				lstSuCo.remove(iTotalRecords - 1);
			}
			jsonData = new LinkedHashMap<String, Object>();
			List<Map<String, String>> items = new ArrayList<Map<String, String>>();
			for(int i=0;i<lstSuCo.size() && i<iDisplayLength;i++) {
				Map<String, String> map = lstSuCo.get(i).getMap();
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
	
	public String doexport() throws Exception {
		log("DeXuatAction.doexport");
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		/*for(int i=0;i<fieldNames.length;i++)
			log("fieldNames[i]:"+fields[i]);*/
		if(fields != null && fields.length >0 && fieldNames!=null && fieldNames.length>0) {
			SuCoDAO sucoDao = new SuCoDAO(daoFactory);
			String xmlData = sucoDao.exportExcel((Map<String, String>) session.getAttribute("sucokenh_conditions"),fields, fieldNames);
			String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/export.xsl");
			String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
			//log("transformedString = "+transformedString);
			//FileUtils.writeStringToFile(new File("D:\\log2.txt"), "Nguyễn Chí Long "+fieldNames[0],"UTF-8");
			setExcelStream(transformedString);
			filename = "SuCoKenh_"+System.currentTimeMillis()+".xls";
		}	
		return Action.SUCCESS;
	}
	
}