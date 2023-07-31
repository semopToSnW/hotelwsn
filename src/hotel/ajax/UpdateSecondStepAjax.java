package hotel.ajax;

import hotel.action.PageMoveAction;
import hotel.dao.DeleteDao;
import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.vo.DayRoom;
import hotel.vo.Rank;
import hotel.vo.Room;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateSecondStepAjax extends ActionSupport {
	private Logger log = Logger.getLogger(UpdateSecondStepAjax.class);
	private ArrayList<Room> roomList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private int roomListSize;
	private InsertDao idao = new InsertDao();
	private DeleteDao ddao = new DeleteDao();	
	private ArrayList<Rank> rankList;
	private ArrayList<DayRoom> dayroomList;
	private SelectDao sdao = new SelectDao();
	private String type;
	
	public String updateSecondStep(){
		//rankList insert
			log.info("settingSecondStep매서드입니다.");	
			log.info(rankList);
			roomList= (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
			log.info(roomList);
			ddao.deleteRank(roomList);
			idao.insertRank(rankList);
			log.info(((User)session.get("loginedUser")).getCompany_id());
			sdao.getRanksByCompany_id(((User)session.get("loginedUser")).getCompany_id());
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

	public ArrayList<Rank> getRankList() {
		return rankList;
	}

	public void setRankList(ArrayList<Rank> rankList) {
		this.rankList = rankList;
	}

	public ArrayList<DayRoom> getDayroomList() {
		return dayroomList;
	}

	public void setDayroomList(ArrayList<DayRoom> dayroomList) {
		this.dayroomList = dayroomList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
