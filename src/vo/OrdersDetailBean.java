package vo;

public class OrdersDetailBean {
	private int OrdersDetail_num; // orders_detail의 인덱스
	private int OrdersDetail_quantity; // 수량
	private int OrdersDetail_orders_order_num; // orders 테이블의 order_num(주문번호)
	private int OrdersDetail_product_num; // product 테이블의 num(인덱스)
	private int OrdersDetail_receiver_num; // receiver 테이블의 num(인덱스)
	private String OrdersDetail_code; // 상품코드
	private String OrdersDetail_name; // 상품이름
	private String OrdersDetail_image; // 대표이미지 파일명
	private int OrdersDetail_price; // 상품가격
	
	public int getOrdersDetail_num() {
		return OrdersDetail_num;
	}
	public void setOrdersDetail_num(int ordersDetail_num) {
		OrdersDetail_num = ordersDetail_num;
	}
	public int getOrdersDetail_quantity() {
		return OrdersDetail_quantity;
	}
	public void setOrdersDetail_quantity(int ordersDetail_quantity) {
		OrdersDetail_quantity = ordersDetail_quantity;
	}
	public int getOrdersDetail_orders_order_num() {
		return OrdersDetail_orders_order_num;
	}
	public void setOrdersDetail_orders_order_num(int ordersDetail_orders_order_num) {
		OrdersDetail_orders_order_num = ordersDetail_orders_order_num;
	}
	public int getOrdersDetail_product_num() {
		return OrdersDetail_product_num;
	}
	public void setOrdersDetail_product_num(int ordersDetail_product_num) {
		OrdersDetail_product_num = ordersDetail_product_num;
	}
	public int getOrdersDetail_receiver_num() {
		return OrdersDetail_receiver_num;
	}
	public void setOrdersDetail_receiver_num(int ordersDetail_receiver_num) {
		OrdersDetail_receiver_num = ordersDetail_receiver_num;
	}
	public String getOrdersDetail_code() {
		return OrdersDetail_code;
	}
	public void setOrdersDetail_code(String ordersDetail_code) {
		OrdersDetail_code = ordersDetail_code;
	}
	public String getOrdersDetail_name() {
		return OrdersDetail_name;
	}
	public void setOrdersDetail_name(String ordersDetail_name) {
		OrdersDetail_name = ordersDetail_name;
	}
	public String getOrdersDetail_image() {
		return OrdersDetail_image;
	}
	public void setOrdersDetail_image(String ordersDetail_image) {
		OrdersDetail_image = ordersDetail_image;
	}
	public int getOrdersDetail_price() {
		return OrdersDetail_price;
	}
	public void setOrdersDetail_price(int ordersDetail_price) {
		OrdersDetail_price = ordersDetail_price;
	}
	
}
