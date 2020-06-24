package vo;

import java.sql.Timestamp;

public class OrdersDetailBean {
	private int num; // orders_detail의 인덱스
	private int quantity; // 수량
	private String orders_order_num; // orders 테이블의 order_num(주문번호)
	private int product_num; // product 테이블의 num(인덱스)
	private int receiver_num; // receiver 테이블의 num(인덱스)
	private String code; // 상품코드
	private String name; // 상품이름
	private String image; // 대표이미지 파일명
	private int price; // 상품가격
	// ---------------------------------------------------
	private String orders_msg; // 배송메세지
	private Timestamp orders_regdate; // 승인(결제)날짜
	private int orders_total_price; // 결제(최종)금액
	private String orders_payMethod; // 결제수단
	private String receiver_name; // 수신자 이름
	private String receiver_phone; // 수신자 폰번호
	private String receiver_postcode; // 수신자 우편번호
	private String receiver_addr; // 수신자 기본주소
	private String receiver_addr_detail; // 수신자 상세주소
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getOrders_order_num() {
		return orders_order_num;
	}
	public void setOrders_order_num(String orders_order_num) {
		this.orders_order_num = orders_order_num;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getReceiver_num() {
		return receiver_num;
	}
	public void setReceiver_num(int receiver_num) {
		this.receiver_num = receiver_num;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getOrders_msg() {
		return orders_msg;
	}
	public void setOrders_msg(String orders_msg) {
		this.orders_msg = orders_msg;
	}
	public Timestamp getOrders_regdate() {
		return orders_regdate;
	}
	public void setOrders_regdate(Timestamp orders_regdate) {
		this.orders_regdate = orders_regdate;
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
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	public String getReceiver_postcode() {
		return receiver_postcode;
	}
	public void setReceiver_postcode(String receiver_postcode) {
		this.receiver_postcode = receiver_postcode;
	}
	public String getReceiver_addr() {
		return receiver_addr;
	}
	public void setReceiver_addr(String receiver_addr) {
		this.receiver_addr = receiver_addr;
	}
	public String getReceiver_addr_detail() {
		return receiver_addr_detail;
	}
	public void setReceiver_addr_detail(String receiver_addr_detail) {
		this.receiver_addr_detail = receiver_addr_detail;
	}
	
}
