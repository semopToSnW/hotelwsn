package hotel.vo;

import java.util.ArrayList;
import java.util.HashMap;

public class Product {
	
	public Product() {
	}
	private int id;
	private String name;
	private String explain;
	private String mealTypes;
	private String checkInTime;
	private String checkOutTime;
	private int amount;
	private String prices;
	private String roomTypes;
	private String company_id;
	private String saleStart;
	private String saleFinish;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public String getMealTypes() {
		return mealTypes;
	}
	public void setMealTypes(String mealTypes) {
		this.mealTypes = mealTypes;
	}
	public String getCheckInTime() {
		return checkInTime;
	}
	public void setCheckInTime(String checkInTime) {
		this.checkInTime = checkInTime;
	}
	public String getCheckOutTime() {
		return checkOutTime;
	}
	public void setCheckOutTime(String checkOutTime) {
		this.checkOutTime = checkOutTime;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getPrices() {
		return prices;
	}
	public void setPrices(String prices) {
		this.prices = prices;
	}
	public String getRoomTypes() {
		return roomTypes;
	}
	public void setRoomTypes(String roomTypes) {
		this.roomTypes = roomTypes;
	}
	public String getCompany_id() {
		return company_id;
	}
	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	public String getSaleStart() {
		return saleStart;
	}
	public void setSaleStart(String saleStart) {
		this.saleStart = saleStart;
	}
	public String getSaleFinish() {
		return saleFinish;
	}
	public void setSaleFinish(String saleFinish) {
		this.saleFinish = saleFinish;
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", explain=" + explain
				+ ", mealTypes=" + mealTypes + ", checkInTime=" + checkInTime
				+ ", checkOutTime=" + checkOutTime + ", amount=" + amount
				+ ", prices=" + prices + ", roomTypes=" + roomTypes
				+ ", company_id=" + company_id + ", saleStart=" + saleStart
				+ ", saleFinish=" + saleFinish + "]";
	}
	public Product(int id, String name, String explain, String mealTypes,
			String checkInTime, String checkOutTime, int amount, String prices,
			String roomTypes, String company_id, String saleStart,
			String saleFinish) {
		super();
		this.id = id;
		this.name = name;
		this.explain = explain;
		this.mealTypes = mealTypes;
		this.checkInTime = checkInTime;
		this.checkOutTime = checkOutTime;
		this.amount = amount;
		this.prices = prices;
		this.roomTypes = roomTypes;
		this.company_id = company_id;
		this.saleStart = saleStart;
		this.saleFinish = saleFinish;
	}
	
	
}
