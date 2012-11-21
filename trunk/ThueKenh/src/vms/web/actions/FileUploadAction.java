package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.LinkedHashMap;

import org.apache.commons.io.FileUtils;

import vms.db.dao.DaoFactory;
import vms.utils.StringUtil;
import vms.utils.VMSUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class FileUploadAction implements Preparable {
	//private DaoFactory daoFactory;
	//private HttpServletRequest request;
	//private HttpSession session;
	//private Map<String,Object> account;
	
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData = new LinkedHashMap<String, Object>();
	
	private String id;
	private File uploadFile;
    private String uploadFileFileName;
    private long fileSize;
	public FileUploadAction( DaoFactory factory) {
		//daoFactory = factory;
	}
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		//request = ServletActionContext.getRequest();
		//session = request.getSession();
		//account = (Map<String, Object>) session.getAttribute(Constances.SESS_USERLOGIN);
	}
	
	public String doUpload() throws Exception {
		try {
			if(uploadFile == null) 
				throw new Exception("UPLOAD_FAILED");
			System.out.println("Begin upload");
	        //this.fileSize = uploadFile.length();
			String filename = System.currentTimeMillis()+"_"+StringUtil.getUnsignedString(uploadFileFileName);
	        System.out.println("file = "+VMSUtil.getUploadFolder()+filename);
	        // write file to local file system or to database as blob
	        File newFile = new File(VMSUtil.getUploadFolder()+filename);
	        FileUtils.copyFile(uploadFile, newFile);
	        jsonData.put("type", "OK");
	        LinkedHashMap<String, Object> data = new LinkedHashMap<String, Object>();
	        data.put("filename", uploadFileFileName);
	        data.put("filepath", filename);
	        data.put("filesize", uploadFile.length());
	        jsonData.put("data", data);
	       
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			jsonData.put("type", "ERROR");
			jsonData.put("data", e.getMessage());
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public File getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getUploadFileFileName() {
		return uploadFileFileName;
	}
	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	
	
	
}