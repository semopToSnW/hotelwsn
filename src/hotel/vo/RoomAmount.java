package hotel.vo;

public class RoomAmount {
	
	private String date;
	private int sum_RoomAmount;
	private int sum_HotelAmount;
	private int sum_OTAAmount;
	private String hotel_onoff;
	private String tour_onoff;
	
	private int def_HotelAmount;
	private int def_OTAAmount;	
	
	private int dayRoom_id;
	
	public RoomAmount() {
		super();
	}
	
	


	public RoomAmount(String date, int sum_RoomAmount, int sum_HotelAmount,
			int sum_OTAAmount, String hotel_onoff, String tour_onoff,
			int def_HotelAmount, int def_OTAAmount, int dayRoom_id) {
		super();
		this.date = date;
		this.sum_RoomAmount = sum_RoomAmount;
		this.sum_HotelAmount = sum_HotelAmount;
		this.sum_OTAAmount = sum_OTAAmount;
		this.hotel_onoff = hotel_onoff;
		this.tour_onoff = tour_onoff;
		this.def_HotelAmount = def_HotelAmount;
		this.def_OTAAmount = def_OTAAmount;
		this.dayRoom_id = dayRoom_id;
	}




	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getSum_RoomAmount() {
		return sum_RoomAmount;
	}

	public void setSum_RoomAmount(int sum_RoomAmount) {
		this.sum_RoomAmount = sum_RoomAmount;
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
	
	

	public String getHotel_onoff() {
		return hotel_onoff;
	}



	public void setHotel_onoff(String hotel_onoff) {
		this.hotel_onoff = hotel_onoff;
	}



	public String getTour_onoff() {
		return tour_onoff;
	}



	public void setTour_onoff(String tour_onoff) {
		this.tour_onoff = tour_onoff;
	}
	

	public int getDef_HotelAmount() {
		return def_HotelAmount;
	}

	public void setDef_HotelAmount(int def_HotelAmount) {
		this.def_HotelAmount = def_HotelAmount;
	}

	public int getDef_OTAAmount() {
		return def_OTAAmount;
	}

	public void setDef_OTAAmount(int def_OTAAmount) {
		this.def_OTAAmount = def_OTAAmount;
	}
	

	public int getDayRoom_id() {
		return dayRoom_id;
	}

	public void setDayRoom_id(int dayRoom_id) {
		this.dayRoom_id = dayRoom_id;
	}

	@Override
	public String toString() {
		return "RoomAmount [date=" + date + ", sum_RoomAmount="
				+ sum_RoomAmount + ", sum_HotelAmount=" + sum_HotelAmount
				+ ", sum_OTAAmount=" + sum_OTAAmount + ", hotel_onoff="
				+ hotel_onoff + ", tour_onoff=" + tour_onoff
				+ ", def_HotelAmount=" + def_HotelAmount + ", def_OTAAmount="
				+ def_OTAAmount + ", dayRoom_id=" + dayRoom_id + "]";
	}

	
}
