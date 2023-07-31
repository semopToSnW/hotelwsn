package hotel.vo;

public class RoomSoldAmount {
	
	private String date;
	private int sum_HotelAmount;
	private int sum_OTAAmount;
	
	public RoomSoldAmount() {
		super();
	}
	public RoomSoldAmount(String date, int sum_HotelAmount, int sum_OTAAmount) {
		super();
		this.date = date;
		this.sum_HotelAmount = sum_HotelAmount;
		this.sum_OTAAmount = sum_OTAAmount;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getSum_HotelAmount() {
		return sum_HotelAmount;
	}
	public void setSum_HotelAmount(int sum_HotelAmount) {
		this.sum_HotelAmount = sum_HotelAmount;
	}
	public int getSum_OTAAmount() {
		return sum_OTAAmount;
	}
	public void setSum_OTAAmount(int sum_OTAAmount) {
		this.sum_OTAAmount = sum_OTAAmount;
	}
	@Override
	public String toString() {
		return "RoomSoldAmount [date=" + date + ", sum_HotelAmount="
				+ sum_HotelAmount + ", sum_OTAAmount=" + sum_OTAAmount + "]";
	}
	
	
}

