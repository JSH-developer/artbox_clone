package vo;

import java.sql.Timestamp;

public class ReviewBean {
	private int review_num;
	private int review_skill;
	private int review_design;
	private int review_price;
	private int review_quality;
	private Timestamp review_regdate;
	private String review_content;
	private int review_re_check;
	private String review_re_name;
	private Timestamp review_re_regdate;
	private String review_re_content;
	private String review_member_id;
	private int review_product_num;
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getReview_skill() {
		return review_skill;
	}
	public void setReview_skill(int review_skill) {
		this.review_skill = review_skill;
	}
	public int getReview_design() {
		return review_design;
	}
	public void setReview_design(int review_design) {
		this.review_design = review_design;
	}
	public int getReview_price() {
		return review_price;
	}
	public void setReview_price(int review_price) {
		this.review_price = review_price;
	}
	public int getReview_quality() {
		return review_quality;
	}
	public void setReview_quality(int review_quality) {
		this.review_quality = review_quality;
	}
	public Timestamp getReview_regdate() {
		return review_regdate;
	}
	public void setReview_regdate(Timestamp review_regdate) {
		this.review_regdate = review_regdate;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public int getReview_re_check() {
		return review_re_check;
	}
	public void setReview_re_check(int review_re_check) {
		this.review_re_check = review_re_check;
	}
	public String getReview_re_name() {
		return review_re_name;
	}
	public void setReview_re_name(String review_re_name) {
		this.review_re_name = review_re_name;
	}
	public Timestamp getReview_re_regdate() {
		return review_re_regdate;
	}
	public void setReview_re_regdate(Timestamp review_re_regdate) {
		this.review_re_regdate = review_re_regdate;
	}
	public String getReview_re_content() {
		return review_re_content;
	}
	public void setReview_re_content(String review_re_content) {
		this.review_re_content = review_re_content;
	}
	public String getReview_member_id() {
		return review_member_id;
	}
	public void setReview_member_id(String review_member_id) {
		this.review_member_id = review_member_id;
	}
	public int getReview_product_num() {
		return review_product_num;
	}
	public void setReview_product_num(int review_product_num) {
		this.review_product_num = review_product_num;
	}
}
