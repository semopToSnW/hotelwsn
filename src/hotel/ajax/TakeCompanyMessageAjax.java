package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.Message;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakeCompanyMessageAjax extends ActionSupport {

	private Logger log = Logger.getLogger(TakeMessageCountAjax.class);
	private ArrayList<Message> messageList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao(); 
	public String takeCompanyMessage(){
		log.info("ddd");
		messageList = (ArrayList<Message>) sdao.getCompanyMessages(((User)session.get("loginedUser")).getCompany_id());
		log.info(messageList);
		return SUCCESS;
	}
	public ArrayList<Message> getMessageList() {
		return messageList;
	}
	public void setMessageList(ArrayList<Message> messageList) {
		this.messageList = messageList;
	}
	
}
