package vo;

import java.sql.Timestamp;

public class OrdersBean {
	private int orders_num; // orders의 인덱스
	private String orders_order_num; // 주문번호(승인날짜 + 인덱스)
	private String orders_member_id; // member 테이블의 id(아이디)
	private String orders_order_name; // 주문자 이름
	private String orders_order_email; // 주문자 이메일
	private String orders_order_phone; // 주문자 폰번호
	private String orders_msg; // 배송메세지
	private int orders_point; // 결제포인트
	private int orders_total_price; // 결제(최종)금액
	private String orders_payMethod; // 결제수단
	private int orders_state; // 진행상태
	private Timestamp orders_regdate; // 승인(결제)날짜
	private String orders_use_coupon; // 주문시 쓰는 쿠폰
	

	public String getOrders_use_coupon() {
		return orders_use_coupon;
	}
	public void setOrders_use_coupon(String orders_use_coupon) {
		this.orders_use_coupon = orders_use_coupon;
	}
	public int getOrders_num() {
		return orders_num;
	}
	public void setOrders_num(int orders_num) {
		this.orders_num = orders_num;
	}
	public String getOrders_order_num() {
		return orders_order_num;
	}
	public void setOrders_order_num(String orders_order_num) {
		this.orders_order_num = orders_order_num;
	}
	public String getOrders_member_id() {
		return orders_member_id;
	}
	public void setOrders_member_id(String orders_member_id) {
		this.orders_member_id = orders_member_id;
	}
	public String getOrders_order_name() {
		return orders_order_name;
	}
	public void setOrders_order_name(String orders_order_name) {
		this.orders_order_name = orders_order_name;
	}
	public String getOrders_order_email() {
		return orders_order_email;
	}
	public void setOrders_order_email(String orders_order_email) {
		this.orders_order_email = orders_order_email;
	}
	public String getOrders_order_phone() {
		return orders_order_phone;
	}
	public void setOrders_order_phone(String orders_order_phone) {
		this.orders_order_phone = orders_order_phone;
	}
	public String getOrders_msg() {
		return orders_msg;
	}
	public void setOrders_msg(String orders_msg) {
		this.orders_msg = orders_msg;
	}
	public int getOrders_point() {
		return orders_point;
	}
	public void setOrders_point(int orders_point) {
		this.orders_point = orders_point;
	}
	public int getOrders_total_price() {
		return orders_total_price;
	}
	public void setOrders_total_price(int orders_total_price) {
		this.orders_total_price = orders_total_price;
	}
	public String getOrders_payMethod() {
		return orders_payMethod;
	}
	public void setOrders_payMethod(String orders_payMethod) {
		this.orders_payMethod = orders_payMethod;
	}
	public int getOrders_state() {
		return orders_state;
	}
	public void setOrders_state(int orders_state) {
		this.orders_state = orders_state;
	}
	public Timestamp getOrders_regdate() {
		return orders_regdate;
	}
	public void setOrders_regdate(Timestamp orders_regdate) {
		this.orders_regdate = orders_regdate;
	}
	
}
