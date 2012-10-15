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

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import vms.db.dao.DaoFactory;
import vms.db.dao.SuCoImportDAO;
import vms.db.dao.TuyenkenhDao;
import vms.db.dao.TuyenkenhImportDAO;
import vms.db.dto.SuCoImportDTO;
import vms.db.dto.TuyenKenh;
import vms.db.dto.TuyenKenhImportDTO;
import vms.utils.Constances;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;
import com.smartxls.WorkBook;

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
	}
	
	public String tuyenkenh() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
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
		WorkBook workBook = new WorkBook();
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
			if(filetype.equals("xls")) {  // Excel 2003
				workBook.read(filepath);
			} else {  // Excel 2007
				workBook.readXLSX(filepath);
			}
			int maxrow = workBook.getLastRow();
			System.out.println("maxrow = "+maxrow);
			int max_col = workBook.getLastCol();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i<= max_col; i++) {
				map.put(workBook.getText(0, i), i);
			}
			Integer index;
			List<TuyenKenhImportDTO> list = new ArrayList<TuyenKenhImportDTO>();
			Date date = new Date();
			for(int i=1;i<=maxrow;i++) {
				TuyenKenhImportDTO dto = new TuyenKenhImportDTO();
				dto.setStt(i);
				if( (index = map.get("MADIEMDAU")) != null)
					dto.setMadiemdau(workBook.getText(i, index));
				if( (index = map.get("MADIEMCUOI")) != null)
					dto.setMadiemcuoi(workBook.getText(i, index));
				if( (index = map.get("GIAOTIEP_MA")) != null)
					dto.setGiaotiep_ma(workBook.getText(i, index));
				if( (index = map.get("DUAN_MA")) != null)
					dto.setDuan_ma(workBook.getText(i, index));
				if( (index = map.get("PHONGBAN_MA")) != null)
					dto.setPhongban_ma(workBook.getText(i, index));
				if( (index = map.get("KHUVUC_MA")) != null)
					dto.setKhuvuc_ma(workBook.getText(i, index));
				if( (index = map.get("DUNGLUONG")) != null)
					dto.setDungluong(workBook.getText(i, index));
				if( (index = map.get("SOLUONG")) != null)
					dto.setSoluong(workBook.getText(i, index));
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
			workBook.dispose();
		}
		return Action.SUCCESS;
	}
	
	public String doImportTuyenkenh() {
		jsonData = new LinkedHashMap<String, Object>();
		try {
			if(ids == null || ids.length==0) throw new Exception("ERROR");
			TuyenkenhImportDAO dao = new TuyenkenhImportDAO(daoFactory);
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
		WorkBook workBook = new WorkBook();
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
			if(filetype.equals("xls")) {  // Excel 2003
				workBook.read(filepath);
			} else {  // Excel 2007
				workBook.readXLSX(filepath);
			}
			int maxrow = workBook.getLastRow();
			System.out.println("maxrow = "+maxrow);
			int max_col = workBook.getLastCol();
			Map<String, Integer> map = new LinkedHashMap<String, Integer>();
			for(int i = 0;i<= max_col; i++) {
				map.put(workBook.getText(0, i), i);
			}
			Integer index;
			List<SuCoImportDTO> list = new ArrayList<SuCoImportDTO>();
			TuyenkenhDao tuyenkenhDao = new TuyenkenhDao(daoFactory);
			TuyenKenh tuyenKenh = null;
			for(int i=1;i<=maxrow;i++) {
				SuCoImportDTO dto = new SuCoImportDTO();
				dto.setStt(i);
				if( (index = map.get("MADIEMDAU")) != null)
					dto.setMadiemdau(workBook.getText(i, index));
				if( (index = map.get("MADIEMCUOI")) != null)
					dto.setMadiemcuoi(workBook.getText(i, index));
				if( (index = map.get("DUNGLUONG")) != null)
					dto.setDungluong(workBook.getText(i, index));
				if( (index = map.get("MAGIAOTIEP")) != null)
					dto.setMagiaotiep(workBook.getText(i, index));
				if( (index = map.get("THOIDIEMBATDAU")) != null)
					dto.setThoidiembatdau(workBook.getFormattedText(i, index));
				if( (index = map.get("THOIDIEMKETTHUC")) != null)
					dto.setThoidiemketthuc(workBook.getFormattedText(i, index));
				if( (index = map.get("NGUYENNHAN")) != null)
					dto.setNguyennhan(workBook.getText(i, index));
				if( (index = map.get("PHUONGANXULY")) != null)
					dto.setPhuonganxuly(workBook.getText(i, index));
				if( (index = map.get("NGUOIXACNHAN")) != null)
					dto.setNguoixacnhan(workBook.getText(i, index));
				if((tuyenKenh = tuyenkenhDao.findByKey2(dto.getMadiemdau(), dto.getMadiemcuoi(), dto.getMagiaotiep())) != null) {
					dto.setTuyenkenh_id(tuyenKenh.getId());
				}
				if(	!dto.getThoidiembatdau().isEmpty() &&
					!dto.getThoidiemketthuc().isEmpty()) {
					list.add(dto);
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
			workBook.dispose();
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