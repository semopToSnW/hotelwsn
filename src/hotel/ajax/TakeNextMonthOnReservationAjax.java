package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.DayRoom;
import hotel.vo.Room;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakeNextMonthOnReservationAjax extends ActionSupport{

private Logger log = Logger.getLogger(TakeNextMonthOnReservationAjax.class);
	
	private int month;
	private int year;
	private int date;
	private int day;
	private int firstDay;
	private int lastDate;
	private int currMonth;
	private ArrayList<Room> roomList;
	private ArrayList<DayRoom> dayRoomList;
	
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao(); 
	
	public String takeNextMonthOnTourReservation() throws Exception{
		log.info("roomList"+roomList);
		log.info("year : "+year+" month : "+month + " date : "+date);
		log.info("day : "+day+" firstDay : "+firstDay + " lastDate : "+lastDate);
		log.info("currMonth: "+currMonth);
		ArrayList<Room> tempList = new ArrayList<Room>();
		for(Room room : roomList){
			if(!room.getType().equals("false")){
				tempList.add(room);
			}
		}
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		source.put("month", month);
		source.put("types", tempList);
		source.put("year", year);
		log.info("year : "+year+"  month : "+month+"  date : "+date);
		log.info(tempList);
		if(tempList.size()!=0){
			dayRoomList = (ArrayList<DayRoom>) sdao.getDayRoomsByCompany_idAndMonthAndRoomType(source);
		}else dayRoomList=null;
		log.info("dayRoomList"+dayRoomList);
		Calendar cal = Calendar.getInstance();
		date=1;
		cal.set(year, month-1, date);
		lastDate=cal.getActualMaximum(Calendar.DATE);
		firstDay=cal.get(Calendar.DAY_OF_WEEK);
		log.info("TakeNextMonthOnReservationAjax 끝");
		return SUCCESS;
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

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
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

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}

	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}

	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}

	public int getCurrMonth() {
		return currMonth;
	}

	public void setCurrMonth(int currMonth) {
		this.currMonth = currMonth;
	}
	
	
}
