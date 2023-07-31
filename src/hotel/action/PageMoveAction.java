package hotel.action;

import hotel.common.Paging;
import hotel.dao.SelectDao;
import hotel.vo.Company;
import hotel.vo.Image;
import hotel.vo.Product;
import hotel.vo.Rank;
import hotel.vo.Reservation;
import hotel.vo.Room;
import hotel.vo.User;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class PageMoveAction extends ActionSupport{
	private Logger log = Logger.getLogger(PageMoveAction.class);
	private ArrayList<Rank> rankList; //goReservationWork
	private ArrayList<Room> roomList; //goReservationWork
	private ArrayList<Company> companyList;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao();
	private ArrayList<Product> productList;
	private int month; //goReservationWork
	private int year;  //goReservationWork
	private int date;  //goReservationWork
	private int lastDate; //goReservationWork
	private int firstDay;
	private Product product;
	private ArrayList<Image> imageList; 
	private String [] mealTypes;
	private String [] prices;
	private String [] types;
	private ArrayList<String> dateList;
	private String message;
	private ArrayList<Reservation> reservationList;
	private Paging paging = new Paging();
	private int totalPage;
	private Company company;
	
	public String goBookInfo() throws Exception{
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		source.put("pageAmount", paging.getPageAmount());
		totalPage = sdao.getTotalPage(source);
		paging.setTotalPage(totalPage);
		source= paging.getRange(((User)session.get("loginedUser")).getCompany_id());
		reservationList = (ArrayList<Reservation>) sdao.getReservation(source);
		Calendar cal = Calendar.getInstance();
		for(Reservation res : reservationList){
			String ate =res.getCheckin();
			SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(dateFormat.parse(res.getCheckin()));
			log.info(cal.getTime());
			log.info(cal2.getTime());
			int result = cal.compareTo(cal2);
			log.info(result);
			
		}
		log.info(reservationList);
		session.put("reservationList", reservationList);
		 ActionContext.getContext().setSession(session);
		return SUCCESS;
	}
	
	public String goReservationForm(){
		log.info(dateList);
		log.info(company);
		log.info(product);
		if(company!=null){
			session.put("company", company);
		}
		if(dateList!=null){
			session.put("dateList", dateList);
		}
		if(roomList!=null){
			session.put("roomList", roomList);
		}
		if(product!=null){
			message="product";
			session.put("product", product);
		}
		return SUCCESS;
	}
	
	public String showDetail(){
		//상품 받고 
		product = sdao.getProductById(product.getId());
		//이미지 받고
		imageList = (ArrayList<Image>) sdao.downImage(Integer.toString(product.getId()));
		
		mealTypes = product.getMealTypes().split("_");
		types = product.getRoomTypes().split("_");
		prices = product.getPrices().split("_");
		
		for(Image image : imageList){
			image.setPictureCode(Base64.getEncoder().encodeToString(image.getPicture()));
		}
		
		
		return SUCCESS;
	}
	
	public String goMainPage(){
		String id =  ((User)session.get("loginedUser")).getId().substring(0,2);
		session.put("company", sdao.selectCompany(((User)session.get("loginedUser")).getCompany_id()));
		log.info(session.get("company"));
		String result= null;
		if(id.equals("HM")){
			result="HM";
		}else if(id.equals("HS")){
			result="HS";
		}else if(id.equals("TM")){
			result="TM";
		}
		log.info(result);
		return result;
	}
	
	public String goFirstStep(){
		// 검색
		return SUCCESS;
	}
	public String goProductWork(){
		roomList=(ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		productList = (ArrayList<Product>) sdao.getProductListByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		log.info(roomList);
		log.info(productList);
		return SUCCESS;
	}
	public String goBookProduct(){
		Calendar today = Calendar.getInstance();
		month = today.get(Calendar.MONTH)+1;
		year = today.get(Calendar.YEAR);
		date = today.get(Calendar.DAY_OF_MONTH);
		lastDate = today.getActualMaximum(Calendar.DATE);
		today.set(year, month-1, 1);
		firstDay=today.get(Calendar.DAY_OF_WEEK);
		productList = (ArrayList<Product>) sdao.getProductListByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		log.info(roomList);
		log.info(productList);
		return SUCCESS;
	}
	
	public String goReservationWork(){
		Calendar today = Calendar.getInstance();
		month = today.get(Calendar.MONTH)+1;
		year = today.get(Calendar.YEAR);
		date = today.get(Calendar.DAY_OF_MONTH);
		lastDate = today.getActualMaximum(Calendar.DATE);
		today.set(year, month-1, 1);
		firstDay=today.get(Calendar.DAY_OF_WEEK);
		roomList=(ArrayList<Room>) sdao.getRoomsByCompany_id(((User)session.get("loginedUser")).getCompany_id());
		return SUCCESS;
	}
	public String goReservationTourWork(){
		companyList = (ArrayList<Company>) sdao.getHotelList(((User)session.get("loginedUser")).getCompany_id());
		log.info(companyList);
		return SUCCESS;
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


	public int getFirstDay() {
		return firstDay;
	}


	public void setFirstDay(int firstDay) {
		this.firstDay = firstDay;
	}

	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ArrayList<Image> getImageList() {
		return imageList;
	}

	public void setImageList(ArrayList<Image> imageList) {
		this.imageList = imageList;
	}

	public String[] getMealTypes() {
		return mealTypes;
	}

	public void setMealTypes(String[] mealTypes) {
		this.mealTypes = mealTypes;
	}

	public String[] getPrices() {
		return prices;
	}

	public void setPrices(String[] prices) {
		this.prices = prices;
	}

	public String[] getTypes() {
		return types;
	}

	public void setTypes(String[] types) {
		this.types = types;
	}

	public ArrayList<String> getDateList() {
		return dateList;
	}

	public void setDateList(ArrayList<String> dateList) {
		this.dateList = dateList;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	public ArrayList<Reservation> getReservationList() {
		return reservationList;
	}


	public void setReservationList(ArrayList<Reservation> reservationList) {
		this.reservationList = reservationList;
	}

	public Paging getPaging() {
		return paging;
	}

	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public ArrayList<Company> getCompanyList() {
		return companyList;
	}

	public void setCompanyList(ArrayList<Company> companyList) {
		this.companyList = companyList;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}
	
}
