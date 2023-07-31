package hotel.vo;

public class Graph_DateAmount {
	
	private String Date;
	private int Amount;
	
	public Graph_DateAmount() {
		super();
	}
	public Graph_DateAmount(String date, int amount) {
		super();
		Date = date;
		Amount = amount;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
	public int getAmount() {
		return Amount;
	}
	public void setAmount(int amount) {
		Amount = amount;
	}
	@Override
	public String toString() {
		return "Graph_DateAmount [Date=" + Date + ", Amount=" + Amount + "]";
	}
	
}
