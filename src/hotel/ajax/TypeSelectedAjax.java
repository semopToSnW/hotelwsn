package hotel.ajax;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import hotel.dao.SelectDao;
import hotel.vo.DayRoom;
import hotel.vo.Product;
import hotel.vo.User;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TypeSelectedAjax extends ActionSupport {

	private Logger log = Logger.getLogger(TypeSelectedAjax.class);
	private Product product;
	private String [] types;
	
	private SelectDao sdao = new SelectDao();
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private ArrayList<DayRoom> dayRoomList;
	
	private int month;
	private int year;
	private int date;
	private int day;
	private int firstDay;
	private int lastDate;
	private int currMonth;
	
	
	public String typeSelected(){
		log.info(product);
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("id", product.getId());
		source.put("type", product.getRoomTypes());
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		dayRoomList = (ArrayList<DayRoom>) sdao.getDayRoomByProduct(source);
		log.info(dayRoomList);
		product = sdao.getProductById(product.getId());
		Calendar cal = Calendar.getInstance();
		currMonth =cal.get(Calendar.MONTH);
		log.info("현재 달 : "+currMonth);
		log.info("판매 시작일 : "+product.getSaleStart());
		String startDate[] = product.getSaleStart().split("\\.");
		log.info(startDate[0]);
		log.info(startDate[0]+startDate[1]+startDate[2]);
		cal.set(Integer.parseInt(startDate[0]), Integer.parseInt(startDate[1])-1, Integer.parseInt(startDate[2]));
		year = cal.get(Calendar.YEAR);
		month = cal.get(Calendar.MONTH)+1;
		date = cal.get(Calendar.DATE);
		lastDate =cal.getActualMaximum(Calendar.DATE);
		cal.set(year, month-1, 1);
		firstDay = cal.get(Calendar.DAY_OF_WEEK);
		log.info("year : "+year+"  month : "+month+"  date : "+date+"  lastDate : "+lastDate+"  firstDay : "+firstDay);
		return SUCCESS;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String[] getTypes() {
		return types;
	}

	public void setTypes(String[] types) {
		this.types = types;
	}

	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}

	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
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

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
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

	public int getCurrMonth() {
		return currMonth;
	}

	public void setCurrMonth(int currMonth) {
		this.currMonth = currMonth;
	}
	
	
}
