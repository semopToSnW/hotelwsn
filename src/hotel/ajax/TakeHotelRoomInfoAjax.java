package hotel.ajax;

import hotel.common.CalendarTool;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.DayRoom;
import hotel.vo.Hotels;
import hotel.vo.RoomAmount;
import hotel.vo.RoomSoldAmount;
import hotel.vo.User;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakeHotelRoomInfoAjax extends ActionSupport {

	
	private Logger log = Logger.getLogger(TakeHotelRoomInfoAjax.class);
	private Map<String, Object> session = ActionContext.getContext().getSession();
	
	private SelectDao sdao = new SelectDao();
	private UpdateDao udao = new UpdateDao();
	
	private ArrayList<Hotels> hotels;
	private ArrayList<DayRoom> dayRoomList;
	private ArrayList<String> dateList;
	private String date;
	private ArrayList<String> types;
	private CalendarTool cal = new CalendarTool();
	
	public String takeHotelRoomInfo() {	
		log.info("takeHotelRoomInfo 시작");
		log.info(((User)session.get("loginedUser")).getCompany_id());
		log.info(types);
		log.info(date);
		/*	
		 jsp에 가지고 들어갈 것 들 dateList, dayRoomList, hotels
		*/
		//dateList 셋팅
		if(date!=null){
			dateList = new ArrayList<String>();
			SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
			Date d = null;
			try {
				d = dateFormat.parse(date);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if(d.compareTo(new Date())==-1){
				d= new Date();
			}
			for(int i=0; i<14; i++){
				Calendar cal2 = Calendar.getInstance();
				cal2.setTime(d);
				cal2.add(Calendar.DATE, i);
				String dateString = dateFormat.format(cal2.getTime());
				log.info(dateString);
				dateList.add(dateString);
			}
		}else{
			dateList = new ArrayList<String>();
			for(int i=0; i<14; i++){
				Calendar cal2 = Calendar.getInstance();
				cal2.add(Calendar.DATE, i);
				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
				String dateString = dateFormat.format(cal2.getTime());
				dateList.add(dateString);
			}
		}
		//hotels 셋팅
		hotels = (ArrayList<Hotels>) sdao.getHotels(((User)session.get("loginedUser")).getCompany_id());
		//dayRoom 셋팅
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("hotels", hotels);
		source.put("date", dateList.get(0));
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		log.info("호텔 룸아이디 : "+hotels);
		log.info(source);
		dayRoomList = (ArrayList<DayRoom>) sdao.getHotelsDayRooms(source);
		log.info(hotels);
		log.info(date);
		log.info(dateList.get(0));
		log.info("dayRoomList 사이즈"+dayRoomList.size());
		for(DayRoom d : dayRoomList){
			log.info(d);
		}
		log.info("takeHotelRoomInfo 끝");
		return SUCCESS;
	}
	
	public ArrayList<Hotels> getHotels() {
		return hotels;
	}

	public void setHotels(ArrayList<Hotels> hotels) {
		this.hotels = hotels;
	}

	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}

	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}

	public ArrayList<String> getDateList() {
		return dateList;
	}

	public void setDateList(ArrayList<String> dateList) {
		this.dateList = dateList;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public CalendarTool getCal() {
		return cal;
	}

	public void setCal(CalendarTool cal) {
		this.cal = cal;
	}

	public ArrayList<String> getTypes() {
		return types;
	}

	public void setTypes(ArrayList<String> types) {
		this.types = types;
	}
	
}
