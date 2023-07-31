package hotel.vo;

import java.util.ArrayList;
import java.util.HashMap;

public class Res_Group {

	private int id;
	private int dayRoom_id;
	private int reservation_id;
	private int hotel_room_count;
	private int tour_room_count;
	private int price;
	private int product_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDayRoom_id() {
		return dayRoom_id;
	}
	public void setDayRoom_id(int dayRoom_id) {
		this.dayRoom_id = dayRoom_id;
	}
	public int getReservation_id() {
		return reservation_id;
	}
	public void setReservation_id(int reservation_id) {
		this.reservation_id = reservation_id;
	}
	public int getHotel_room_count() {
		return hotel_room_count;
	}
	public void setHotel_room_count(int hotel_room_count) {
		this.hotel_room_count = hotel_room_count;
	}
	public int getTour_room_count() {
		return tour_room_count;
	}
	public void setTour_room_count(int tour_room_count) {
		this.tour_room_count = tour_room_count;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	@Override
	public String toString() {
		return "Res_Group [id=" + id + ", dayRoom_id=" + dayRoom_id
				+ ", reservation_id=" + reservation_id + ", hotel_room_count="
				+ hotel_room_count + ", tour_room_count=" + tour_room_count
				+ ", price=" + price + ", product_id=" + product_id + "]";
	}
	public Res_Group(int id, int dayRoom_id, int reservation_id,
			int hotel_room_count, int tour_room_count, int price, int product_id) {
		super();
		this.id = id;
		this.dayRoom_id = dayRoom_id;
		this.reservation_id = reservation_id;
		this.hotel_room_count = hotel_room_count;
		this.tour_room_count = tour_room_count;
		this.price = price;
		this.product_id = product_id;
	}
	public Res_Group() {
		super();
	}

}

