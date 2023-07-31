package hotel.vo;

public class ReservationInfo {

	private String dayroom_id;
	private String date;
	private String room_type;
	private String rank_type;
	private int price;
	private String hotel_assign;
	private int persons;
	private String tour_assign;
	public String getDayroom_id() {
		return dayroom_id;
	}
	public void setDayroom_id(String dayroom_id) {
		this.dayroom_id = dayroom_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public String getRank_type() {
		return rank_type;
	}
	public void setRank_type(String rank_type) {
		this.rank_type = rank_type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getHotel_assign() {
		return hotel_assign;
	}
	public void setHotel_assign(String hotel_assign) {
		this.hotel_assign = hotel_assign;
	}
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	public String getTour_assign() {
		return tour_assign;
	}
	public void setTour_assign(String tour_assign) {
		this.tour_assign = tour_assign;
	}
	public ReservationInfo(String dayroom_id, String date, String room_type,
			String rank_type, int price, String hotel_assign, int persons,
			String tour_assign) {
		super();
		this.dayroom_id = dayroom_id;
		this.date = date;
		this.room_type = room_type;
		this.rank_type = rank_type;
		this.price = price;
		this.hotel_assign = hotel_assign;
		this.persons = persons;
		this.tour_assign = tour_assign;
	}
	public ReservationInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "ReservationInfo [dayroom_id=" + dayroom_id + ", date=" + date
				+ ", room_type=" + room_type + ", rank_type=" + rank_type
				+ ", price=" + price + ", hotel_assign=" + hotel_assign
				+ ", persons=" + persons + ", tour_assign=" + tour_assign + "]";
	}
	
	
}
