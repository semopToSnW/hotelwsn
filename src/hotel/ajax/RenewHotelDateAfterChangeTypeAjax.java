package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.DayRoom;
import hotel.vo.Hotels;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class RenewHotelDateAfterChangeTypeAjax extends ActionSupport {

	private ArrayList<Hotels> hotels;
	private String date;
	private Logger log = Logger.getLogger(RenewHotelDateAfterChangeTypeAjax.class);
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private ArrayList<DayRoom> dayRoomList;
	private int room_id;
	private SelectDao sdao = new SelectDao();
	
	
	public String renewHotelDateAfterChangeType(){
		log.info("date : " + date);
		log.info("room_id : "+room_id);
		Map<String, Object> source = new HashMap<String, Object>();
		Hotels h= new Hotels();
		h.setRoom_id(room_id);
		hotels = new ArrayList<Hotels>();
		hotels.add(h);
		source.put("hotels", hotels);
		source.put("date", date);
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		dayRoomList = (ArrayList<DayRoom>) sdao.getHotelsDayRooms(source);
		log.info("dayRoomList 사이즈 : "+dayRoomList.size());		
		log.info("renewHotelDateAfterChangeType 끝");
		return SUCCESS;
	}


	public ArrayList<Hotels> getHotels() {
		return hotels;
	}


	public void setHotels(ArrayList<Hotels> hotels) {
		this.hotels = hotels;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}


	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}


	public int getRoom_id() {
		return room_id;
	}


	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	
	
}
