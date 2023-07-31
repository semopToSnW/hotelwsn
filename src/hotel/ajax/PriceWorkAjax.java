package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.DayRoom;
import hotel.vo.Rank;
import hotel.vo.Room;
import hotel.vo.User;

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

public class PriceWorkAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(PriceWorkAjax.class);
	private int month;
	private int year;
	private int date;
	private int lastDate;
	private String rank_type;
	private int price;
	private String type;
	private int dayOfMonth;
	private String startDate;
	private String endDate;
	
	
	private ArrayList<Room> roomList;
	private ArrayList<DayRoom> dayRoomList;
	private ArrayList<DayRoom> remainDayRoom;
	private ArrayList<Rank> rankList;
	private ArrayList<Object> modifyList;
	private ArrayList<Object> choiceRankSource;
	private ArrayList<Object> changePriceSource;
	private SelectDao sdao = new SelectDao();
	private UpdateDao udao = new UpdateDao();
	private Map<String, Object> session = ActionContext.getContext().getSession();

//페이지 전체 세팅을 위한 값 null이면 sysdate  null이 아니면 사용자지정 날짜 가져온다.
	public String priceWorkInfo(){
		
		Calendar current = Calendar.getInstance();
		
		if (startDate == null) {
			takeCalendar();
/*			takeRank();
			takeRoomAndDayRoom();*/
		}else if (startDate !=null) {
			SimpleDateFormat dateformat1 = new SimpleDateFormat("yyyy-mm-dd");
			
			year = Integer.parseInt(startDate.substring(0, 4));//받아온 startDate를 나눈다.
			month = Integer.parseInt(startDate.substring(5, 7));
			date = Integer.parseInt(startDate.substring(8, 10));
			
			Calendar receiveD =  Calendar.getInstance();
			
			receiveD.set(year, month-1, date);
			
			
			if (receiveD.before(current)|| receiveD.equals(current)) {//현재 날짜보다 전의 날짜 선택or현재날짜선택
				takeCalendar();
				log.info("전의 날짜 선택"+receiveD);
			}else if(receiveD.after(current)) {//현재 날짜보다 후의 날짜 선택
				log.info("후의 날짜 선택"+receiveD);
				
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				Calendar startD = Calendar.getInstance();
				startD.set(year, month-1, date);
				startDate = dateformat.format(startD.getTime());
				startD.add(Calendar.DATE,14);
				endDate = dateformat.format(startD.getTime());

			}
			
		}
		takeRank();
		takeRoomAndDayRoom();
		
		return SUCCESS;
	}
//priceWorkInfo()에서 사용 현재날짜 가져오기
	public void takeCalendar(){
		
		Calendar c = Calendar.getInstance ( );
		
		month=(c.get(Calendar.MONTH)+1);
		
		year=c.get(Calendar.YEAR);
		
		date=c.get(Calendar.DAY_OF_MONTH);
		
		lastDate= c.getActualMaximum(Calendar.DATE);
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		
		Calendar startD = Calendar.getInstance ( );
		startD.set(year, month-1, date);
		startDate = dateformat.format(startD.getTime());
		startD.add(Calendar.DATE,14);
		endDate = dateformat.format(startD.getTime());
		
	}
//priceWorkInfo()에서 사용 호텔이 가진 랭크리스트 가져온다.
	public void takeRank(){
		
		rankList = (ArrayList<Rank>)sdao.takeRank(((User)session.get("loginedUser")).getCompany_id());
	}
	
	
//priceWorkInfo()에서 사용 호텔의 calendar,roomlist, 처음으로 생성된 타입의 방 2주간의 dayroomlist  date 넣기!!!!
	public void takeRoomAndDayRoom(){
		
		//TODO
		Map<String, Object> takeSource = new HashMap<String, Object>();
		takeSource.put("startDate", startDate);
		takeSource.put("endDate", endDate);
		takeSource.put("companyId",((User)session.get("loginedUser")).getCompany_id());
		log.info(takeSource);
		roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		dayRoomList = (ArrayList<DayRoom>) sdao.getdayRoomListFirstType(takeSource);
		remainDayRoom = (ArrayList<DayRoom>)sdao.remainDayRoom(takeSource);
		
		
	}
//jsp에서 타입 버튼을 누르면 잔여객실수가 변한다.	타입리스트도 가져오기
	public String typeRemainSetting(){
		
		year = Integer.parseInt(startDate.substring(0, 4));
		month = Integer.parseInt(startDate.substring(5, 7));
		date = Integer.parseInt(startDate.substring(8, 10));
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		
		Calendar startD = Calendar.getInstance ( );
		startD.set(year, month-1, date);
		startDate = dateformat.format(startD.getTime());
		startD.add(Calendar.DATE,14);
		endDate = dateformat.format(startD.getTime());

		
		Map<String, Object> remainSource = new HashMap<String, Object>();
		remainSource.put("startDate", startDate);
		remainSource.put("endDate", endDate);
		remainSource.put("type", type);
		remainSource.put("companyId",((User)session.get("loginedUser")).getCompany_id());
		
		
		takeRank();
		
		dayRoomList = (ArrayList<DayRoom>) sdao.typeRemainSetting(remainSource);
		
		log.info("버튼누르면 --어케하냐"+dayRoomList.size());
		return SUCCESS;
	}
