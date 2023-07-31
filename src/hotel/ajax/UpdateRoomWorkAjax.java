package hotel.ajax;

import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.RoomAmount;
import hotel.vo.RoomSoldAmount;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateRoomWorkAjax extends ActionSupport{
	
	
	private Logger log = Logger.getLogger(UpdateRoomWorkAjax.class);
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao();
	private UpdateDao udao = new UpdateDao();

	private String hotel_id;
	private String room_Type;
	private String time;
			
	private List<String> roomTypeList;					//객실 타입	
	private List<String> OTANameList;					//제휴 여행사 이름 리스트
	private String OTA_Name;							//요청온 여행사 이름
	
	private List<RoomAmount> roomAmount_All;
	private List<RoomAmount> roomAmount_ByType;
	
	private List<RoomSoldAmount> roomSoldAmount_All;
	private List<RoomSoldAmount> roomSoldAmount_ByType;

	private List<RoomSoldAmount> tempAll;
	private List<RoomSoldAmount> tempByType;
	
	//private int[] RoomSoldAmount_EachOTA;
	private List<ArrayList<Integer>> firstArray;
	private List<Integer> secondArray;	
	private List<String> eachOTASoldAmount;
	
	private String dayRoom_id;
	private String onoff;
	private int assign;
	private String divNum;
	private String selectId;
	private RoomAmount roomAmount;
	
	private RoomSoldAmount newRSA;
	
	public String takeHotelManage() throws Exception{	
		log.info("takeHotelManage : "+" "+time+" "+OTA_Name+" "+room_Type);
		//hotel_id = "HC00001";		//<임시 설정
		hotel_id = ((User)session.get("loginedUser")).getCompany_id();		
		//log.info("takeHotelManage : "+hotel_id);
		roomTypeList = sdao.getHotelType(hotel_id);		// 객실 타입 가져오기
		//log.info("takeHotelManage : "+roomTypeList);	
		
		if(room_Type == null){							// 요청의 객실 타입이 null이면 0번째것을 넣기
			room_Type = roomTypeList.get(0);
		}
		//log.info("takeHotelsManage : "+room_Type);
		
		
		//time = "2015-05-09";		//<임시 설정
		int y,m,d;
		Calendar today = Calendar.getInstance();
		if(time == null){								// 요청 받은 날짜가 없으면 현재 날짜로 설정			
			log.info("takeHotelManage 시간 넘겨받지 않음");
			y = today.get(Calendar.YEAR);
			m = today.get(Calendar.MONTH)+1;
			d = today.get(Calendar.DATE);					
			time = (y+"-"+m+"-"+d);
		}else {			
			log.info("takeHotelManage 시간 넘겨받음");
			String[] token = time.split("-");
			y = Integer.parseInt(token[0]);
			m = Integer.parseInt(token[1]);
			d = Integer.parseInt(token[2]);
			log.info(y+m+d);
			
			int ry,rm,rd;
			ry = today.get(Calendar.YEAR);
			rm = today.get(Calendar.MONTH)+1;
			rd = today.get(Calendar.DATE);
			if(y<ry){
				y = ry;
				m = rm;
				d = rd;
			} else if (y==ry&&m<rm){
				y = ry;
				m = rm;
				d = rd;
			} else if (y==ry&&m==rm&&d<rd  ){
				y = ry;
				m = rm;
				d = rd;
			}
			today.set(y, m, d);
			time = (y+"-"+m+"-"+d);
			
		}
		log.info("time : "+time);
		//log.info("takeHotelManage : "+time);
		
		//OTA_Name = "JEJU";			//<임시설정		
		if(OTA_Name == null){						//여행사 요청이 없으면 리스트에 모두 담고
			//log.info("OTA_Name : null");
			OTANameList = sdao.getOTANameList(hotel_id);									
		}else {										//여행사 요청이 있으면 와일트 카드 검색			
			//log.info("OTA_Name : "+OTA_Name);
			OTANameList = sdao.getOTANameListByOTA_Name(hotel_id, OTA_Name);			
		}
		//log.info("takeHotelManage : "+OTANameList);
		
		//객실 총 개수, 잔여 객수 가져오기 방 타입 관계 X   1단락
		roomAmount_All = sdao.getRoomAmount_All(hotel_id, time);
		//----------------
			
		
		
		//----------------
		log.info("takeHotelManage : "+roomAmount_All);
		//객실 총 개수, 잔여 객수 가져오기 방 타입에 따라
		roomAmount_ByType = sdao.getRoomAmount_ByType(hotel_id, time, room_Type);
		log.info("takeHotelManage : "+roomAmount_ByType);
		
		//-----객실의 팔린 개수 알아오기
		
/*		today.add(Calendar.DATE, 100);
		int y = today.get(Calendar.YEAR);
		int m = today.get(Calendar.MONTH);
		int d = today.get(Calendar.DATE);
		String time = (y+"/"+m+"/"+d);*/
		
		
		tempAll = sdao.roomSoldAmount_All(hotel_id, time);
		tempByType = sdao.roomSoldAmount_ByType(hotel_id, time, room_Type);
		roomSoldAmount_All = new ArrayList<RoomSoldAmount>();
		roomSoldAmount_ByType = new ArrayList<RoomSoldAmount>();
		log.info("takeHotelManage : "+tempAll);	
		log.info("takeHotelManage : "+tempByType);	
		for (int v = 0 ; v <14 ; v++ ){			
			int yy = today.get(Calendar.YEAR);
			int mm = today.get(Calendar.MONTH);
			int dd = today.get(Calendar.DATE);
			
			String Smm = Integer.toString(mm);
			if (Smm.length() == 1){
				Smm = "0"+Smm;
			}
			String Sdd = Integer.toString(dd);
			if (Sdd.length() == 1){
				Sdd = "0"+Sdd;
			}
			String tt = (yy+"-"+Smm+"-"+Sdd);
						
			//log.info("takeHotelManage : "+tt);				
			newRSA = new RoomSoldAmount();					
			for (int c = 0 ; c < tempAll.size() ; c++) {
				log.info("takeHotelManage : "+tt+" "+tempAll.get(c).getDate());
				if (tt.equals(tempAll.get(c).getDate())){
					log.info("takeHotelManage : if문안에 들어옴");	
					newRSA = tempAll.get(c);
					break;
				} else {		//해당 날이 없다					
					newRSA.setDate(tt);
					newRSA.setSum_HotelAmount(0);
					newRSA.setSum_OTAAmount(0);
				}				
			}
			roomSoldAmount_All.add(v, newRSA);
			newRSA = new RoomSoldAmount();
			for (int x = 0 ; x < tempByType.size() ; x++) {
				log.info("takeHotelManage : "+tt+" "+tempAll.get(x).getDate());
				if (tt.equals(tempByType.get(x).getDate())){
					log.info("takeHotelManage : if문안에 들어옴");	
					newRSA = tempByType.get(x);
					break;
				} else {		//해당 날이 없다					
					newRSA.setDate(tt);
					newRSA.setSum_HotelAmount(0);
					newRSA.setSum_OTAAmount(0);
				}				
			}
			roomSoldAmount_ByType.add(v, newRSA);				
			today.add(Calendar.DATE, 1);	//하루씩 더하고				
		}				
		log.info("takeHotelManage : "+roomSoldAmount_All);		
		log.info("takeHotelManage : "+roomSoldAmount_ByType);		
				
		firstArray = new ArrayList<ArrayList<Integer>>();
		secondArray = new ArrayList<Integer>();
		eachOTASoldAmount = new ArrayList<String>();
		for (int i = 0 ; i<OTANameList.size() ; i++) {
			String s = "";
			for (int j = 0 ; j<14 ; j++) {					
				//secondArray.add(j, sdao.getRoomSoldAmount_EachOTA(OTANameList.get(i),time,Integer.toString(j),room_Type));	
				//System.out.println(i+" "+j+" "+sdao.getRoomSoldAmount_EachOTA(OTANameList.get(i),time,Integer.toString(j),room_Type));
				s += sdao.getRoomSoldAmount_EachOTA(OTANameList.get(i),time,Integer.toString(j),room_Type)+"/";
			}			
			//firstArray.add(i, (ArrayList<Integer>) secondArray);
			//secondArray.removeAll(secondArray);
			eachOTASoldAmount.add(i, s);
			System.out.println("밖의 for문"+i);
		}		
		
		//System.out.println( "배열안의 배열 1번째 값 : "+ firstArray.get(0).toString() );
		//System.out.println( "배열안의 배열 2번째 값 : "+ firstArray.get(1).toString() );		
		log.info("takeHotelManage끝");							
		return SUCCESS;
	}
	
	public String onoffChangeHotel(){
		log.info("onoffChangeHotel : "+dayRoom_id+onoff);		
		udao.onoffChangeHotel(dayRoom_id,onoff);
		return SUCCESS;
	}
	public String onoffChangeOTA(){
		log.info("onoffChangeOTA : "+dayRoom_id+onoff);		
		udao.onoffChangeOTA(dayRoom_id,onoff);
		return SUCCESS;
	}
	public String AssignChangeHotel(){
		log.info("AssignChangeHotel : "+dayRoom_id+assign);		
		udao.AssignChangeHotel(dayRoom_id,assign);		
		roomAmount = sdao.getOneDayRoom(dayRoom_id);
		log.info("AssignChangeHotel : "+divNum+roomAmount);
		return SUCCESS;
	}
	public String AssignChangeOTA(){
		log.info("AssignChangeOTA : "+dayRoom_id+assign);		
		udao.AssignChangeOTA(dayRoom_id,assign);
		roomAmount = sdao.getOneDayRoom(dayRoom_id);
		log.info("AssignChangeHotel : "+divNum+roomAmount);
		return SUCCESS;
	}
	

	public Logger getLog() {
		return log;
	}

	public void setLog(Logger log) {
		this.log = log;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public SelectDao getSdao() {
		return sdao;
	}

	public void setSdao(SelectDao sdao) {
		this.sdao = sdao;
	}

	public String getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}

	public String getRoom_Type() {
		return room_Type;
	}

	public void setRoom_Type(String room_Type) {
		this.room_Type = room_Type;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public List<String> getRoomTypeList() {
		return roomTypeList;
	}

	public void setRoomTypeList(List<String> roomTypeList) {
		this.roomTypeList = roomTypeList;
	}

	public List<String> getOTANameList() {
		return OTANameList;
	}

	public void setOTANameList(List<String> oTANameList) {
		OTANameList = oTANameList;
	}

	public String getOTA_Name() {
		return OTA_Name;
	}

	public void setOTA_Name(String oTA_Name) {
		OTA_Name = oTA_Name;
	}

	public List<RoomAmount> getRoomAmount_All() {
		return roomAmount_All;
	}

	public void setRoomAmount_All(List<RoomAmount> roomAmount_All) {
		roomAmount_All = roomAmount_All;
	}

	public List<RoomAmount> getRoomAmount_ByType() {
		return roomAmount_ByType;
	}

	public void setRoomAmount_ByType(List<RoomAmount> roomAmount_ByType) {
		roomAmount_ByType = roomAmount_ByType;
	}
/*
	public int[] getRoomSoldAmount_EachOTA() {
		return RoomSoldAmount_EachOTA;
	}

	public void setRoomSoldAmount_EachOTA(int[] roomSoldAmount_EachOTA) {
		RoomSoldAmount_EachOTA = roomSoldAmount_EachOTA;
	}

	public List<Integer> getRoomSoldAmount_EachOTAint() {
		return secondArray;
	}

	public void setRoomSoldAmount_EachOTAint(List<Integer> roomSoldAmount_EachOTAint) {
		secondArray = roomSoldAmount_EachOTAint;
	}*/

	public List<ArrayList<Integer>> getFirstArray() {
		return firstArray;
	}

	public void setFirstArray(List<ArrayList<Integer>> firstArray) {
		this.firstArray = firstArray;
	}

	public List<Integer> getSecondArray() {
		return secondArray;
	}

	public void setSecondArray(List<Integer> secondArray) {
		this.secondArray = secondArray;
	}

	public List<String> getEachOTASoldAmount() {
		return eachOTASoldAmount;
	}

	public void setEachOTASoldAmount(List<String> eachOTASoldAmount) {
		this.eachOTASoldAmount = eachOTASoldAmount;
	}

	public String getDayRoom_id() {
		return dayRoom_id;
	}

	public void setDayRoom_id(String dayRoom_id) {
		this.dayRoom_id = dayRoom_id;
	}

	public String getOnoff() {
		return onoff;
	}

	public void setOnoff(String onoff) {
		this.onoff = onoff;
	}

	public int getAssign() {
		return assign;
	}

	public void setAssign(int assign) {
		this.assign = assign;
	}

	public List<RoomSoldAmount> getRoomSoldAmount_All() {
		return roomSoldAmount_All;
	}

	public void setRoomSoldAmount_All(List<RoomSoldAmount> roomSoldAmount_All) {
		this.roomSoldAmount_All = roomSoldAmount_All;
	}

	public List<RoomSoldAmount> getRoomSoldAmount_ByType() {
		return roomSoldAmount_ByType;
	}

	public void setRoomSoldAmount_ByType(List<RoomSoldAmount> roomSoldAmount_ByType) {
		this.roomSoldAmount_ByType = roomSoldAmount_ByType;
	}

	public String getDivNum() {
		return divNum;
	}

	public void setDivNum(String divNum) {
		this.divNum = divNum;
	}

	public RoomAmount getRoomAmount() {
		return roomAmount;
	}

	public void setRoomAmount(RoomAmount roomAmount) {
		this.roomAmount = roomAmount;
	}

	public String getSelectId() {
		return selectId;
	}

	public void setSelectId(String selectId) {
		this.selectId = selectId;
	}
	
	
	
}
