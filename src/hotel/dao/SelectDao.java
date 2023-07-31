package hotel.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import hotel.mybatis.MybatisConfig;
import hotel.vo.Company;
import hotel.vo.DayRoom;
import hotel.vo.Graph_DateAmount;
import hotel.vo.Hotels;
import hotel.vo.Image;
import hotel.vo.Message;
import hotel.vo.Product;
import hotel.vo.Rank;
import hotel.vo.Reservation;
import hotel.vo.ReservationInfo2;
import hotel.vo.Room;
import hotel.vo.ReservationInfo;
import hotel.vo.RoomAmount;
import hotel.vo.RoomRank;
import hotel.vo.RoomSoldAmount;
import hotel.vo.User;

public class SelectDao {
	
	private SqlSession sql;
	private Logger log = Logger.getLogger(SelectDao.class);
	
	public User getMember(String id) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		User user = sql.selectOne("hotel.mybatis.selectMapper.getUser", id);
		log.info(user);
		sql.close();
		return user;
	}
	
	public int getUserNumber(String type){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		Integer userNumber = sql.selectOne("hotel.mybatis.selectMapper.getUserNumber", type);
		if(userNumber==null){
			userNumber=1;
		}
		sql.close();
		return userNumber;
	}
	
	public int getCompanyNumber(String type){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		Integer userNumber = sql.selectOne("hotel.mybatis.selectMapper.getCompanyNumber", type);
		if(userNumber==null){
			userNumber=1;
		}
		sql.close();
		return userNumber;
	}

	public List<Company> selectAllTour() {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<Company> list= sql.selectList("hotel.mybatis.selectMapper.selectAllTour");
		sql.close();
		return list;
	}

	public List<Company> searchCompany(Map<String, String> searchSource) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<Company> list= sql.selectList("hotel.mybatis.selectMapper.searchCompany", searchSource);
		sql.close();
		return list;
	}

	public Company searchCompanyById(String id) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		Company company = sql.selectOne("hotel.mybatis.selectMapper.searchCompanyById", id);
		sql.close();
		return company;
	}
	
	public List<Room> getCheckroom(String companyId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<Room> roomList = sql.selectList("hotel.mybatis.selectMapper.searchRoom", companyId);
		log.info(roomList);
		sql.close();
		
		return roomList;	
	}

	public List<Rank> getCheckrank(int roomId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<Rank> rankList = sql.selectList("hotel.mybatis.selectMapper.searchRank", roomId);
		log.info(rankList);
		sql.close();
		
		return rankList;
	}

	public List<DayRoom> getCheckdayroom(int roomId) {
		
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<DayRoom> dayroomlist = sql.selectList("hotel.mybatis.selectMapper.searchDayroom", roomId);
		log.info(dayroomlist);
		sql.close();
		
		return dayroomlist;
	}
	public List<Rank> getRanksByCompany_id(String companyId){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<Rank> rankList = sql.selectList("hotel.mybatis.selectMapper.getRanksByCompany_id", companyId);
		log.info(rankList);
		sql.close();
		return rankList;
	}
	
	public List<Room> getRoomsByCompany_id(String companyId){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<Room> roomList = sql.selectList("hotel.mybatis.selectMapper.getRoomsByCompany_id", companyId);
		log.info(roomList);
		sql.close();
		return roomList;
	}
	public List<String> getHotelRanksNumber(String companyId){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<String> hotelRankType = sql.selectList("hotel.mybatis.selectMapper.getHotelRanksNumber", companyId);
		log.info(hotelRankType);
		sql.close();
		return hotelRankType;
	}
	
	public List<Rank> getRanksByTypeAndHotelId(Map<String, String> source){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info("getRanksByTypeAndHotelId");
		List<Rank> rankList = sql.selectList("hotel.mybatis.selectMapper.getRanksByTypeAndHotelId", source);
		log.info(rankList);
		sql.close();
		return rankList;
	}
	
	public List<DayRoom> getDayRoomsByCompany_idAndMonth(Map<String, Object> source){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<DayRoom> dayRoomList = sql.selectList("hotel.mybatis.selectMapper.getDayRoomsByCompany_idAndMonth", source);
		log.info(dayRoomList);
		sql.close();
		return dayRoomList;
	}
	
	public List<DayRoom> getDayRoomsDatesAndTypesByCompany_idAndMonth(Map<String, Object> source){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<DayRoom> dayRoomList = sql.selectList("hotel.mybatis.selectMapper.getDayRoomsDatesAndTypesByCompany_idAndMonth", source);
		log.info(dayRoomList);
		sql.close();
		return dayRoomList;
	}
	
	public Company selectCompany(String companyId){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		Company company = sql.selectOne("hotel.mybatis.selectMapper.selectCompany", companyId);
		log.info(company);
		sql.close();
		return company;
		
	}
	
	
	
	//생성:재학
	//년도+월+호텔ID를 받아서 3개월분량의 날짜별 방정보를 반환한다
	public List<DayRoom> getSimpleCarendar(int year, int month,String hotel_id,String room_type) {
		HashMap<String,String> map = new HashMap<String, String>();
		String startMonth = Integer.toString(year)+"."+Integer.toString(month)+".01";
		map.put("startMonth", startMonth);
		map.put("hotel_id", hotel_id);
		map.put("room_type", room_type);
		log.info("map"+map);
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<DayRoom> list = sql.selectList("hotel.mybatis.selectMapper.getSimpleCarendar",map);
		sql.close();
		return list;
	}
	//생성:재학
	//호텔에 속한 방의 타입(SINGLE, DOUBLE, TWIN)을 가져옴
	public List<String> getHotelType(String hotel_id){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<String> list = sql.selectList("hotel.mybatis.selectMapper.getRoomType",hotel_id);
		sql.close();
		return list;
	}
	//생성:재학
	//제휴를 맺은 여행사의 리스트를 가져옴
	public List<String> getOTAList(String hotel_id) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<String> list = sql.selectList("hotel.mybatis.selectMapper.getOTAList",hotel_id);
		sql.close();
		return list;
	}

	public DayRoom getAdayRoom(String dayRoomId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		DayRoom dayRoom =  sql.selectOne("hotel.mybatis.selectMapper.getADayRoom",dayRoomId);
		sql.close();
		return dayRoom;
	}

	public List<DayRoom> getDayRoomsByCompany_idAndMonthAndRoomType(Map<String, Object> source) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<DayRoom> dayRoom =  sql.selectList("hotel.mybatis.selectMapper.getDayRoomsByCompany_idAndMonthAndRoomType", source);
		log.info(dayRoom);
		sql.close();
		return dayRoom;
	}
	
	public List<ReservationInfo> getReservationInit(Map<String, Object> source) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<ReservationInfo> dayRoom =  sql.selectList("hotel.mybatis.selectMapper.getReservationInit", source);
		log.info(dayRoom);
		sql.close();
		return dayRoom;
	}
	
	public List<Rank> getRankTypesByCompanyId(String companyId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<Rank> rankList =  sql.selectList("hotel.mybatis.selectMapper.getRankTypesByCompanyId", companyId);
		log.info(rankList);
		sql.close();
		return rankList;
	}
	
	public List<DayRoom> getDayRoomsByDayRoomIds(ArrayList<DayRoom> dayRoomList) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<DayRoom> dayRoom =  sql.selectList("hotel.mybatis.selectMapper.getDayRoomsByDayRoomIds", dayRoomList);
		log.info(dayRoom);
		sql.close();
		return dayRoom;
	}
	
	public ReservationInfo getReservationInitInMain(int dayRoomId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		ReservationInfo dayRoom =  sql.selectOne("hotel.mybatis.selectMapper.getReservationInitInMain", dayRoomId);
		log.info(dayRoom);
		sql.close();
		return dayRoom;
	}
	
	public List<Image> downImage(String product_id) {
		// TODO Auto-generated method stub
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<Image> list = sql.selectList("hotel.mybatis.selectMapper.getImage", product_id);		
		sql.close();		
		return list;
	}

	public List<Product> getProductListByCompany_id(String companyId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<Product> list = sql.selectList("hotel.mybatis.selectMapper.getProduct", companyId);		
		sql.close();	
		return list;
	}

	public Product getProductById(int id) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		Product product = sql.selectOne("hotel.mybatis.selectMapper.getProductById", id);	
		sql.close();	
		return product;
	}
	
	public List<DayRoom> getDayRoomByProduct(Map<String, Object> source) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(sql);
		List<DayRoom> dayRoom =  sql.selectList("hotel.mybatis.selectMapper.getDayRoomByProduct", source);
		log.info(dayRoom);
		sql.close();
		return dayRoom;
	}

	public List<Product> getProductsByCompanyIdAndDate(Map<String, Object> source) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		log.info(source);
		List<Product> list = sql.selectList("hotel.mybatis.selectMapper.getProductsByCompanyIdAndDate", source);		
		log.info(list);
		sql.close();	
		return list;
	}
	public List<RoomRank> getRoomRank(String companyId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		List<RoomRank> list = sql.selectList("hotel.mybatis.selectMapper.getRoomRank", companyId);		
		log.info(list);
		sql.close();	
		return list;
	}
	
		//싱미 / 사용자정의 No:ho-fro-051/ 에이젝스에서 안됌 방예약된  검색합니다. /checkout변수 = 예약일 
		public List<Reservation> reservedDateSearch(String checkout) {
			log.info(checkout);//여기에서 아무 것도 없는 걸로 뜸. 
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			log.info(checkout +"다오225");
			
			List<Reservation> reservation= sql.selectList("hotel.mybatis.selectMapper.reservedDateSearch",checkout);
			log.info(reservation +"다오227");
			sql.close();
			return reservation;	
		}
		//싱미 / 사용자정의 No:ho-fro-051 날짜로 검색합니다.
		public List<Reservation> checkinCheckoutSearch(Map<String, Object> checkSource){
			log.info(checkSource);
			log.info("dao" + "날짜검색" );
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Reservation> reservation =sql.selectList("hotel.mybatis.selectMapper.checkinCheckoutSearch",checkSource);
			log.info("오..셔써...나요?"+reservation);
			sql.close();
			return reservation;
		}
		//예약담당자
		public List<Reservation> goRegPersonSearch(String Reg) {
			log.info(Reg);
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Reservation> reservation = sql.selectList("hotel.mybatis.selectMapper.goRegistPersonSearch", Reg);
			sql.close();
			return reservation;
		}
		public List<Reservation> goResPersonSearch(String Res){
			log.info(Res);
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Reservation> reservation = sql.selectList("hotel.mybatis.selectMapper.goReservationPersonSearch", Res);
			sql.close();
			return reservation;
		}

		public List<Reservation> goStayPersonSearch(String stay) {
			// TODO Auto-generated method stub
			log.info(stay);
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Reservation> reservation = sql.selectList("hotel.mybatis.selectMapper.goStayPersonSearch", stay);
			sql.close();
			return reservation;
		}
		public List<Reservation> getReservation(Map<String, Object> source) {
			// TODO Auto-generated method stub
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Reservation> reservation = sql.selectList("hotel.mybatis.selectMapper.getReservation", source);
			sql.close();
			return reservation;
		}
		public List<ReservationInfo2> getReservationList(String companyId) {
			// TODO Auto-generated method stub
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<ReservationInfo2> reservation = sql.selectList("hotel.mybatis.selectMapper.getReservationList", companyId);
			sql.close();
			return reservation;
		}
		
		
		public List<Reservation> getReservationByDate (String selectedDate) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Reservation> reservation = sql.selectList("hotel.mybatis.selectMapper.getReservationByDate", selectedDate);
			sql.close();
			return reservation;
		}
		
		public int getTotalPage(Map<String, Object> source){
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			Integer result = sql.selectOne("hotel.mybatis.selectMapper.getTotalPage", source);
			sql.close();
			return result;
		}

	
		//생성:재학
		//제휴를 맺은 여행사 Name 의 리스트를 가져옴
		public List<String> getOTANameList(String hotel_id){
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<String> list = sql.selectList("hotel.mybatis.selectMapper.getOTANameList",hotel_id);
			sql.close();
			return list;
		}
		//생성:재학
		//제휴를 맺은 여행사 Name 의 리스트를 회사명 검색을 통해 가져옴
		public List<String> getOTANameListByOTA_Name(String hotel_id, String OTA_Name){
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("hotel_id", hotel_id);		
			map.put("OTA_Name", "%"+OTA_Name+"%");
			log.info(" SelectDao > getOTANameListByOTA_Name : "+map);
			List<String> list = sql.selectList("hotel.mybatis.selectMapper.getOTANameListByOTA_Name",map);
			sql.close();
			return list;
		}
		//생성:재학
		//해당 호텔의 객실 총 개수, 잔여 객수 가져오기 방 타입 관계 X (호텔ID,날짜 필요)
		public List<RoomAmount> getRoomAmount_All(String hotel_id, String time){
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("hotel_id", hotel_id);
			map.put("time", time);
			List<RoomAmount> list = sql.selectList("hotel.mybatis.selectMapper.getRoomAmount_All",map);
			sql.close();		
			return list;
		}
		//생성:재학
		//해당 호텔의 객실  개수, 잔여 객수 가져오기 방 타입에 따라  (호텔ID,날짜,방 타입 필요)
		public List<RoomAmount> getRoomAmount_ByType(String hotel_id, String time, String room_Type){
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("hotel_id", hotel_id);
			map.put("time", time);
			map.put("room_Type", room_Type);		
			List<RoomAmount> list = sql.selectList("hotel.mybatis.selectMapper.getRoomAmount_ByType",map);
			sql.close();		
			return list;
		}
		//생성:재학
		//해당 호텔,특정 날짜, 특정 타입의 객실 판매량
		public int getRoomSoldAmount_EachOTA(String OTAName, String time, String days, String room_Type){
			//log.info("selectDao : "+OTAName+time+days+room_Type);
			int Amount = 0;
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("OTAName", OTAName);
			map.put("time", time);
			map.put("room_Type", room_Type);		
			map.put("days", days);	
			//log.info("selectDao : "+map);
			Amount = sql.selectOne("hotel.mybatis.selectMapper.getRoomSoldAmount_EachOTA",map);
			//log.info("selectDao : "+Amount);
			sql.close();
			return Amount;
		}
		//생성: 재학
		//해당 호텔의 날짜별 판매량 (방 타입 관계 없이)
		public List<RoomSoldAmount> roomSoldAmount_All(String hotel_id, String time) {
			//log.info("selectDao : "+hotel_id+time);
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("hotel_id", hotel_id);
			map.put("time", time);			
			List<RoomSoldAmount> list = sql.selectList("hotel.mybatis.selectMapper.roomSoldAmount_All",map);
			sql.close();		
			return list;		
		}
		//생성: 재학
		//해당 호텔의 날짜별 판매량 (방 타입 관계 있음)
		public List<RoomSoldAmount> roomSoldAmount_ByType(String hotel_id,String time, String room_Type) {
			//log.info("selectDao : "+hotel_id+time+room_Type);
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("hotel_id", hotel_id);
			map.put("time", time);
			map.put("room_Type", room_Type);		
			List<RoomSoldAmount> list = sql.selectList("hotel.mybatis.selectMapper.roomSoldAmount_ByType",map);
			sql.close();		
			return list;		
		}
		//생성:재학
		//해당 날짜 하루분의 dayroom을 반환
		public RoomAmount getOneDayRoom(String dayRoom_id) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			RoomAmount roomAmount = sql.selectOne("hotel.mybatis.selectMapper.getOneDayRoom",dayRoom_id);
			sql.close();
			return roomAmount;		
		}
		
		
		public List<Company> getHotelList(String companyId) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Company> list = sql.selectList("hotel.mybatis.selectMapper.getHotelList", companyId);		
			sql.close();	
			return list;
		}

		public List<DayRoom> getDayRoomsByCompany_idAndDateAndRoomType(
				Map<String, Object> source) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<DayRoom> list = sql.selectList("hotel.mybatis.selectMapper.getDayRoomsByCompany_idAndDateAndRoomType", source);		
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			sql.close();
			return list;
		}

		public List<Hotels> getHotels(String companyId) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Hotels> list = sql.selectList("hotel.mybatis.selectMapper.getHotels", companyId);		
			sql.close();
			log.info(list);
			return list;
		}

		public List<DayRoom> getHotelsDayRooms(Map<String, Object> source) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<DayRoom> list=null;
			try{
			list = sql.selectList("hotel.mybatis.selectMapper.getHotelsDayRooms", source);
			}catch(Exception e){
				e.printStackTrace();
			}
			sql.close();
			log.info(list);
			return list;
		}
		//김명희 객실요금관리 들어가자마자 2주간 dayroom정보가져오기 타입은 싱글로 고정
		public List<DayRoom> getdayRoomListFirstType(Map<String, Object> source) { //
			// TODO Auto-generated method stub
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<DayRoom> roomList = null;
			try{
				roomList = sql.selectList("hotel.mybatis.selectMapper.getdayRoomListFirstType",source);
			}catch(Exception e){
				e.printStackTrace();
			}
			log.info("쿼리 완료 : "+roomList);
			sql.close();
			return roomList;
		}
		//김명희 객실요금관리 2주간 dayroom정보가져오기 잔여객실위해
		public List<DayRoom> remainDayRoom(Map<String, Object> source) {//
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<DayRoom> roomList = sql.selectList("hotel.mybatis.selectMapper.remainDayRoom",source);
			log.info("쿼리 완료 : "+roomList);
			sql.close();
			return roomList;
		}
		//김명희 해당호텔의 rank목록 가져옴
		public List<Rank> takeRank(String companyId) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Rank> rankList = sql.selectList("hotel.mybatis.selectMapper.takeRank",companyId);
			log.info("성공");
			sql.close();
			return rankList;
		}
		//김명희 jsp에서 타입 버튼을 누르면 타입의 잔여객실 가져온다.
		public List<DayRoom> typeRemainSetting(Map<String, Object> remainSource) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<DayRoom> typeRemainList = sql.selectList("hotel.mybatis.selectMapper.typeRemainSetting",remainSource);
			sql.close();
			return typeRemainList;
		}
		//김명희 랭크를 선택하면 요금 업데이트 앤드 화면에 뿌린다.
		public int choiceRank(Map<String, Object> choiceSource) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			int price= sql.selectOne("hotel.mybatis.selectMapper.choiceRank",choiceSource);
			log.info("성공"+price);
			sql.close();
			return price;
		}

		public List<Room> getRoomsByProductId(
				int companyId) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Room> list = sql.selectList("hotel.mybatis.selectMapper.getRoomsByProductId", companyId);
			log.info("성공"+list);
			sql.close();
			return list;
		}

		public int getMessageCount(String companyId) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			int result = sql.selectOne("hotel.mybatis.selectMapper.getMessageCount", companyId);
			log.info("성공"+result);
			sql.close();
			return result;
		}

		public List<Message> getCompanyMessages(String companyId) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Message> list =null;
			try{
				list = sql.selectList("hotel.mybatis.selectMapper.getCompanyMessages", companyId);
			}catch(Exception e){
				e.printStackTrace();
			}
			
			log.info("성공"+list);
			sql.close();
			return list;
		}

		public List<Message> showCompanyMessageContent(
				Map<String, Object> source) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			List<Message> list =null;
			try{
				list= sql.selectList("hotel.mybatis.selectMapper.showCompanyMessageContent",source);
			}catch(Exception e){
				e.printStackTrace();
			}
			log.info(list);
			
			sql.close();
			return list;
		}
		
		//생성:재학(그래프)
				//05/17
				//해당 호텔의 객실 Amount 총량을 가져옴
				public int getRoomTotalAmount(String hotel_id) {
					sql=MybatisConfig.getSqlSessionFactory().openSession();
					int RoomTotalAmount = sql.selectOne("hotel.mybatis.selectMapper.getRoomTotalAmount",hotel_id);
					sql.close();
					return RoomTotalAmount;			
				}
				//생성:재학(그래프)
				//05/17
				//해당 호텔의 객실 Assign 총량을 가져옴
				public List<Graph_DateAmount> getRoomAssignAmount(String hotel_id) {
					sql=MybatisConfig.getSqlSessionFactory().openSession();
					List<Graph_DateAmount> RoomAssignAmount = sql.selectList("hotel.mybatis.selectMapper.getRoomAssignAmount",hotel_id);
					sql.close();
					return RoomAssignAmount;
				}
				//생성:재학(그래프)
				//05/17
				//해당 호텔의 객실 타입을 가져옴
				public List<String> getHotelSold_RoomType(String hotel_id) {
					sql=MybatisConfig.getSqlSessionFactory().openSession();
					List<String> hotelSold_RoomType = sql.selectList("hotel.mybatis.selectMapper.getHotelSold_RoomType",hotel_id);
					sql.close();
					return hotelSold_RoomType;		
				}
				
				//생성:재학(그래프)
				//05/17
				//해당 호텔의 객실 타입데 따른 1년치의 판매수량을 가져옴
				public List<Graph_DateAmount> getHotelSold_RoomType_Amount(String hotel_id, String tempRoomType) {
					HashMap<String,String> map = new HashMap<String, String>();		
					map.put("hotel_id", hotel_id);
					map.put("tempRoomType", tempRoomType);
					sql=MybatisConfig.getSqlSessionFactory().openSession();		
					List<Graph_DateAmount> HotelSold_RoomType_Amount = sql.selectList("hotel.mybatis.selectMapper.getHotelSold_RoomType_Amount",map);
					sql.close();
					return HotelSold_RoomType_Amount;
				}
				
				//생성:재학(그래프)
				//05/17
				//해당 호텔의 제휴 여행사 리스트를 가져옴	
				public List<String> getTourSold_OTA(String hotel_id) {
					sql=MybatisConfig.getSqlSessionFactory().openSession();		
					List<String> tourSold_OTA = sql.selectList("hotel.mybatis.selectMapper.getTourSold_OTA",hotel_id);
					sql.close();
					return tourSold_OTA;
				}
				//생성:재학(그래프)
				public List<Graph_DateAmount> getTourSold_OTA_RoomType_Amount(String hotel_id, String tempOtaName, String tempRoomType) {
					HashMap<String,String> map = new HashMap<String, String>();		
					map.put("hotel_id", hotel_id);
					map.put("tempOtaName", tempOtaName);
					map.put("tempRoomType", tempRoomType);
					sql=MybatisConfig.getSqlSessionFactory().openSession();		
					List<Graph_DateAmount> tourSold_OTA_RoomType_Amount = sql.selectList("hotel.mybatis.selectMapper.getTourSold_OTA_RoomType_Amount",map);
					sql.close();
					return tourSold_OTA_RoomType_Amount;
				}
				//생성:재학(그래프)
				public List<Graph_DateAmount> getTourRemain(String hotel_id) {
					sql=MybatisConfig.getSqlSessionFactory().openSession();		
					List<Graph_DateAmount> tourRemain = sql.selectList("hotel.mybatis.selectMapper.getTourRemain",hotel_id);
					sql.close();
					return tourRemain;		
				}
				//생성:재학(그래프)
				public String getHotel_Name(String hotel_id) {			
					sql=MybatisConfig.getSqlSessionFactory().openSession();		
					String hotel_Name = sql.selectOne("hotel.mybatis.selectMapper.getHotel_Name",hotel_id);
					sql.close();
					return hotel_Name;					
				}	
}
