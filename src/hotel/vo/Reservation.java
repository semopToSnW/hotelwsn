package hotel.vo;

public class Reservation {
	
	private int id;
	private String checkin;
	private String checkout;
	private int persons;
	private String regDate;
	private String renewDate;
	private String stayPerson;
	private String res_person;
	private String nation;
	private String phone;
	private String memo;
	private String reg_person;
	private String renew_pserson;
	private int price;
	private String dayroom_id;
	private String status_name;
	
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
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRenewDate() {
		return renewDate;
	}
	public void setRenewDate(String renewDate) {
		this.renewDate = renewDate;
	}
	public String getStayPerson() {
		return stayPerson;
	}
	public void setStayPerson(String stayPerson) {
		this.stayPerson = stayPerson;
	}
	public String getRes_person() {
		return res_person;
	}
	public void setRes_person(String res_person) {
		this.res_person = res_person;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getReg_person() {
		return reg_person;
	}
	public void setReg_person(String reg_person) {
		this.reg_person = reg_person;
	}
	public String getRenew_pserson() {
		return renew_pserson;
	}
	public void setRenew_pserson(String renew_pserson) {
		this.renew_pserson = renew_pserson;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDayroom_id() {
		return dayroom_id;
	}
	public void setDayroom_id(String dayroom_id) {
		this.dayroom_id = dayroom_id;
	}
	public String getStatus_name() {
		return status_name;
	}
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	public Reservation(int id, String checkin, String checkout, int persons,
			String regDate, String renewDate, String stayPerson,
			String res_person, String nation, String phone, String memo,
			String reg_person, String renew_pserson, int price,
			String dayroom_id, String status_name) {
		super();
		this.id = id;
		this.checkin = checkin;
		this.checkout = checkout;
		this.persons = persons;
		this.regDate = regDate;
		this.renewDate = renewDate;
		this.stayPerson = stayPerson;
		this.res_person = res_person;
		this.nation = nation;
		this.phone = phone;
		this.memo = memo;
		this.reg_person = reg_person;
		this.renew_pserson = renew_pserson;
		this.price = price;
		this.dayroom_id = dayroom_id;
		this.status_name = status_name;
	}
	public Reservation() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Reservation [id=" + id + ", checkin=" + checkin + ", checkout="
				+ checkout + ", persons=" + persons + ", regDate=" + regDate
				+ ", renewDate=" + renewDate + ", stayPerson=" + stayPerson
				+ ", res_person=" + res_person + ", nation=" + nation
				+ ", phone=" + phone + ", memo=" + memo + ", reg_person="
				+ reg_person + ", renew_pserson=" + renew_pserson + ", price="
				+ price + ", dayroom_id=" + dayroom_id + ", status_name="
				+ status_name + "]";
	}
	
	
}
