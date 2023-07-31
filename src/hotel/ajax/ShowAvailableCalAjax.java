package hotel.ajax;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import hotel.common.CalendarTool;
import hotel.dao.SelectDao;
import hotel.vo.Company;
import hotel.vo.DayRoom;
import hotel.vo.Product;
import hotel.vo.Room;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionSupport;

public class ShowAvailableCalAjax extends ActionSupport {

	private Logger log = Logger.getLogger(ShowAvailableCalAjax.class);
	private Room room;
	private Product product;
	private Company company;
	private ArrayList<DayRoom> dayRoomList;
	private CalendarTool cal; 
	
	private SelectDao sdao = new SelectDao();
	
	public String showAvailableCal(){
		cal = new CalendarTool();
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("companyId", company.getId());
		source.put("roomType", room.getType());
		source.put("curDate", cal.getFulldate());
		log.info(source);
		log.info(product.getId());
		if(product.getId()==0){
			dayRoomList = (ArrayList<DayRoom>) sdao.getDayRoomsByCompany_idAndDateAndRoomType(source);
		}else{
			dayRoomList = (ArrayList<DayRoom>) sdao.getDayRoomsByCompany_idAndDateAndRoomType(source);
		}
		log.info(dayRoomList);
		return SUCCESS;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
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

	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}

	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}

	public CalendarTool getCal() {
		return cal;
	}

	public void setCal(CalendarTool cal) {
		this.cal = cal;
	}
	
	
}
