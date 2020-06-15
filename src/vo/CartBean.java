package vo;

import java.sql.Timestamp;

public class CartBean {
	private int cart_num; // cart의 인덱스
	private int cart_quantity; // 물품 수량
	private Timestamp cart_regdate; // 장바구니 추가날짜
	private String cart_member_id; // member 테이블의 id(인덱스)
	private int cart_product_num; // product 테이블의 num(인덱스)

	public CartBean() {}
	
	public CartBean(int cart_num, int cart_quantity, Timestamp cart_regdate, String cart_member_id,
			int cart_product_num) {
		super();
		this.cart_num = cart_num;
		this.cart_quantity = cart_quantity;
		this.cart_regdate = cart_regdate;
		this.cart_member_id = cart_member_id;
		this.cart_product_num = cart_product_num;
	}

	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}
	public Timestamp getCart_regdate() {
		return cart_regdate;
	}
	public void setCart_regdate(Timestamp cart_regdate) {
		this.cart_regdate = cart_regdate;
	}
	public String getCart_member_id() {
		return cart_member_id;
	}
	public void setCart_member_id(String cart_member_id) {
		this.cart_member_id = cart_member_id;
	}
	public int getCart_product_num() {
		return cart_product_num;
	}
	public void setCart_product_num(int cart_product_num) {
		this.cart_product_num = cart_product_num;
	}
	
}
