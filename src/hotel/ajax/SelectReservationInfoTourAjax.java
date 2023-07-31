package hotel.ajax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import hotel.common.CalendarTool;
import hotel.dao.SelectDao;
import hotel.vo.Company;
import hotel.vo.Product;
import hotel.vo.Rank;
import hotel.vo.Room;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class SelectReservationInfoTourAjax extends ActionSupport {

	private Logger log = Logger.getLogger(SelectReservationInfoTourAjax.class);
	private Company company;
	private Product product;
	private ArrayList<Product> productList;
	private ArrayList<Room> roomList;
	private SelectDao sdao = new SelectDao();
	private CalendarTool cal = new CalendarTool();
	private Room room;
	private Map<String, Object> session =ActionContext.getContext().getSession();
	
	public String showTypes(){
		log.info(product);
		if(product.getId()!=0){
			product = sdao.getProductById(product.getId());
			session.put("product", product);
			//룸리스트
			roomList = (ArrayList<Room>) sdao.getRoomsByProductId(product.getId());
		}else{
			roomList = (ArrayList<Room>) sdao.getRoomsByCompany_id(company.getId());
		}
		log.info(product);
		log.info(roomList);
		return SUCCESS;
	}
	
	public String showProduct(){
		log.info(company);
		productList = (ArrayList<Product>) sdao.getProductListByCompany_id(company.getId());
		log.info(productList);
		return SUCCESS;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
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

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}

	public CalendarTool getCal() {
		return cal;
	}

	public void setCal(CalendarTool cal) {
		this.cal = cal;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

}
