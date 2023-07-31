package hotel.vo;

public class Hotels {

	private String hotel_id;
	private String hotel_name;
	private String room_type;
	private int room_id;
	
	public String getHotel_id() {
		return hotel_id;
	}
	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public int getRoom_id() {
		return room_id;
	}
	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	@Override
	public String toString() {
		return "Hotels [hotel_id=" + hotel_id + ", hotel_name=" + hotel_name
				+ ", room_type=" + room_type + ", room_id=" + room_id + "]";
	}
	public Hotels(String hotel_id, String hotel_name, String room_type,
			int room_id) {
		super();
		this.hotel_id = hotel_id;
		this.hotel_name = hotel_name;
		this.room_type = room_type;
		this.room_id = room_id;
	}
	public Hotels() {
		super();
		// TODO Auto-generated constructor stub
	}

}
