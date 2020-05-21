package vo;

import java.sql.Date;
import java.sql.Timestamp;

public class CouponBean {
	
	private String coupon_name;
	private int coupon_price;
	private String coupon_condition;
	private String coupon_start;
	private String coupon_limit;
	
	
	private int coupon_use;
	private String coupon_reason;
	private String coupon_member_id;
	private String coupon_img;
	
	


	public String getCoupon_start() {
		return coupon_start;
	}
	public void setCoupon_start(String coupon_start) {
		this.coupon_start = coupon_start;
	}
	public String getCoupon_limit() {
		return coupon_limit;
	}
	public void setCoupon_limit(String coupon_limit) {
		this.coupon_limit = coupon_limit;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public int getCoupon_price() {
		return coupon_price;
	}
	public void setCoupon_price(int coupon_price) {
		this.coupon_price = coupon_price;
	}


	public int getCoupon_use() {
		return coupon_use;
	}
	public void setCoupon_use(int coupon_use) {
		this.coupon_use = coupon_use;
	}
	public String getCoupon_reason() {
		return coupon_reason;
	}
	public void setCoupon_reason(String coupon_reason) {
		this.coupon_reason = coupon_reason;
	}

	public String getCoupon_condition() {
		return coupon_condition;
	}
	public void setCoupon_condition(String coupon_condition) {
		this.coupon_condition = coupon_condition;
	}
	public String getCoupon_member_id() {
		return coupon_member_id;
	}
	public void setCoupon_member_id(String coupon_member_id) {
		this.coupon_member_id = coupon_member_id;
	}
	public String getCoupon_img() {
		return coupon_img;
	}
	public void setCoupon_img(String coupon_img) {
		this.coupon_img = coupon_img;
	}

}
