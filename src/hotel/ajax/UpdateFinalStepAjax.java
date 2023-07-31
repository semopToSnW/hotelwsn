package hotel.ajax;

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

public class UpdateFinalStepAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(UpdateFinalStepAjax.class);
	private ArrayList<Room> roomList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private int roomListSize;
	private InsertDao idao = new InsertDao();
	private DeleteDao ddao = new DeleteDao();	
	private ArrayList<Rank> rankList;
	private ArrayList<DayRoom> dayRoomList;
	private SelectDao sdao = new SelectDao();
	private String type;
	private int month;
	private int year;
	private int date;
	private int firstDay;
	private int lastDate;
	private int currMonth;
		
	public String updateFinalStep(){
		log.info(dayRoomList);
		log.info("누를 때 month"+month);
		log.info("누를 때 date"+date);
		log.info("누를 때 currMonth"+currMonth);
		roomList=(ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		Map<String, Object> source= new HashMap<String, Object>();
		source.put("month", month);
		source.put("roomList", roomList);
		ddao.deleteDayroom(source);
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
		log.info(tempDayRoomList.size());
		log.info(tempDayRoomList);
		if(tempDayRoomList.size()!=0){
			idao.insertDayroom(tempDayRoomList);
		}
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

	public int getCurrMonth() {
		return currMonth;
	}

	public void setCurrMonth(int currMonth) {
		this.currMonth = currMonth;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getDate() {
		return date;
	}

	public void setDate(int date) {
		this.date = date;
	}

	public int getFirstDay() {
		return firstDay;
	}

	public void setFirstDay(int firstDay) {
		this.firstDay = firstDay;
	}

	public int getLastDate() {
		return lastDate;
	}

	public void setLastDate(int lastDate) {
		this.lastDate = lastDate;
	}

	
}
