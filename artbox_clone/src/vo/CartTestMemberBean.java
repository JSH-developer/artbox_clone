package vo;

import java.sql.Timestamp;

public class CartTestMemberBean {
	private int num;
	private String id;
	private String pw;
	private String name;
	private String postcode;
	private String addr_basic;
	private String addr_detail;
	private String email;
	private String phone;
	private String gender;
	private int point;
	private String birth;
	private String grade;
	private int status;
	private Timestamp regdate;
	
	public CartTestMemberBean() {}

	public CartTestMemberBean(int num, String id, String pw, String name, String postcode, String addr_basic,
			String addr_detail, String email, String phone, String gender, int point, String birth, String grade,
			int status, Timestamp regdate) {
		this.num = num;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.postcode = postcode;
		this.addr_basic = addr_basic;
		this.addr_detail = addr_detail;
		this.email = email;
		this.phone = phone;
		this.gender = gender;
		this.point = point;
		this.birth = birth;
		this.grade = grade;
		this.status = status;
		this.regdate = regdate;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddr_basic() {
		return addr_basic;
	}

	public void setAddr_basic(String addr_basic) {
		this.addr_basic = addr_basic;
	}

	public String getAddr_detail() {
		return addr_detail;
	}

	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
}
