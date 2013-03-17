package vms.web.actions;

import vms.db.dao.DaoFactory;
import vms.db.dao.VmsgroupDao;
import vms.utils.VMSUtil;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class TestAction implements Preparable {
	private DaoFactory daoFactory;
	private String user;
	private String pass;
	private MessageStore messageStore;
	public TestAction( DaoFactory factory) {
		daoFactory = factory;
	}
	public String execute() throws Exception {
		
		return Action.SUCCESS;
	}
	
	public String hello() throws Exception {
		//VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
		//vmsgroupDao.saveGroupMenus(new String[] {"1","2"}, "3");
		System.out.println("user : "+user);
		System.out.println("pass : "+pass);
		messageStore = new MessageStore() ;
		boolean rs = VMSUtil.checkLDAP(pass, pass);
		if(rs == true) {
			messageStore.setMessage("True");
		} else {
			messageStore.setMessage("False");
		}
		return Action.SUCCESS;
	}

	public MessageStore getMessageStore() {
		return messageStore;
	}

	public void setMessageStore(MessageStore messageStore) {
		this.messageStore = messageStore;
	}

	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
}