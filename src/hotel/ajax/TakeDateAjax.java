package hotel.ajax;

import org.apache.log4j.Logger;

import hotel.common.CalendarTool;

import com.opensymphony.xwork2.ActionSupport;

public class TakeDateAjax extends ActionSupport {

	private CalendarTool cal;
	private Logger log = Logger.getLogger(TakeDateAjax.class);
	
	public String takeDate(){
		 cal= new CalendarTool();
		 log.info(cal);
		return SUCCESS;
	}

	public CalendarTool getCal() {
		return cal;
	}

	public void setCal(CalendarTool cal) {
		this.cal = cal;
	}
	
}
