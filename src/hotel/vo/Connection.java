package hotel.vo;

import java.util.ArrayList;

public class Connection {
	
	private String hotel_id;
	private ArrayList<String> ota_id;
	public String getHotel_id() {
		return hotel_id;
	}
	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}
	public ArrayList<String> getOta_id() {
		return ota_id;
	}
	public void setOta_id(ArrayList<String> ota_id) {
		this.ota_id = ota_id;
	}
	@Override
	public String toString() {
		return "Connection [hotel_id=" + hotel_id + ", ota_id=" + ota_id + "]";
	}
	public Connection(String hotel_id, ArrayList<String> ota_id) {
		super();
		this.hotel_id = hotel_id;
		this.ota_id = ota_id;
	}
	public Connection() {
		super();
	}
}
