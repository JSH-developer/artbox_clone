package vo;

import java.sql.Timestamp;

public class ProductBean {
	private int product_num;
	private String product_code;
	private String product_name;
	private String product_image;
	private String product_image2;
	private String product_description;
	private int product_price;
	private String product_brand;
	private int product_stock_count;
	private int product_sale_price;
	private String product_keywords;
	private Timestamp product_regdate;
	private String product_category_code;
	private String product_option_code;
	private String product_cnt_review;
	private String product_cnt_order;
	private int isNew;
	
	
	
	public int getIsNew() {
		return isNew;
	}
	public void setIsNew(int isNew) {
		this.isNew = isNew;
	}
	public String getProduct_cnt_review() {
		return product_cnt_review;
	}
	public void setProduct_cnt_review(String product_cnt_review) {
		this.product_cnt_review = product_cnt_review;
	}
	public String getProduct_cnt_order() {
		return product_cnt_order;
	}
	public void setProduct_cnt_order(String product_cnt_order) {
		this.product_cnt_order = product_cnt_order;
	}
	
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public String getProduct_image2() {
		return product_image2;
	}
	public void setProduct_image2(String product_image2) {
		this.product_image2 = product_image2;
	}
	public String getProduct_description() {
		return product_description;
	}
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getProduct_brand() {
		return product_brand;
	}
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	public int getProduct_stock_count() {
		return product_stock_count;
	}
	public void setProduct_stock_count(int product_stock_count) {
		this.product_stock_count = product_stock_count;
	}
	public int getProduct_sale_price() {
		return product_sale_price;
	}
	public void setProduct_sale_price(int product_sale_price) {
		this.product_sale_price = product_sale_price;
	}
	public String getProduct_keywords() {
		return product_keywords;
	}
	public void setProduct_keywords(String product_keywords) {
		this.product_keywords = product_keywords;
	}
	public Timestamp getProduct_regdate() {
		return product_regdate;
	}
	public void setProduct_regdate(Timestamp product_regdate) {
		this.product_regdate = product_regdate;
	}
	public String getProduct_category_code() {
		return product_category_code;
	}
	public void setProduct_category_code(String product_category_code) {
		this.product_category_code = product_category_code;
	}
	public String getProduct_option_code() {
		return product_option_code;
	}
	public void setProduct_option_code(String product_option_code) {
		this.product_option_code = product_option_code;
	}

}