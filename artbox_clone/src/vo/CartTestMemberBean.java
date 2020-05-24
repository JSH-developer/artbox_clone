package vo;

import java.sql.Timestamp;

public class CartTestMemberBean {
	private String id;
	private String pw;
	private String name;
	private Timestamp reg_data;
	private int age;
	private String gender;
	private String email;
	private Timestamp reg_date;
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	//alt + shift + s + r
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPass(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getReg_data() {
		return reg_data;
	}
	public void setReg_data(Timestamp reg_data) {
		this.reg_data = reg_data;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}