//수정  호텔의 id,해당날짜,해당타입 정보를 가지고 가격,랭크 수정	
	public String modifyPriceAndRank(){
		log.info(modifyList);
		log.info(modifyList.size());
		int count = -1;
		for (int i = 0; i < modifyList.size(); i++) {
			for (int j = 1; j < 5; j++) {
				count++;
				switch (j){
					case 1 : rank_type = (String) modifyList.get(count);
					System.out.println(rank_type);
							break;
					case 2 : price = Integer.parseInt(modifyList.get(count).toString());
					System.out.println(price);
							break;
					case 3 :startDate = (modifyList.get(count).toString());
					System.out.println(startDate);
							break;
					case 4 :type = (modifyList.get(count).toString());
					System.out.println(type);
							break;
				}
			}
			year = Integer.parseInt(startDate.substring(0, 4));

			month = Integer.parseInt(startDate.substring(5, 7));

			date = Integer.parseInt(startDate.substring(8, 10));

			
			Map<String, Object> updateSource = new HashMap<String, Object>();
			updateSource.put("rankType",rank_type);
			updateSource.put("price", price);
			updateSource.put("year", year);
			updateSource.put("month", month);
			updateSource.put("date", date);
			updateSource.put("type", type);
			updateSource.put("companyId",((User)session.get("loginedUser")).getCompany_id());
			

			udao.modifyPriceAndRank(updateSource);
			
		}
			
		return SUCCESS;	
	}
//랭크 선택하면 가격도 가져와서 화면에 띄우고 업데이트 한다.	
	public String choiceRank(){
		log.info("choice 랭크");
		rank_type = (String) choiceRankSource.get(0);
		startDate = (String) choiceRankSource.get(1);
		type = (String) choiceRankSource.get(2);
		
		year = Integer.parseInt(startDate.substring(0, 4));
		month = Integer.parseInt(startDate.substring(5, 7));
		date = Integer.parseInt(startDate.substring(8, 10));
		
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar startD = Calendar.getInstance ( );
		startD.set(year, month-1, date);
		startDate = dateformat.format(startD.getTime());
		
		
		Map<String, Object> choiceSource = new HashMap<String, Object>();
		choiceSource.put("rankType",rank_type);
		choiceSource.put("type", type);
		choiceSource.put("startDate", startDate);
		choiceSource.put("companyId",((User)session.get("loginedUser")).getCompany_id());
		
		price = sdao.choiceRank(choiceSource);
		
		//업데이트 해줘야 한다.
		Map<String, Object> updateSource = new HashMap<String, Object>();
		updateSource.put("rankType",rank_type);
		updateSource.put("price", price);
		updateSource.put("type", type);
		updateSource.put("startDate", startDate);
		updateSource.put("companyId",((User)session.get("loginedUser")).getCompany_id());
		
		udao.modifyPriceAndRank(updateSource);
		
		return SUCCESS;
	}
//요금수정	
	public String changePrice(){
		log.info(changePriceSource+"changePrice");
		log.info(changePriceSource.get(0));
		startDate = (String) changePriceSource.get(1);
		log.info(startDate);
		year = Integer.parseInt(startDate.substring(0, 4));
		month = Integer.parseInt(startDate.substring(5, 7));
		date = Integer.parseInt(startDate.substring(8, 10));
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar startD = Calendar.getInstance ( );
		startD.set(year, month-1, date);
		startDate = dateformat.format(startD.getTime());
		
		Map<String, Object> updateSource = new HashMap<String, Object>();
		updateSource.put("price", changePriceSource.get(0));
		updateSource.put("type",  changePriceSource.get(2));
		updateSource.put("startDate", startDate);
		updateSource.put("companyId",((User)session.get("loginedUser")).getCompany_id());
		
		log.info(updateSource);
		udao.changePrice(updateSource);
		
		return SUCCESS;
	}
		
		


	
	public ArrayList<Object> getModifyList() {
		return modifyList;
	}

	public void setModifyList(ArrayList<Object> modifyList) {
		this.modifyList = modifyList;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public ArrayList<DayRoom> getRemainDayRoom() {
			return remainDayRoom;
	}

	public void setRemainDayRoom(ArrayList<DayRoom> remainDayRoom) {
			this.remainDayRoom = remainDayRoom;
	}

	public ArrayList<Rank> getRankList() {
			return rankList;
	}

	public void setRankList(ArrayList<Rank> rankList) {
			this.rankList = rankList;
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

	public int getLastDate() {
		return lastDate;
	}

	public void setLastDate(int lastDate) {
		this.lastDate = lastDate;
	}

	public String getRank_type() {
		return rank_type;
	}

	public void setRank_type(String rank_type) {
		this.rank_type = rank_type;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getDayOfMonth() {
		return dayOfMonth;
	}

	public void setDayOfMonth(int dayOfMonth) {
		this.dayOfMonth = dayOfMonth;
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
	public ArrayList<Object> getChoiceRankSource() {
		return choiceRankSource;
	}
	public void setChoiceRankSource(ArrayList<Object> choiceRankSource) {
		this.choiceRankSource = choiceRankSource;
	}
	public ArrayList<Object> getChangePriceSource() {
		return changePriceSource;
	}
	public void setChangePriceSource(ArrayList<Object> changePriceSource) {
		this.changePriceSource = changePriceSource;
	}
	
	
	
	
	
}
