package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.Company;
import hotel.vo.Product;
import hotel.vo.Rank;
import hotel.vo.ReservationInfo;
import hotel.vo.Room;
import hotel.vo.RoomRank;
import hotel.vo.User;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ShowReservationFormAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(ShowReservationFormAjax.class);
	private ArrayList<String> dateList;
	private ArrayList<Room> roomList;
	private ArrayList<Rank> rankList;
	private ArrayList<ReservationInfo> reservationInfo;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao();
	private int dayRoomId;
	private String type;
	private String checkIn;
	private String checkOut;
	private Product product;
	private ArrayList<Product> productList;
	private String price;
	private String roomType;
	private ArrayList<RoomRank> roomRankList;
	private String where;
	private Company company;
	
	public String showReservationFormForProduct() throws Exception{
		where="product";
		String id=null;
		if(company!=null){
			log.info("company 있음"+company);
			id=company.getId();
		}else{
			id=((User)session.get("loginedUser")).getCompany_id();
		}
	/*	product = (Product) session.get("product");
		dateList = (ArrayList<String>) session.get("dateList");
		roomList = (ArrayList<Room>) session.get("roomList");*/
		roomRankList = (ArrayList<RoomRank>) sdao.getRoomRank(id);
		roomList = new ArrayList<Room>();
		Room room = new Room();
		room.setType(product.getRoomTypes());
		product = sdao.getProductById(product.getId());
		Map<String, Object> source = new HashMap<String, Object>();
		log.info(product);
		log.info(dateList);
		log.info(id);
		roomList= new ArrayList<Room>();
		roomList.add(room);
		source.put("companyId", id);
		source.put("dateList", dateList);
		source.put("roomList", roomList);
		reservationInfo = (ArrayList<ReservationInfo>) sdao.getReservationInit(source);
		rankList = (ArrayList<Rank>) sdao.getRankTypesByCompanyId(id);
		productList = (ArrayList<Product>) sdao.getProductsByCompanyIdAndDate(source);
		log.info(reservationInfo);
		log.info(productList);
	/*	for(int i=0; i<productList.size(); i++){
			String roomTypes[] = productList.get(i).getRoomTypes().split("_");
			String prices[] = productList.get(i).getPrices().split("_");
			for(int j=0; j<roomTypes.length;j++){
				if(roomTypes[j].equals(roomList.get(0).getType())){
					price = prices[j];
					roomType = prices[j];
					productList.get(i).setPrices(price);
					productList.get(i).setRoomTypes(roomType);
					//예 더블: 6000 싱글 : 6000 
				}
			}
		}*/
		//체크아웃 타임은 1일뒤이므로 세팅해준다
		String finalDate =dateList.get(dateList.size()-1);
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateFormat.parse(finalDate));
		cal.add(Calendar.DATE, 1);
		dateList.add(dateFormat.format(cal.getTime()));
		
		//세팅 끝
		log.info(dateList);
		//세션 제거
		session.remove("company");
		session.remove("dateList");
		session.remove("roomList");
		session.remove("product");
		log.info(company);
		log.info("showReservationFormForProduct 메서드 끝");
		return SUCCESS;
	}
	
	public String showReservationForm() throws Exception{
		/*dateList = (ArrayList<String>) session.get("dateList");
		roomList = (ArrayList<Room>) session.get("roomList");*/
		roomRankList = (ArrayList<RoomRank>) sdao.getRoomRank(((User)session.get("loginedUser")).getCompany_id());
		log.info(dateList);
		log.info(roomList);
		ArrayList<Room> tempRoomList= new ArrayList<Room>();
		for(int i =0 ; i<roomList.size();i++){
			if(roomList.get(i)!=null){
				tempRoomList.add(roomList.get(i));
			}
		}
		roomList= tempRoomList;
		log.info(tempRoomList);
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		source.put("dateList", dateList);
		source.put("roomList", tempRoomList);
		reservationInfo = (ArrayList<ReservationInfo>) sdao.getReservationInit(source);
		productList = (ArrayList<Product>) sdao.getProductsByCompanyIdAndDate(source);
		log.info(productList);
		// 체크아웃 타임은 1일뒤이므로 세팅해준다
			String finalDate =dateList.get(dateList.size()-1);
			SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
			Calendar cal = Calendar.getInstance();
			cal.setTime(dateFormat.parse(finalDate));
			cal.add(Calendar.DATE, 1);
			dateList.add(dateFormat.format(cal.getTime()));
		//세팅 끝
		log.info(reservationInfo);
		log.info(reservationInfo.size());
		log.info(roomRankList);
		//세션제거
		session.remove("company");
		session.remove("dateList");
		session.remove("roomList");
		session.remove("product");
		log.info("showReservationForm 끝");
		return SUCCESS;
	}
	
	public String showReservationFormInMain() throws Exception{
		roomList = new ArrayList<Room>();
		Room room = new Room();
		room.setType(type);
		roomList.add(room);
		ReservationInfo temp = sdao.getReservationInitInMain(dayRoomId);
		checkIn= temp.getDate();
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateFormat.parse(checkIn));
		cal.add(Calendar.DATE, 1);
		checkOut = dateFormat.format(cal.getTime());
		log.info(checkIn);
		log.info(checkOut);
		rankList = (ArrayList<Rank>) sdao.getRankTypesByCompanyId(((User)session.get("loginedUser")).getCompany_id());
		log.info(dayRoomId);
		reservationInfo = new ArrayList<ReservationInfo>();
		reservationInfo.add(temp);
		log.info(reservationInfo.size());
		log.info(rankList);
		return SUCCESS;
	}
	
	public ArrayList<String> getDateList() {
		return dateList;
	}

	public void setDateList(ArrayList<String> dateList) {
		this.dateList = dateList;
	}

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}

	public ArrayList<ReservationInfo> getReservationInfo() {
		return reservationInfo;
	}

	public void setReservationInfo(ArrayList<ReservationInfo> reservationInfo) {
		this.reservationInfo = reservationInfo;
	}

	public ArrayList<Rank> getRankList() {
		return rankList;
	}

	public void setRankList(ArrayList<Rank> rankList) {
		this.rankList = rankList;
	}

	public int getDayRoomId() {
		return dayRoomId;
	}

	public void setDayRoomId(int dayRoomId) {
		this.dayRoomId = dayRoomId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public ArrayList<RoomRank> getRoomRankList() {
		return roomRankList;
	}

	public void setRoomRankList(ArrayList<RoomRank> roomRankList) {
		this.roomRankList = roomRankList;
	}

	public String getWhere() {
		return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}
	
}