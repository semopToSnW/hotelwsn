package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.Message;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ShowCompanyMessageContentAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(ShowCompanyMessageContentAjax.class);
	private ArrayList<Message> messageList;
	private String id;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao(); 

	public String showCompanyMessageContent(){
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("from", id);
		source.put("to", ((User)session.get("loginedUser")).getCompany_id());
		messageList = (ArrayList<Message>) sdao.showCompanyMessageContent(source);
		log.info(messageList);
		return SUCCESS;
	}
	public ArrayList<Message> getMessageList() {
		return messageList;
	}
	public void setMessageList(ArrayList<Message> messageList) {
		this.messageList = messageList;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
