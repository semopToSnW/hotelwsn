package hotel.vo;

public class Company {
	
/*	<!-- CREATE TABLE COMPANY
	(
		ID varchar2(50) NOT NULL,
		Name varchar2(50) NOT NULL,
		"Group" varchar2(50) NOT NULL,
		CEO varchar2(30) NOT NULL,
		Phone varchar2(30) NOT NULL,
		Email varchar2(50) NOT NULL,
		Addr varchar2(100) NOT NULL,
		RegDate date NOT NULL,
		PRIMARY KEY (ID)
	); -->*/
	
	private String id;
	private String name;
	private String group;
	private String ceo;
	private String phone;
	private String email;
	private String addr;
	private String regDate;
	private int regCount;
	private String level;
	private String infocompleted;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getRegCount() {
		return regCount;
	}
	public void setRegCount(int regCount) {
		this.regCount = regCount;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getInfocompleted() {
		return infocompleted;
	}
	public void setInfocompleted(String infocompleted) {
		this.infocompleted = infocompleted;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((addr == null) ? 0 : addr.hashCode());
		result = prime * result + ((ceo == null) ? 0 : ceo.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((group == null) ? 0 : group.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((infocompleted == null) ? 0 : infocompleted.hashCode());
		result = prime * result + ((level == null) ? 0 : level.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((phone == null) ? 0 : phone.hashCode());
		result = prime * result + regCount;
		result = prime * result + ((regDate == null) ? 0 : regDate.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Company other = (Company) obj;
		if (addr == null) {
			if (other.addr != null)
				return false;
		} else if (!addr.equals(other.addr))
			return false;
		if (ceo == null) {
			if (other.ceo != null)
				return false;
		} else if (!ceo.equals(other.ceo))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (group == null) {
			if (other.group != null)
				return false;
		} else if (!group.equals(other.group))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (infocompleted == null) {
			if (other.infocompleted != null)
				return false;
		} else if (!infocompleted.equals(other.infocompleted))
			return false;
		if (level == null) {
			if (other.level != null)
				return false;
		} else if (!level.equals(other.level))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (phone == null) {
			if (other.phone != null)
				return false;
		} else if (!phone.equals(other.phone))
			return false;
		if (regCount != other.regCount)
			return false;
		if (regDate == null) {
			if (other.regDate != null)
				return false;
		} else if (!regDate.equals(other.regDate))
			return false;
		return true;
	}
	public Company() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Company(String id, String name, String group, String ceo,
			String phone, String email, String addr, String regDate,
			int regCount, String level, String infocompleted) {
		super();
		this.id = id;
		this.name = name;
		this.group = group;
		this.ceo = ceo;
		this.phone = phone;
		this.email = email;
		this.addr = addr;
		this.regDate = regDate;
		this.regCount = regCount;
		this.level = level;
		this.infocompleted = infocompleted;
	}
	@Override
	public String toString() {
		return "Company [id=" + id + ", name=" + name + ", group=" + group
				+ ", ceo=" + ceo + ", phone=" + phone + ", email=" + email
				+ ", addr=" + addr + ", regDate=" + regDate + ", regCount="
				+ regCount + ", level=" + level + ", infocompleted="
				+ infocompleted + "]";
	}
	
}
