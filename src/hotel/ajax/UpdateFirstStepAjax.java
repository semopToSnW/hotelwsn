package hotel.ajax;

import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;

import hotel.action.PageMoveAction;
import hotel.dao.DeleteDao;
import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.vo.Rank;
import hotel.vo.Room;
import hotel.vo.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateFirstStepAjax extends ActionSupport {
	private Logger log = Logger.getLogger(UpdateFirstStepAjax.class);
	private ArrayList<Room> roomList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private int roomListSize;
	private InsertDao idao = new InsertDao();
	private DeleteDao ddao = new DeleteDao();	
	
	public String updateFirstStep(){
		//roomList insert
		log.info(roomList);
		roomListSize=roomList.size();
		log.info(roomListSize);
		ddao.deleteRoom(((User)session.get("loginedUser")).getCompany_id());
		idao.insertRoom(roomList);
		log.info(((User)session.get("loginedUser")).getCompany_id());
		return SUCCESS;
	}

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}

	public int getRoomListSize() {
		return roomListSize;
	}

	public void setRoomListSize(int roomListSize) {
		this.roomListSize = roomListSize;
	}
}
