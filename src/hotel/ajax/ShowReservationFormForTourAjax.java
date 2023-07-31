package hotel.ajax;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import hotel.dao.SelectDao;
import hotel.vo.Company;
import hotel.vo.Product;
import hotel.vo.Rank;
import hotel.vo.ReservationInfo;
import hotel.vo.Room;
import hotel.vo.RoomRank;
import hotel.vo.User;

import com.opensymphony.xwork2.ActionSupport;

public class ShowReservationFormForTourAjax extends ActionSupport {

	private Logger log = Logger.getLogger(ShowReservationFormForTourAjax.class);
	private Product product;
	private Company company;
	private Room room;
	private ArrayList<String> dateList;
	private ArrayList<Room> roomList;
	private ArrayList<ReservationInfo> reservationInfo;
	private ArrayList<Rank> rankList;
	private ArrayList<Product> productList;
	private ArrayList<RoomRank> roomRankList;
	private String where;
	private SelectDao sdao = new SelectDao(); 
	
	
	public String showReservationFormForTour() throws Exception{
		log.info("showReservationFormForTour 시작");
		log.info("product.id : "+product.getId());
		log.info("company.id : "+company.getId());
		log.info("room.type : "+room.getType());
		log.info("dateList : "+dateList);
		if(product.getId()!=0){
			where="product";
		}
		product = sdao.getProductById(product.getId());
		Map<String, Object> source = new HashMap<String, Object>();
		log.info(product);
		log.info(dateList);
		roomList= new ArrayList<Room>();
		roomList.add(room);
		source.put("companyId", company.getId());
		source.put("dateList", dateList);
		source.put("roomList", roomList);
		roomRankList = (ArrayList<RoomRank>) sdao.getRoomRank(company.getId());
		reservationInfo = (ArrayList<ReservationInfo>) sdao.getReservationInit(source);
		rankList = (ArrayList<Rank>) sdao.getRankTypesByCompanyId(company.getId());
		productList = (ArrayList<Product>) sdao.getProductsByCompanyIdAndDate(source);
		
		//체크아웃 타임은 1일뒤이므로 세팅해준다
		String finalDate =dateList.get(dateList.size()-1);
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateFormat.parse(finalDate));
		cal.add(Calendar.DATE, 1);
		dateList.add(dateFormat.format(cal.getTime()));
		
		log.info("reservationInfo : "+reservationInfo);
		log.info("rankList"+rankList);
		log.info("productList"+productList);
		log.info("roomList"+roomList);
		log.info("roomRankList"+roomRankList);
		log.info("showReservationFormForTour 완료");
		
		return SUCCESS;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
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

	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
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
	
	
}
