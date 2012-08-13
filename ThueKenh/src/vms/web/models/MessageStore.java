package vms.web.models;

public class MessageStore {
	
	private Integer type = null;
	private String message = "";
	
	public MessageStore() {
		
		//setMessage("Hello Struts User");
	}

	public String getMessage() {

		return message;
	}

	public void setMessage(String message) {

		this.message = message;
	}

	public Integer getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	
}