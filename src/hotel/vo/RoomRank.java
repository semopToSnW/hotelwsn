package hotel.vo;

public class RoomRank {

	private int rank_id;
	private String rank_type;
	private int rank_price;
	private String room_type;
	
	public int getRank_id() {
		return rank_id;
	}
	public void setRank_id(int rank_id) {
		this.rank_id = rank_id;
	}
	public String getRank_type() {
		return rank_type;
	}
	public void setRank_type(String rank_type) {
		this.rank_type = rank_type;
	}
	public int getRank_price() {
		return rank_price;
	}
	public void setRank_price(int rank_price) {
		this.rank_price = rank_price;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	@Override
	public String toString() {
		return "RoomRank [rank_id=" + rank_id + ", rank_type=" + rank_type
				+ ", rank_price=" + rank_price + ", room_type=" + room_type
				+ "]";
	}
	public RoomRank(int rank_id, String rank_type, int rank_price,
			String room_type) {
		super();
		this.rank_id = rank_id;
		this.rank_type = rank_type;
		this.rank_price = rank_price;
		this.room_type = room_type;
	}
	public RoomRank() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
