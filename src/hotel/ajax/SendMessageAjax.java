package hotel.ajax;

import hotel.dao.InsertDao;
import hotel.vo.Message;
import hotel.vo.User;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class SendMessageAjax extends ActionSupport {

	Logger log = Logger.getLogger(SendMessageAjax.class);
	private File upload;
	private String uploadFileName;
	private String uploadContentType;
	private Message message;
	private InsertDao idao = new InsertDao();
	private Map<String, Object> session =ActionContext.getContext().getSession();
	public String sendMessage() throws Exception{
		message.setFrom(((User)session.get("loginedUser")).getCompany_id());
		log.info(message);
		if(upload!= null) {
			message.setFileName(uploadFileName);
			message.setContentType(uploadContentType);
			FileInputStream inputStream = new FileInputStream(upload);
			byte[] buffer = new byte[inputStream.available()];
			inputStream.read(buffer);
			message.setFile(buffer);
			inputStream.close();
		}
		idao.sendMessage(message);
		
		return SUCCESS;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public Message getMessage() {
		return message;
	}

	public void setMessage(Message message) {
		this.message = message;
	}
	
	
}
