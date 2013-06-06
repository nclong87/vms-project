package vms.web.actions;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import vms.db.dao.DaoFactory;
import vms.db.dao.DoiTacDAO;
import vms.db.dao.ReportDAO;
import vms.utils.Constances;
import vms.utils.DateUtils;
import vms.utils.NumberUtil;
import vms.utils.VMSUtil;
import vms.utils.XMLUtil;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class ReportAction implements Preparable {
	private DaoFactory daoFactory;
	private HttpServletRequest request;
	private HttpSession session;
	private Map<String,Object> account;
	private InputStream inputStream;
	private LinkedHashMap<String, Object> jsonData;
	private Map<String,Object> json;
	private String id;
	private String[] ids;
	private List<Map<String,Object>> doiTacs;
	
	private InputStream excelStream;
	private String filename = "";
	public ReportAction( DaoFactory factory) {
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
	
	public String execute() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		DoiTacDAO doitacDao = new DoiTacDAO(daoFactory);
		doiTacs = doitacDao.findAll();
		return Action.SUCCESS;
	}
	public String test() throws Exception {
		/*if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}*/
		File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/giamtrumatlienlac.xml")); 
		String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/giamtrumatlienlac.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		System.out.println("transformedString = "+transformedString);
		FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		//filename = "Test_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpTuyenKenhChuaBanGiao() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		//File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/TuyenKenhChuaBanGiao.xml")); 
		//String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		ReportDAO dao = new ReportDAO(daoFactory);
		String doitac_id = request.getParameter("doitac_id");
		String xmlData = dao.reportTuyenKenhChuaBanGiao(doitac_id);
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/tuyenkenhchuabangiao.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "TuyenKenhChuaBanGiao_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpHopDongChuaThanhToan() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		//File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/hopdongchuathanhtoan.xml")); 
		//String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		ReportDAO dao = new ReportDAO(daoFactory);
		String doitac_id = request.getParameter("doitac_id");
		Calendar calendar = Calendar.getInstance();
		Date current = new Date(calendar.getTimeInMillis());
		calendar.add(Calendar.MONTH, -1);
		Date previous = new Date(calendar.getTimeInMillis());
		//Date ngayhieuluc = DateUtils.parseToSQLDate("01/11/2012", "dd/MM/yyyy");
		String xmlData = dao.reportHopDongChuaThanhToan(doitac_id, previous, current);
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/hopdongchuathanhtoan.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "HopDongChuaThanhToan_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpKenhDaBanGiaoNhungChuaCoHopDong() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		//File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/tuyenkenhdabangiaonhungchuacohopdong.xml")); 
		//String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		ReportDAO dao = new ReportDAO(daoFactory);
		String doitac_id = request.getParameter("doitac_id");
		String xmlData = dao.reportTuyenKenhDaBanGiaoChuaHopDong(doitac_id);
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/tuyenkenhdabangiaonhungchuacohopdong.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "CacKenhDaBanGiaoNhungChuaCoHopDong_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpTienThueKenhPhatSinh() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/tienthuekenhphatsinh.xml")); 
		String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/tienthuekenhphatsinh.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "TienThueKenhPhatSinh_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpDoiSoatCuoc() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		//File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/doisoatcuoc.xml")); 
		//String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		ReportDAO dao = new ReportDAO(daoFactory);
		String doisoatcuoc_id = request.getParameter("id");
		String xmlData = dao.reportXuatDoiSoatCuoc(doisoatcuoc_id);
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/doisoatcuoc.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), xmlData,"UTF-8");
		setExcelStream(transformedString);
		filename = "DOISOATCUOC_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpGiamTruMatLienLac() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		//File fileXmlData = new File(ServletActionContext.getServletContext().getRealPath("files/templates/giamtrumll.xml")); 
		//String xmlData = FileUtils.readFileToString(fileXmlData, "UTF-8");
		String doitac_id = request.getParameter("doitac");
		int thang = NumberUtil.parseInt(request.getParameter("thang"));
		int nam = NumberUtil.parseInt(request.getParameter("nam"));
		long[] time = DateUtils.getTime(thang, nam);
		System.out.println("from ="+time[0]);
		System.out.println("end ="+time[1]);
		ReportDAO dao = new ReportDAO(daoFactory);
		String xmlData = dao.reportGiamTruMatLienLac(doitac_id, time[0], time[1]);
		
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/giamtrumatlienlac.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "GiamTruMatLienLac_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpSuCoTheoThoiGian() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		String doitac_id = request.getParameter("doitac");
		int thang = NumberUtil.parseInt(request.getParameter("thang"));
		int nam = NumberUtil.parseInt(request.getParameter("nam"));
		long[] time = DateUtils.getTime(thang, nam);
		System.out.println("from ="+time[0]);
		System.out.println("end ="+time[1]);
		ReportDAO dao = new ReportDAO(daoFactory);
		String xmlData = dao.reportSuCoTheoThoiGian(doitac_id, time[0], time[1]);
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/sucotheothoigian.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "SuCoTheoThoiGian_"+System.currentTimeMillis()+".xls";
		return Action.SUCCESS;
	}
	
	public String rpISO() throws Exception {
		if(account == null) {
			session.setAttribute("URL", VMSUtil.getFullURL(request));
			return "login_page";
		}
		int thang = NumberUtil.parseInt(request.getParameter("thang"));
		int nam = NumberUtil.parseInt(request.getParameter("nam"));
		ReportDAO dao = new ReportDAO(daoFactory);
		String xmlData = dao.reportIsoTruyenDanKenhThue(thang, nam);
		//FileUtils.writeStringToFile(new File("D:\\log.txt"), xmlData,"UTF-8");
		String pathXslTemplate = ServletActionContext.getServletContext().getRealPath("files/templates/baocaotruyendankenhthue.xsl");
		String transformedString = XMLUtil.transformStringXML_FileXSL(xmlData, pathXslTemplate);
		//System.out.println("transformedString = "+transformedString);
		FileUtils.writeStringToFile(new File("D:\\log.txt"), transformedString,"UTF-8");
		setExcelStream(transformedString);
		filename = "BaoCaoTruyenDanKenhThue_"+System.currentTimeMillis()+".xls";
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
	
	public InputStream getExcelStream() {
		return excelStream;
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
	public Map<String, Object> getJson() {
		return json;
	}
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
	public String getFilename() {
		return filename;
	}
	public List<Map<String, Object>> getDoiTacs() {
		return doiTacs;
	}
	public void setDoiTacs(List<Map<String, Object>> doiTacs) {
		this.doiTacs = doiTacs;
	}
	
}