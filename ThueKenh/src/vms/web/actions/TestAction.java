package vms.web.actions;

import vms.db.dao.DaoFactory;
import vms.db.dao.VmsgroupDao;
import vms.web.models.MessageStore;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.Preparable;

public class TestAction implements Preparable {
	private DaoFactory daoFactory;

	private MessageStore messageStore;
	public TestAction( DaoFactory factory) {
		daoFactory = factory;
	}
	public String execute() throws Exception {
		
		return Action.SUCCESS;
	}
	
	public String hello() throws Exception {
		VmsgroupDao vmsgroupDao = new VmsgroupDao(daoFactory);
		vmsgroupDao.saveGroupMenus(new String[] {"1","2"}, "3");
		messageStore = new MessageStore() ;
		messageStore.setMessage("Nguyễn Chí Long");
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

}