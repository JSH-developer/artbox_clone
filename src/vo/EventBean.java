package vo;

import java.sql.Timestamp;

public class EventBean {
	
	private int event_num;
	private String event_titie;
	private String event_content;
	private Timestamp event_time;
	private String condition;
	private int discount;
	private String event_start;
	private String event_limit;
	private String event_img,event_category;


	public EventBean() {}

	public EventBean(int event_num, String event_titie, String event_content, Timestamp event_time, String condition,
			int discount, String event_start, String event_limit, String event_img) {
		super();
		this.event_num = event_num;
		this.event_titie = event_titie;
		this.event_content = event_content;
		this.event_time = event_time;
		this.condition = condition;
		this.discount = discount;
		this.event_start = event_start;
		this.event_limit = event_limit;
		this.event_img = event_img;
	}

	public int getEvent_num() {
		return event_num;
	}

	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}

	public String getEvent_titie() {
		return event_titie;
	}


	public void setEvent_titie(String event_titie) {
		this.event_titie = event_titie;
	}


	public String getEvent_content() {
		return event_content;
	}


	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}


	public Timestamp getEvent_time() {
		return event_time;
	}


	public void setEvent_time(Timestamp event_time) {
		this.event_time = event_time;
	}


	public String getCondition() {
		return condition;
	}


	public void setCondition(String condition) {
		this.condition = condition;
	}


	public int getDiscount() {
		return discount;
	}


	public void setDiscount(int discount) {
		this.discount = discount;
	}


	public String getEvent_start() {
		return event_start;
	}


	public void setEvent_start(String event_start) {
		this.event_start = event_start;
	}


	public String getEvent_limit() {
		return event_limit;
	}


	public void setEvent_limit(String event_limit) {
		this.event_limit = event_limit;
	}
	
	public String getEvent_img() {
		return event_img;
	}


	public void setEvent_img(String event_img) {
		this.event_img = event_img;
	}
	public String getEvent_category() {
		return event_category;
	}

	public void setEvent_category(String event_category) {
		this.event_category = event_category;
	}
	
	

}
