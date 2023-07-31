package hotel.vo;

public class ReservationInfo2 {
	
	private String name;
	private int hotel_room_count;
	private int tour_room_count;
	private int id;
	private String checkin;
	private String checkout;
	private String type;
	private String status_name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus_name() {
		return status_name;
	}
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	@Override
	public String toString() {
		return "ReservationInfo2 [name=" + name + ", hotel_room_count="
				+ hotel_room_count + ", tour_room_count=" + tour_room_count
				+ ", id=" + id + ", checkin=" + checkin + ", checkout="
				+ checkout + ", type=" + type + ", status_name=" + status_name
				+ "]";
	}
	public ReservationInfo2(String name, int hotel_room_count,
			int tour_room_count, int id, String checkin, String checkout,
			String type, String status_name) {
		super();
		this.name = name;
		this.hotel_room_count = hotel_room_count;
		this.tour_room_count = tour_room_count;
		this.id = id;
		this.checkin = checkin;
		this.checkout = checkout;
		this.type = type;
		this.status_name = status_name;
	}
	public ReservationInfo2() {
		super();
	}
}
