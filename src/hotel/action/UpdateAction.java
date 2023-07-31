package hotel.action;

import hotel.dao.DeleteDao;
import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.DayRoom;
import hotel.vo.Rank;
import hotel.vo.Room;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateAction extends ActionSupport{
	
private Logger log = Logger.getLogger(UpdateAction.class);
	
	//변수
	private ArrayList<Room> roomList;
	private ArrayList<Rank> rankList;
	private ArrayList<DayRoom> dayRoomList;
	private int roomListSize;
	private InsertDao idao = new InsertDao();
	private DeleteDao ddao = new DeleteDao();	
	private SelectDao sdao = new SelectDao();
	private UpdateDao udao = new UpdateDao();
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private String type;
	private int month;
	private int date;
	
	public String updateFirstStep(){
		//roomList insert
		log.info(roomList);
		roomListSize=roomList.size();
		log.info(roomListSize);
		ddao.deleteRoom(((User)session.get("loginedUser")).getCompany_id());
		idao.insertRoom(roomList);
		log.info(((User)session.get("loginedUser")).getCompany_id());
		roomList=(ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		return SUCCESS;
	}
	
	public String updateSecondStep(){
		//rankList insert
			log.info("settingSecondStep매서드입니다.");	
			log.info(rankList);
			roomList= (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
			ddao.deleteRank(roomList);
			idao.insertRank(rankList);
			log.info(((User)session.get("loginedUser")).getCompany_id());
			sdao.getRanksByCompany_id(((User)session.get("loginedUser")).getCompany_id());
			
		return SUCCESS;
	}
		
	public String completeInit(){
		//dayRoom insert
			log.info("settingFinalStep매서드입니다.");	
			log.info(dayRoomList);
			roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
			Map<String, Object> source= new HashMap<String, Object>();
			log.info(month);
			source.put("month", month);
			source.put("roomList", roomList);
			ddao.deleteDayroom(source);
			if(dayRoomList!=null){
				ArrayList<DayRoom> tempDayRoomList=  new ArrayList<DayRoom>();
				for(Room room : roomList){
					ArrayList<DayRoom> tempList = new ArrayList<DayRoom>();
					tempList.addAll(dayRoomList);
					for(DayRoom d : tempList){
						if(d.getRank_type()==null)continue;
						DayRoom dr = new DayRoom();
						dr.setDate(d.getDate());
						dr.setRoom_id(room.getId());
						dr.setRank_type(d.getRank_type());
						dr.setHotel_assign(room.getHotel_assign());
						dr.setTour_assign(room.getTour_assign());
						tempDayRoomList.add(dr);
					}
				}
				idao.insertDayroom(tempDayRoomList);
			}
			udao.completeCompanySetting(((User)session.get("loginedUser")).getCompany_id());
		return SUCCESS;
	}

	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}

	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public int getRoomListSize() {
		return roomListSize;
	}

	public void setRoomListSize(int roomListSize) {
		this.roomListSize = roomListSize;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDate() {
		return date;
	}

	public void setDate(int date) {
		this.date = date;
	}
	
}
