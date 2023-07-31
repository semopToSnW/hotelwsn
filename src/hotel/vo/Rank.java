package hotel.vo;

public class Rank {
	
	private int id;
	private String type;
	private int price;
	private String room_id;
	
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRoom_id() {
		return room_id;
	}
	public void setRoom_id(String room_id) {
		this.room_id = room_id;
	}
	@Override
	public String toString() {
		return "Rank [id=" + id + ", type=" + type + ", price=" + price
				+ ", room_id=" + room_id + "]";
	}
	public Rank(int id, String type, int price, String room_id) {
		super();
		this.id = id;
		this.type = type;
		this.price = price;
		this.room_id = room_id;
	}
	public Rank() {
		super();
	}
	
}
