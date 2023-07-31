package hotel.vo;

public class DayRoom {
	
	private int id;
	private String date;
	private int hotel_assign;
	private int tour_assign;
	private int price;
	private String hotel_OnOff;
	private String tour_OnOff;
	private int room_id;
	private String rank_type;
	private String room_type;	// 방 타입 추가 (재학)
	private String page;		// 페이지 추가  (재학)
	private int sum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getHotel_OnOff() {
		return hotel_OnOff;
	}
	public void setHotel_OnOff(String hotel_OnOff) {
		this.hotel_OnOff = hotel_OnOff;
	}
	public String getTour_OnOff() {
		return tour_OnOff;
	}
	public void setTour_OnOff(String tour_OnOff) {
		this.tour_OnOff = tour_OnOff;
	}
	public int getRoom_id() {
		return room_id;
	}
	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	public String getRank_type() {
		return rank_type;
	}
	public void setRank_type(String rank_type) {
		this.rank_type = rank_type;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	@Override
	public String toString() {
		return "DayRoom [id=" + id + ", date=" + date + ", hotel_assign="
				+ hotel_assign + ", tour_assign=" + tour_assign + ", price="
				+ price + ", hotel_OnOff=" + hotel_OnOff + ", tour_OnOff="
				+ tour_OnOff + ", room_id=" + room_id + ", rank_type="
				+ rank_type + ", room_type=" + room_type + ", page=" + page
				+ ", sum=" + sum + "]";
	}
	public DayRoom(int id, String date, int hotel_assign, int tour_assign,
			int price, String hotel_OnOff, String tour_OnOff, int room_id,
			String rank_type, String room_type, String page, int sum) {
		super();
		this.id = id;
		this.date = date;
		this.hotel_assign = hotel_assign;
		this.tour_assign = tour_assign;
		this.price = price;
		this.hotel_OnOff = hotel_OnOff;
		this.tour_OnOff = tour_OnOff;
		this.room_id = room_id;
		this.rank_type = rank_type;
		this.room_type = room_type;
		this.page = page;
		this.sum = sum;
	}
	public DayRoom() {
		super();
	}
	
	
			
}