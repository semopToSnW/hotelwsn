package hotel.ajax;

import java.util.Map;

import org.apache.log4j.Logger;

import hotel.dao.SelectDao;
import hotel.vo.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakeMessageCountAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(TakeMessageCountAjax.class);
	private int messageCount;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao(); 
	public String takeMessageCount(){
		log.info(((User)session.get("loginedUser")).getCompany_id());
		messageCount = sdao.getMessageCount(((User)session.get("loginedUser")).getCompany_id());
		log.info(messageCount);
		return SUCCESS;
	}

	public int getMessageCount() {
		return messageCount;
	}

	public void setMessageCount(int messageCount) {
		this.messageCount = messageCount;
	}
	
}
