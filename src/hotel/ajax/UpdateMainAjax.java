package hotel.ajax;

import hotel.action.UpdateAction;
import hotel.dao.DeleteDao;
import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.vo.DayRoom;
import hotel.vo.Rank;
import hotel.vo.Room;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateMainAjax extends ActionSupport {
private Logger log = Logger.getLogger(UpdateMainAjax.class);
	
	//변수		
	private SelectDao sdao = new SelectDao();
	private Map<String, Object> session = ActionContext.getContext().getSession();
				
	private List<DayRoom> dayRoomList;
	private List<String> hotelTypeList;
	private List<String> OTAList;	
	private ArrayList<Room> roomList;
	private int year;		// 호텔접속 메인 화면에서 3달의 연도
	private int month;		// 호텔접속 메인 화면에서 요청하는 3달중 첫째 달
	private int max1;		// 호텔접속 메인 화면에서 요청하는 3달중 첫째 달의 마지막 날짜
	private int max2;		// 호텔접속 메인 화면에서 요청하는 3달중 둘째 달의 마지막 날짜
	private int max3;		// 호텔접속 메인 화면에서 요청하는 3달중 첫째 달의 마지막 날짜
	private String hotel_id;
	private String room_type;		// 클라쪽에서 요청시에 정해진 방 타입 & 반환시의 방 타입
	private int page;				// 클라쪽에서 요청한 페이지
	private int date;
	private int firstDay;
	
	
	//생성:재학
	//메인 화면에서 보여줄 3달치의 날짜별 방정보를 반환 + 호텔별로 갖고 있는 타입도 반환
	public String takeSimpleCalendar() throws Exception{
		hotelTypeList = sdao.getHotelType(((User)session.get("loginedUser")).getCompany_id());
		roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());		
		Calendar today = Calendar.getInstance();
		room_type = roomList.get(0).getType();
		date = today.get(Calendar.DATE);
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH)+1;
		firstDay=today.get(Calendar.DAY_OF_WEEK);		
		max1 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max2 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max3 = today.getActualMaximum(Calendar.DATE);			
		log.info(max1+","+max2+","+max3);
		dayRoomList = sdao.getSimpleCarendar(year, month,((User)session.get("loginedUser")).getCompany_id(),room_type);
		log.info("dayRoomList : "+dayRoomList);
		return SUCCESS;
	}
	
	public String pageMoveToNext() throws Exception{
		roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		month=month+3;
		if(month>12){
			year=year+1;
			month=month-12;
		}
		log.info("month :  "+month+"  year :  "+year);
		Calendar today = Calendar.getInstance();
		today.set(Calendar.YEAR, year); 
		today.set(Calendar.MONTH, month-1); 
		max1 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max2 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max3 = today.getActualMaximum(Calendar.DATE);			
		log.info(max1+","+max2+","+max3);
		dayRoomList = sdao.getSimpleCarendar(year, month,((User)session.get("loginedUser")).getCompany_id(),room_type);
		log.info("dayRoomList : "+dayRoomList);
		return SUCCESS;
	}
	
	public String pageMoveToPrev() throws Exception{
		roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		month=month-3;
		if(month<1){
			year=year-1;
			month=month+12;
		}
		log.info("month :  "+month+"  year :  "+year);
		Calendar today = Calendar.getInstance();
		today.set(Calendar.YEAR, year); 
		today.set(Calendar.MONTH, month-1); 
		max1 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max2 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max3 = today.getActualMaximum(Calendar.DATE);			
		log.info(max1+","+max2+","+max3);
		dayRoomList = sdao.getSimpleCarendar(year, month,((User)session.get("loginedUser")).getCompany_id(),room_type);
		log.info("dayRoomList : "+dayRoomList);
		return SUCCESS;
	}
	
	public String selectTypeForSearch() throws Exception{
		Calendar today = Calendar.getInstance();
		today.set(Calendar.YEAR, year); 
		today.set(Calendar.MONTH, month-1); 
		max1 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max2 = today.getActualMaximum(Calendar.DATE);			
		today.add(Calendar.MONTH, 1); 
		max3 = today.getActualMaximum(Calendar.DATE);			
		log.info(max1+","+max2+","+max3);
		roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());	
		dayRoomList = sdao.getSimpleCarendar(year, month,((User)session.get("loginedUser")).getCompany_id(),room_type);
		log.info("dayRoomList : "+dayRoomList);
		return SUCCESS;
	}
	
	
	//생성:재학
	//객실관리 화면 
	public String roomManage() throws Exception{
		//시작날짜가 같이 올 경우도 있지만
		//null일경우에는 현재 날짜를 넣어서
		log.info("roomManage : "+year+month+hotel_id);		
		if (year == 0){										//요청값(날짜)이 없다면 현재 날짜 넣기
			Calendar today = Calendar.getInstance();
			year = today.get(Calendar.YEAR);
			month = today.get(Calendar.MONTH)+1;			
		}
		
		hotelTypeList = sdao.getHotelType(hotel_id);	//일단 호텔에 속해 있는 방의 타입을 가져옴 
		log.info("hotelTypeList : "+hotelTypeList);			
		
		OTAList = sdao.getOTAList(hotel_id);			//호텔과 제휴 맺은 여행사의 리스트
				
		if (room_type == null){								//요청값(방 타입)이 없다면 방 타입중 하나를 넣는다
			room_type = hotelTypeList.get(0);
		}			
		
		return SUCCESS;
	}
	public Logger getLog() {
		return log;
	}
	public void setLog(Logger log) {
		this.log = log;
	}
	public SelectDao getSdao() {
		return sdao;
	}
	public void setSdao(SelectDao sdao) {
		this.sdao = sdao;
	}
	public Map<String, Object> getSession() {
		return session;
	}
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	public List<DayRoom> getDayRoomList() {
		return dayRoomList;
	}
	public void setDayRoomList(List<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}
	public List<String> getHotelTypeList() {
		return hotelTypeList;
	}
	public void setHotelTypeList(List<String> hotelTypeList) {
		this.hotelTypeList = hotelTypeList;
	}
	public List<String> getOTAList() {
		return OTAList;
	}
	public void setOTAList(List<String> oTAList) {
		OTAList = oTAList;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getMax1() {
		return max1;
	}
	public void setMax1(int max1) {
		this.max1 = max1;
	}
	public int getMax2() {
		return max2;
	}
	public void setMax2(int max2) {
		this.max2 = max2;
	}
	public int getMax3() {
		return max3;
	}
	public void setMax3(int max3) {
		this.max3 = max3;
	}
	public String getHotel_id() {
		return hotel_id;
	}
	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
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

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}
	
}
