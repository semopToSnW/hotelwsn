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
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakePriceInfoAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(TakePriceInfoAjax.class);
	private ArrayList<Room> roomList;
	private ArrayList<Rank> rankList;
	private ArrayList<DayRoom> dayroomList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao();
	private String type;
	
	public String takePriceInfo(){
		log.info(type);
		Map<String, String> source = new HashMap<String, String>();
		log.info(((User)session.get("loginedUser")).getCompany_id());
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		source.put("roomType", type);
		rankList = (ArrayList<Rank>) sdao.getRanksByTypeAndHotelId(source);
		return SUCCESS;
	}

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
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
