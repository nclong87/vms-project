package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import vms.db.dao.ChiTietPhuLucTuyenKenhDAO;
import vms.db.dao.DaoFactory;
import vms.db.dao.PhuLucDAO;
import vms.db.dao.SuCoImportDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dao.TuyenkenhImportDAO;
import vms.db.dto.ChiTietPhuLucTuyenKenhDTO;
import vms.db.dto.SuCoImportDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class ImportAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	
	private InputStream inputStream;
	private String message;
	private LinkedHashMap<String, Object> jsonData;
	
	private File fileupload;
	private String fileuploadFileName;
	private String fileuploadContentType;
	
	private String[] ids;
	private boolean permission = true;

	public ImportAction( DaoFactory factory) {
		daoFactory = factory;
	}
	@SuppressWarnings("unchecked")
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		request = ServletActionContext.getRequest();
		session = request.getSession();
		account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
		List<Integer> menus = (List<Integer>) session.getAttribute(Constances.SESS_MENUIDS);
		if(menus == null || menus.contains(Constances.IMPORT_TUYENKENH) == false) {
			permission = false;
		}
	}
	
	public String tuyenkenh() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		if(permission == false) return "error_permission";
		return Action.SUCCESS;
	}
	public String loadTuyenkenhImport() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			
			TuyenkenhImportDAO dao = new TuyenkenhImportDAO(daoFactory);
			List<Map<String, Object>> items = dao.search(iDisplayStart, iDisplayLength + 1);
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
	public String doUploadTuyenkenh() {
		jsonData = new LinkedHashMap<String, Object>();
		Workbook workBook = null;
		try {
			System.out.println("Begin upload");
			String filetype = StringUtil.getExtension(fileuploadFileName);
			if(filetype.equals("xls") == false && filetype.equals("xlsx") == false)
				throw new Exception("Vui lòng chọn file excel 2003 hay excel 2007!");
			String filename = System.currentTimeMillis()+"_"+StringUtil.getUnsignedString(fileuploadFileName);
			String filepath = VMSUtil.getUploadImportFolder()+filename;
	        // write file to local file system or to database as blob
	        File newFile = new File(filepath);
	        FileUtils.copyFile(fileupload, newFile);
			if(StringUtil.isEmpty(fileuploadFileName)) throw new Exception("File upload bị lỗi.");
			workBook = Workbook.getWorkbook(new File(filepath));
			Sheet sheet = workBook.getSheet(0);
			int maxrow = sheet.getRows();
			System.out.println("maxrow = "+maxrow);
			int max_col = sheet.getColumns();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i< max_col; i++) {
				map.put(sheet.getCell(i, 0).getContents(), i);
			}
			Integer index;
			List<TuyenKenhImportDTO> list = new ArrayList<TuyenKenhImportDTO>();
			Date date = new Date();
			for(int i=1;i<maxrow;i++) {
				TuyenKenhImportDTO dto = new TuyenKenhImportDTO();
				dto.setStt(i);
				if( (index = map.get("MADIEMDAU")) != null)
					dto.setMadiemdau(sheet.getCell(index, i).getContents());
				if( (index = map.get("MADIEMCUOI")) != null)
					dto.setMadiemcuoi(sheet.getCell(index, i).getContents());
				if( (index = map.get("GIAOTIEP_MA")) != null)
					dto.setGiaotiep_ma(sheet.getCell(index, i).getContents());
				if( (index = map.get("DUAN_MA")) != null)
					dto.setDuan_ma(sheet.getCell(index, i).getContents());
				if( (index = map.get("PHONGBAN_MA")) != null)
					dto.setPhongban_ma(sheet.getCell(index, i).getContents());
				if( (index = map.get("DOITAC_MA")) != null)
					dto.setDoitac_ma(sheet.getCell(index, i).getContents());
				if( (index = map.get("DUNGLUONG")) != null)
					dto.setDungluong(sheet.getCell(index, i).getContents());
				if( (index = map.get("SOLUONG")) != null)
					dto.setSoluong(sheet.getCell(index, i).getContents());
				if( (index = map.get("TRANGTHAI")) != null)
					dto.setTrangthai(sheet.getCell(index, i).getContents());
				dto.setDateimport(date);
				if(	!dto.getMadiemdau().isEmpty() &&
					!dto.getMadiemcuoi().isEmpty() &&
					!dto.getGiaotiep_ma().isEmpty()) {
					list.add(dto);
				}
				
			}
			TuyenkenhImportDAO dao = new TuyenkenhImportDAO(daoFactory);
			dao.clear();
			for(int i =0; i < list.size();i++) {
				dao.save(list.get(i));
			}
			newFile.delete();
			jsonData.put("result", "OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		} finally {
			workBook.close();
		}
		return Action.SUCCESS;
	}
	
	public String doImportTuyenkenh() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(ids == null || ids.length==0) throw new Exception("ERROR");
			TuyenkenhImportDAO dao = new TuyenkenhImportDAO(daoFactory);
			System.out.println("BEGIN");
			dao.importTuyenkenh(ids, account.get("username").toString());
			jsonData.put("result", "OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		} 
		return Action.SUCCESS;
	}
	
	public String doDeleteTuyenkenh() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(ids == null || ids.length==0) throw new Exception("ERROR");
			TuyenkenhImportDAO dao = new TuyenkenhImportDAO(daoFactory);
			dao.deleteByIds(ids);
			jsonData.put("result", "OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		} 
		return Action.SUCCESS;
	}
	
	// su co
	
	public String suco() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		return Action.SUCCESS;
	}
	public String doUploadSuCo() {
		jsonData = new LinkedHashMap<String, Object>();
		Workbook workBook = null;
		try {
			System.out.println("Begin upload");
			String filetype = StringUtil.getExtension(fileuploadFileName);
			if(filetype.equals("xls") == false && filetype.equals("xlsx") == false)
				throw new Exception("Vui lòng chọn file excel 2003 hay excel 2007!");
			String filename = System.currentTimeMillis()+"_"+StringUtil.getUnsignedString(fileuploadFileName);
			String filepath = VMSUtil.getUploadImportFolder()+filename;
	        // write file to local file system or to database as blob
	        File newFile = new File(filepath);
	        FileUtils.copyFile(fileupload, newFile);
			if(StringUtil.isEmpty(fileuploadFileName)) throw new Exception("File upload bị lỗi.");
			workBook = Workbook.getWorkbook(new File(filepath));
			Sheet sheet = workBook.getSheet(0);
			int maxrow = sheet.getRows();
			System.out.println("maxrow = "+maxrow);
			int max_col = sheet.getColumns();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i < max_col; i++) {
				map.put(sheet.getCell(i, 0).getContents(), i);
			}
			Integer index;
			List<SuCoImportDTO> list = new ArrayList<SuCoImportDTO>();
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			TuyenKenh tuyenKenh = null;
			String thoidiembatdau="";
			String thoidiemketthuc="";
			for(int i=1;i<maxrow;i++) {
				SuCoImportDTO dto = new SuCoImportDTO();
				dto.setStt(i);
				if( (index = map.get("MADIEMDAU")) != null)
					dto.setMadiemdau(sheet.getCell(index, i).getContents());
				if( (index = map.get("MADIEMCUOI")) != null)
					dto.setMadiemcuoi(sheet.getCell(index, i).getContents());
				if( (index = map.get("DUNGLUONG")) != null)
					dto.setDungluong(sheet.getCell(index, i).getContents());
				if( (index = map.get("MAGIAOTIEP")) != null)
					dto.setMagiaotiep(sheet.getCell(index, i).getContents());
				if( (index = map.get("THOIDIEMBATDAU")) != null)
				{
					thoidiembatdau=sheet.getCell(index, i).getContents();
					dto.setThoidiembatdau(thoidiembatdau);
				}
				if( (index = map.get("THOIDIEMKETTHUC")) != null)
				{
					thoidiemketthuc=sheet.getCell(index, i).getContents();
					dto.setThoidiemketthuc(thoidiemketthuc);
				}
				if( (index = map.get("NGUYENNHAN")) != null)
					dto.setNguyennhan(sheet.getCell(index, i).getContents());
				if( (index = map.get("PHUONGANXULY")) != null)
					dto.setPhuonganxuly(sheet.getCell(index, i).getContents());
				if( (index = map.get("NGUOIXACNHAN")) != null)
					dto.setNguoixacnhan(sheet.getCell(index, i).getContents());
				if( (index = map.get("LOAISUCO")) != null)
				{
					String loaisuco=sheet.getCell(index, i).getContents().trim();
					System.out.println("loaisuco:"+loaisuco);
					if(loaisuco.compareTo("BT")==0)
						dto.setLoaisuco("0");
					else if (loaisuco.compareTo("L")==0)
						dto.setLoaisuco("1");
				}
				if((tuyenKenh = tuyenkenhDao.findByKey2(dto.getMadiemdau(), dto.getMadiemcuoi(), dto.getMagiaotiep(), Integer.parseInt(dto.getDungluong()))) != null) {
					dto.setTuyenkenh_id(tuyenKenh.getId());
				}
				if(	!dto.getThoidiembatdau().isEmpty() &&
					!dto.getThoidiemketthuc().isEmpty()) {
					list.add(dto);
				}
				
				// phuluc_id
				PhuLucDAO phuLucDAO = new PhuLucDAO(daoFactory);
				if(!thoidiembatdau.isEmpty())
				{
					Date dateThoiDiemBatDau = DateUtils.parseDate(thoidiembatdau, "dd/MM/yyyy HH:mm:ss");
					java.sql.Date sqlDateThoiDiemBatDau= DateUtils.convertToSQLDate(dateThoiDiemBatDau);
					System.out.println(thoidiembatdau);
					System.out.println(dto.getTuyenkenh_id());
					Map<String, Object> mapPhuluc = phuLucDAO.findPhuLucCoHieuLuc(dto.getTuyenkenh_id(), sqlDateThoiDiemBatDau);
					if(mapPhuluc != null) {
						dto.setPhuluc_id(mapPhuluc.get("id").toString());
					
						//Tim don gia tuyen kenh
						//ChiTietPhuLucTuyenKenhDAO ptDao=new ChiTietPhuLucTuyenKenhDAO(daoFactory);
						//ChiTietPhuLucTuyenKenhDTO ptDto=ptDao.findByPhuLuc_TuyenKenh(mapPhuluc.get("id").toString(), dto.getTuyenkenh_id());
						long batdau=dateThoiDiemBatDau.getTime();
						long ketthuc=DateUtils.parseDate(thoidiemketthuc, "dd/MM/yyyy HH:mm:ss").getTime();
						float thoigianmatll= (float)Math.round(((float)(ketthuc-batdau)/(60000))*100)/100;
						// tinh giam tru mat lien lac
						if(thoigianmatll<=30)
							dto.setGiamtrumll("0");
						else 
						{
							double giamtrumatll=(thoigianmatll*NumberUtil.parseLong(mapPhuluc.get("dongia").toString()))/(30*24*60);
							dto.setGiamtrumll(String.valueOf(Math.floor(giamtrumatll)));
						}
					}
				}
			}
			SuCoImportDAO dao = new SuCoImportDAO(daoFactory);
			dao.clear();
			for(int i =0; i < list.size();i++) {
				dao.save(list.get(i));
			}
			newFile.delete();
			jsonData.put("result", "OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		} finally {
			workBook.close();
		}
		return Action.SUCCESS;
	}
	public String loadSuCoImport() {
		try {
			//if(account == null) throw new Exception("END_SESSION");
			Integer iDisplayStart = Integer.parseInt(request.getParameter("iDisplayStart"));
			Integer iDisplayLength = Integer.parseInt(request.getParameter("iDisplayLength"));
			
			SuCoImportDAO dao = new SuCoImportDAO(daoFactory);
			List<Map<String, Object>> items = dao.search(iDisplayStart, iDisplayLength + 1);
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
	
	public String doImportSuCo() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(ids == null || ids.length==0) throw new Exception("ERROR");
			SuCoImportDAO dao = new SuCoImportDAO(daoFactory);
			dao.importSuCo(ids, account.get("username").toString());
			jsonData.put("result", "OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		} 
		return Action.SUCCESS;
	}
	
	public String doDeleteSuCo() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(ids == null || ids.length==0) throw new Exception("ERROR");
			SuCoImportDAO dao = new SuCoImportDAO(daoFactory);
			dao.deleteByIds(ids);
			jsonData.put("result", "OK");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonData.put("result", "ERROR");
			jsonData.put("data", e.getMessage());
		} 
		return Action.SUCCESS;
	}
	
	public String error() throws Exception {
		message = (String) session.getAttribute("message");
		session.removeAttribute("message");
		return Action.SUCCESS;
	}
	
	/* Getter and Setter */
	public String getMessage() {
		
		return message;
	}

	public void setMessage(String message) {
	
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
	
	public LinkedHashMap<String, Object> getJsonData() {
		return jsonData;
	}
	public void setJsonData(LinkedHashMap<String, Object> jsonData) {
		this.jsonData = jsonData;
	}
	public File getFileupload() {
		return fileupload;
	}
	public void setFileupload(File fileupload) {
		this.fileupload = fileupload;
	}
	public String getFileuploadFileName() {
		return fileuploadFileName;
	}
	public void setFileuploadFileName(String fileuploadFileName) {
		this.fileuploadFileName = fileuploadFileName;
	}
	public String getFileuploadContentType() {
		return fileuploadContentType;
	}
	public void setFileuploadContentType(String fileuploadContentType) {
		this.fileuploadContentType = fileuploadContentType;
	}
	public String[] getIds() {
		return ids;
	}
	public void setIds(String[] ids) {
		this.ids = ids;
	}
	
}