package hotel.action;

import hotel.dao.SelectDao;
import hotel.vo.Graph_DateAmount;

import hotel.vo.User;

import java.awt.List;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class GraphAction extends ActionSupport{
			
	private Logger log = Logger.getLogger(GraphAction.class);
	//세션
	private Map<String, Object> session = ActionContext.getContext().getSession();
	//VO
	private User user;
	
	private SelectDao sdao = new SelectDao();
	
	
	private String time;
	private String hotel_id;
	private String hotel_name;
	
	private int tempint;								
	private String tempDate;
	private String tempRoomType;
	
	private String dateKey;
	
	private ArrayList<Graph_DateAmount> assignList;
	private HashMap<String,Integer> tempMap;
	
	//1	 
	private ArrayList<Integer> hotelRemain;	
	
	//2
	private ArrayList<String> hotelSold_RoomType;
	private ArrayList<ArrayList<Integer>> hotelSold_RoomType_Amount;
	
	//3
	private ArrayList<String> tourSold_OTA;
	private ArrayList<ArrayList<String>> tourSold_OTA_RoomType;
	private ArrayList<ArrayList<ArrayList<Integer>>> tourSold_OTA_RoomType_Amount;
	
	private ArrayList<Integer> tempAmountArray1;
	private ArrayList<ArrayList<Integer>> tempAmountArray2;
	private ArrayList<ArrayList<ArrayList<Integer>>> tempAmountArray3;
	
	private ArrayList<String> tempTypeArray1;
	private ArrayList<ArrayList<String>> tempTypeArray2;
	
	//4
	private ArrayList<Integer> tourRemain;
		
	public String callRoomGraphData(){		
		int thisYear = 2015;
		// 호텔 아아디 가져와서
		hotel_id = ((User)session.get("loginedUser")).getCompany_id();
		// 일단 hotel_Remain 부터
		
		// 전체 Amount 
		//int RoomTotalAmount = sdao.getRoomTotalAmount(hotel_id);
				 
		// 각각 날짜의 호텔 할당량에서 호텔 판매량을 뺀다.
		assignList = new ArrayList<Graph_DateAmount>();
		assignList = (ArrayList<Graph_DateAmount>) sdao.getRoomAssignAmount(hotel_id);
		
		// ArrayList에서 하나씩 추출해서 HashMap으로 넘김
		HashMap<String,Integer> assignMap = new HashMap<String,Integer>();
		for(int i = 0 ; i<assignList.size() ; i++){
			assignMap.put(assignList.get(i).getDate(),assignList.get(i).getAmount());
		}
		
		//날짜를 일치시키기
		Calendar countday = Calendar.getInstance();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy.MM.dd");
		
		countday.set(Calendar.YEAR, 2015);
		countday.set(thisYear, 11, 31);					// 년도는 요청하는 값으로 바꿔서 그해의 마지막날까지의 일수를 구한다.
		
		int maxday = (countday.get(Calendar.DAY_OF_YEAR));
		
		hotelRemain = new ArrayList<Integer>();
		for(int i = 1 ; i<= maxday ; i++){
			countday.set(Calendar.DAY_OF_YEAR, i);
			tempDate = simpleDate.format(countday.getTime());			
			
			//String assignKey = tempDate.substring(5);
			if (assignMap.containsKey(tempDate)){			// 날짜가 존재하면
				tempint = assignMap.get(tempDate);
			}else{
				tempint = 0;
			}				
			hotelRemain.add(i-1, tempint);						
		}
		log.info("hotelRemain >> "+hotelRemain);
		
		// 여기까지 그 해의 최대 날짜 수를 세어서 ArrayList에 넣는다, 
			// 데이터가 없는 날짜는 0을, 데이터가 있는 날은 그 수량을
		
		//----------------------------여기까지 1 단락
		hotelSold_RoomType_Amount = new ArrayList<ArrayList<Integer>>();
		//해당 호텔의 방 타입 가져오기
		hotelSold_RoomType = (ArrayList<String>) sdao.getHotelSold_RoomType(hotel_id);
		
		//타입 갯수 만큼 수량 가져오기
		for(int i = 0 ; i < hotelSold_RoomType.size() ; i++){		// 객실 타입 만큼 반복
			String tempRoomType = hotelSold_RoomType.get(i);
			assignList = new ArrayList<Graph_DateAmount>();			
			// 방 타입별로 수량을 가져옴
			assignList = (ArrayList<Graph_DateAmount>) sdao.getHotelSold_RoomType_Amount(hotel_id,tempRoomType);
			
			// ArrayList에서 하나씩 추출해서 HashMap으로 넘김
			HashMap<String,Integer> soldMap = new HashMap<String,Integer>();
			for(int k = 0 ; k<assignList.size() ; k++){
				soldMap.put(assignList.get(k).getDate(),assignList.get(k).getAmount());
			}
			log.info(soldMap);			//<< 해쉬맵에 잘 넣음			
			
			ArrayList<Integer> hotelsold = new ArrayList<Integer>();
			log.info(maxday);
			for(int j = 0 ; j< maxday ; j++){						//수량만큼 즉, 1년치를 반복
				countday.set(Calendar.DAY_OF_YEAR, j+1);
				tempDate = simpleDate.format(countday.getTime());					
				
				if (soldMap.containsKey(tempDate)){			// 날짜가 존재하면
					tempint = soldMap.get(tempDate);
					log.info("날짜 존재 "+tempint);
				}else{
					tempint = 0;
				}
				System.out.print(j+" ");
				hotelsold.add(j, tempint);						
			}
			log.info(hotelsold);
			hotelSold_RoomType_Amount.add(i, hotelsold);
		}
		
		log.info(hotelSold_RoomType_Amount.get(0));
		
		//---------------------------------- 여기까지 2단락
		
		//호텔의 제휴 여행사 가져오기
		tourSold_OTA = (ArrayList<String>) sdao.getTourSold_OTA(hotel_id);
		
		//호텔의 제휴 여행사별, 타입별, 1년치 판매 수량 가져오기
		String tempOtaName;
		tempAmountArray3 = new ArrayList<ArrayList<ArrayList<Integer>>>();
		for(int i = 0 ; i < tourSold_OTA.size() ; i ++){			
			tempOtaName = tourSold_OTA.get(i);
			
			tempAmountArray2 = new ArrayList<ArrayList<Integer>>();
			for(int j = 0 ; j < hotelSold_RoomType.size() ; j++ ){				
				tempRoomType = hotelSold_RoomType.get(j);
				assignList = new ArrayList<Graph_DateAmount>();
				
				assignList = (ArrayList<Graph_DateAmount>)sdao.getTourSold_OTA_RoomType_Amount(hotel_id,tempOtaName,tempRoomType);
				//해쉬맵으로 넘기기
				tempMap = new HashMap<String,Integer>();
				for(int k = 0 ; k<assignList.size() ; k++){
					tempMap.put(assignList.get(k).getDate(),assignList.get(k).getAmount());
				}							
				tempAmountArray1 = new ArrayList<Integer>();
				for(int o = 0 ; o < maxday ; o++){					
					countday.set(Calendar.DAY_OF_YEAR, o+1);
					tempDate = simpleDate.format(countday.getTime());
					//dateKey = tempDate.substring(5);
					if (tempMap.containsKey(tempDate)){			// 날짜가 존재하면
						tempint = tempMap.get(tempDate);
					}else{
						tempint = 0;
					}				
					tempAmountArray1.add(o, tempint);
				}
				tempAmountArray2.add(j, tempAmountArray1);
			}
			tempAmountArray3.add(i, tempAmountArray2);			
		}
		tourSold_OTA_RoomType_Amount = tempAmountArray3; // 대입
		
		tempTypeArray2 = new ArrayList<ArrayList<String>>();
		for(int i = 0 ; i < tourSold_OTA.size() ; i ++){
			tempTypeArray1 = new ArrayList<String>();
			for(int j = 0 ; j < hotelSold_RoomType.size() ; j++ ){
				tempTypeArray1.add(j, hotelSold_RoomType.get(j));
			}
			tempTypeArray2.add(i, tempTypeArray1);
		}
		tourSold_OTA_RoomType = tempTypeArray2;
		
		//-----------------------여기까지 3단락
		
		//해당 호텔의 여행사할당중 팔지못하고 남긴 수량
		assignList = new ArrayList<Graph_DateAmount>();
		assignList = (ArrayList<Graph_DateAmount>) sdao.getTourRemain(hotel_id);
		tempMap = new HashMap<String,Integer>();
		
		for (int i = 0 ; i < assignList.size() ; i++){
			tempMap.put(assignList.get(i).getDate(),assignList.get(i).getAmount());
		}
		tourRemain = new ArrayList<Integer>();
		for(int j = 0 ; j< maxday ; j++){
			countday.set(Calendar.DAY_OF_YEAR, j+1);
			tempDate = simpleDate.format(countday.getTime());				
			
			if (tempMap.containsKey(tempDate)){			// 날짜가 존재하면
				tempint = tempMap.get(tempDate);
			}else{
				tempint = 0;
			}				
			tourRemain.add(j, tempint);						
		}	
		
		// 자기 호텔 이름 가져오기
		hotel_name  = sdao.getHotel_Name(hotel_id);
		
		
		session.put("loginedHotel_Name", hotel_name);
		session.put("hotelRemain", hotelRemain);
		session.put("hotelSold_RoomType", hotelSold_RoomType);
		session.put("hotelSold_RoomType_Amount", hotelSold_RoomType_Amount);
		session.put("tourSold_OTA", tourSold_OTA);
		session.put("tourSold_OTA_RoomType", tourSold_OTA_RoomType);
		session.put("tourSold_OTA_RoomType_Amount", tourSold_OTA_RoomType_Amount);
		session.put("tourRemain", tourRemain);		
		
		return SUCCESS;	
		
	}
	
	
	
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public SelectDao getSdao() {
		return sdao;
	}

	public void setSdao(SelectDao sdao) {
		this.sdao = sdao;
	}

	




	public Logger getLog() {
		return log;
	}




	public void setLog(Logger log) {
		this.log = log;
	}




	public String getHotel_id() {
		return hotel_id;
	}




	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}




	public int getTempint() {
		return tempint;
	}




	public void setTempint(int tempint) {
		this.tempint = tempint;
	}




	public String getTempDate() {
		return tempDate;
	}




	public void setTempDate(String tempDate) {
		this.tempDate = tempDate;
	}




	public String getTempRoomType() {
		return tempRoomType;
	}




	public void setTempRoomType(String tempRoomType) {
		this.tempRoomType = tempRoomType;
	}




	public String getDateKey() {
		return dateKey;
	}




	public void setDateKey(String dateKey) {
		this.dateKey = dateKey;
	}




	public ArrayList<Graph_DateAmount> getAssignList() {
		return assignList;
	}




	public void setAssignList(ArrayList<Graph_DateAmount> assignList) {
		this.assignList = assignList;
	}




	public HashMap<String, Integer> getTempMap() {
		return tempMap;
	}




	public void setTempMap(HashMap<String, Integer> tempMap) {
		this.tempMap = tempMap;
	}




	public ArrayList<Integer> getHotelRemain() {
		return hotelRemain;
	}




	public void setHotelRemain(ArrayList<Integer> hotelRemain) {
		this.hotelRemain = hotelRemain;
	}




	public ArrayList<String> getHotelSold_RoomType() {
		return hotelSold_RoomType;
	}




	public void setHotelSold_RoomType(ArrayList<String> hotelSold_RoomType) {
		this.hotelSold_RoomType = hotelSold_RoomType;
	}




	public ArrayList<ArrayList<Integer>> getHotelSold_RoomType_Amount() {
		return hotelSold_RoomType_Amount;
	}




	public void setHotelSold_RoomType_Amount(
			ArrayList<ArrayList<Integer>> hotelSold_RoomType_Amount) {
		this.hotelSold_RoomType_Amount = hotelSold_RoomType_Amount;
	}




	public ArrayList<String> getTourSold_OTA() {
		return tourSold_OTA;
	}




	public void setTourSold_OTA(ArrayList<String> tourSold_OTA) {
		this.tourSold_OTA = tourSold_OTA;
	}




	public ArrayList<ArrayList<String>> getTourSold_OTA_RoomType() {
		return tourSold_OTA_RoomType;
	}




	public void setTourSold_OTA_RoomType(
			ArrayList<ArrayList<String>> tourSold_OTA_RoomType) {
		this.tourSold_OTA_RoomType = tourSold_OTA_RoomType;
	}




	public ArrayList<ArrayList<ArrayList<Integer>>> getTourSold_OTA_RoomType_Amount() {
		return tourSold_OTA_RoomType_Amount;
	}




	public void setTourSold_OTA_RoomType_Amount(
			ArrayList<ArrayList<ArrayList<Integer>>> tourSold_OTA_RoomType_Amount) {
		this.tourSold_OTA_RoomType_Amount = tourSold_OTA_RoomType_Amount;
	}




	public ArrayList<Integer> getTempAmountArray1() {
		return tempAmountArray1;
	}




	public void setTempAmountArray1(ArrayList<Integer> tempAmountArray1) {
		this.tempAmountArray1 = tempAmountArray1;
	}




	public ArrayList<ArrayList<Integer>> getTempAmountArray2() {
		return tempAmountArray2;
	}




	public void setTempAmountArray2(ArrayList<ArrayList<Integer>> tempAmountArray2) {
		this.tempAmountArray2 = tempAmountArray2;
	}




	public ArrayList<ArrayList<ArrayList<Integer>>> getTempAmountArray3() {
		return tempAmountArray3;
	}




	public void setTempAmountArray3(
			ArrayList<ArrayList<ArrayList<Integer>>> tempAmountArray3) {
		this.tempAmountArray3 = tempAmountArray3;
	}




	public ArrayList<String> getTempTypeArray1() {
		return tempTypeArray1;
	}




	public void setTempTypeArray1(ArrayList<String> tempTypeArray1) {
		this.tempTypeArray1 = tempTypeArray1;
	}




	public ArrayList<ArrayList<String>> getTempTypeArray2() {
		return tempTypeArray2;
	}




	public void setTempTypeArray2(ArrayList<ArrayList<String>> tempTypeArray2) {
		this.tempTypeArray2 = tempTypeArray2;
	}




	public ArrayList<Integer> getTourRemain() {
		return tourRemain;
	}




	public void setTourRemain(ArrayList<Integer> tourRemain) {
		this.tourRemain = tourRemain;
	}	
	
	
	
	
	
	
	
}
