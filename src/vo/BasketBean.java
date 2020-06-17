package vo;

import java.sql.Timestamp;

public class BasketBean {
	private int basket_num; // basket의 인덱스
	private int basket_quantity; // 물품 수량
	private Timestamp basket_regdate; // 장바구니 추가날짜
	private String basket_member_id; // member 테이블의 id(인덱스)
	private int basket_product_num; // product 테이블의 num(인덱스)

	public BasketBean() {}
	
	public BasketBean(int basket_num, int basket_quantity, Timestamp basket_regdate, String basket_member_id,
			int basket_product_num) {
		super();
		this.basket_num = basket_num;
		this.basket_quantity = basket_quantity;
		this.basket_regdate = basket_regdate;
		this.basket_member_id = basket_member_id;
		this.basket_product_num = basket_product_num;
	}

	public int getBasket_num() {
		return basket_num;
	}
	
	public void setBasket_num(int basket_num) {
		this.basket_num = basket_num;
	}
	
	public int getBasket_quantity() {
		return basket_quantity;
	}
	
	public void setBasket_quantity(int basket_quantity) {
		this.basket_quantity = basket_quantity;
	}
	
	public Timestamp getBasket_regdate() {
		return basket_regdate;
	}
	
	public void setBasket_regdate(Timestamp basket_regdate) {
		this.basket_regdate = basket_regdate;
	}
	
	public String getBasket_member_id() {
		return basket_member_id;
	}
	
	public void setBasket_member_id(String basket_member_id) {
		this.basket_member_id = basket_member_id;
	}
	
	public int getBasket_product_num() {
		return basket_product_num;
	}
	
	public void setBasket_product_num(int basket_product_num) {
		this.basket_product_num = basket_product_num;
	}
	
}
