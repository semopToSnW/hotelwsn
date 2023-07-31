package hotel.vo;

import java.io.Serializable;

public class Room implements Serializable{
	private int id;
	private String type;
	private int amount;
	private int persons;
	private int hotel_assign;
	private int tour_assign;
	private String hotel_id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	public int getHotel_assign() {
		return hotel_assign;
	}
	public void setHotel_assign(int hotel_assign) {
		this.hotel_assign = hotel_assign;
	}
	public int getTour_assign() {
		return tour_assign;
	}
	public void setTour_assign(int tour_assign) {
		this.tour_assign = tour_assign;
	}
	public String getHotel_id() {
		return hotel_id;
	}
	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}
	@Override
	public String toString() {
		return "Room [id=" + id + ", type=" + type + ", amount=" + amount
				+ ", persons=" + persons + ", hotel_assign=" + hotel_assign
				+ ", tour_assign=" + tour_assign + ", hotel_id=" + hotel_id
				+ "]";
	}
	public Room(int id, String type, int amount, int persons, int hotel_assign,
			int tour_assign, String hotel_id) {
		super();
		this.id = id;
		this.type = type;
		this.amount = amount;
		this.persons = persons;
		this.hotel_assign = hotel_assign;
		this.tour_assign = tour_assign;
		this.hotel_id = hotel_id;
	}
	public Room() {
		super();
	}

}