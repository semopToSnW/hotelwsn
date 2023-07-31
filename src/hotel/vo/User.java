package hotel.vo;

import java.io.Serializable;

public class User implements Serializable{
	
/**
	 * 
	 */
	private static final long serialVersionUID = -4952963402743488887L;
	/*	ID varchar2(7) NOT NULL,
	PW varchar2(20) NOT NULL,
	REGDATE date NOT NULL,
	ContractPeriod number(2),
	Company_ID varchar2(50),
	PRIMARY KEY (ID)*/
	public enum User_signal{
		logined, loginCheck
	}
	
	private String id;
	private String pw;
	private String regdate;
	private int contractperiod;
	private String company_id;
	private User_signal signal;
	private String level;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getContractperiod() {
		return contractperiod;
	}
	public void setContractperiod(int contractperiod) {
		this.contractperiod = contractperiod;
	}
	public String getCompany_id() {
		return company_id;
	}
	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	public User_signal getSignal() {
		return signal;
	}
	public void setSignal(User_signal signal) {
		this.signal = signal;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", pw=" + pw + ", regdate=" + regdate
				+ ", contractperiod=" + contractperiod + ", company_id="
				+ company_id + ", signal=" + signal + ", level=" + level + "]";
	}
	public User(String id, String pw, String regdate, int contractperiod,
			String company_id, User_signal signal, String level) {
		super();
		this.id = id;
		this.pw = pw;
		this.regdate = regdate;
		this.contractperiod = contractperiod;
		this.company_id = company_id;
		this.signal = signal;
		this.level = level;
	}
	public User() {
		super();
	}
	
	
}
