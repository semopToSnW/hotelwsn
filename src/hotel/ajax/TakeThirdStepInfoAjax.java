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
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakeThirdStepInfoAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(TakeThirdStepInfoAjax.class);
	private int month;
	private int year;
	private int date;
	private int firstDay;
	private int lastDate;
	private int currMonth;
	private ArrayList<Rank> rankList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao();
	private ArrayList<Room> roomList;
	private ArrayList<String> hotelRankType;
	private ArrayList<DayRoom> dayRoomList;
	private String isMonthMove="false";
	
	public String takeThirdStepInfo(){
		if(currMonth!=0){
			isMonthMove="true";
		}
		takeCalendar();
		takeRanksAndRooms();
		log.info(rankList);
		log.info(currMonth);
		log.info(month);
		return SUCCESS;
	}
	
	private void takeCalendar(){
		Date d = new Date ();
		Calendar c = Calendar.getInstance ( );
		if(isMonthMove.equals("false") || month==currMonth){
			month=c.get(Calendar.MONTH)+1;
			year=c.get(Calendar.YEAR);
			date=c.get(Calendar.DAY_OF_MONTH);
			currMonth=month;
			log.info(currMonth);
		}
		c.set(year, month-1, 1);
		firstDay=c.get(Calendar.DAY_OF_WEEK);
		lastDate = c.getActualMaximum(Calendar.DATE);
		log.info("년 : "+year+"  월 :  "+month+"  일 :  "+date +"firstDate"+firstDay+"lastDate"+lastDate);
	}
	
	private void takeRanksAndRooms(){
		log.info(((User)session.get("loginedUser")).getCompany_id());
		hotelRankType=(ArrayList<String>) sdao.getHotelRanksNumber(((User)session.get("loginedUser")).getCompany_id());
		rankList = (ArrayList<Rank>) sdao.getRanksByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		Map<String, Object> source= new HashMap<String, Object>();
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		if(month<10){
			source.put("month", "0"+month);
		}else{
			source.put("month", month);
		}
		source.put("year", year);
		log.info(month);
		log.info("year : "+year);
		log.info(((User)session.get("loginedUser")).getCompany_id());
		dayRoomList = (ArrayList<DayRoom>) sdao.getDayRoomsDatesAndTypesByCompany_idAndMonth(source);
		log.info(dayRoomList);
		log.info(rankList);
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


	public ArrayList<Rank> getRankList() {
		return rankList;
	}


	public void setRankList(ArrayList<Rank> rankList) {
		this.rankList = rankList;
	}


	public ArrayList<Room> getRoomList() {
		return roomList;
	}


	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}


	public ArrayList<String> getHotelRankType() {
		return hotelRankType;
	}


	public void setHotelRankType(ArrayList<String> hotelRankType) {
		this.hotelRankType = hotelRankType;
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

	public String getIsMonthMove() {
		return isMonthMove;
	}

	public void setIsMonthMove(String isMonthMove) {
		this.isMonthMove = isMonthMove;
	}
}
