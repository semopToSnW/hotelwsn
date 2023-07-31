package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.DayRoom;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionSupport;

public class TakeADayRoomInfoAjax extends ActionSupport{

	private Logger log = Logger.getLogger(TakeADayRoomInfoAjax.class);
	private String dayRoomId;
	private SelectDao sdao = new SelectDao();
	private DayRoom dayRoom;
	
	public String takeADayRoomInfo(){
		log.info("ddd");
		dayRoom = sdao.getAdayRoom(dayRoomId);
		log.info(dayRoom);
		return SUCCESS;
	}

	public String getDayRoomId() {
		return dayRoomId;
	}

	public void setDayRoomId(String dayRoomId) {
		this.dayRoomId = dayRoomId;
	}

	public DayRoom getDayRoom() {
		return dayRoom;
	}

	public void setDayRoom(DayRoom dayRoom) {
		this.dayRoom = dayRoom;
	}
	
	
	
}
