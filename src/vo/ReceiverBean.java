package vo;

public class ReceiverBean {
	private int receiver_num; // receiver의 인덱스
	private String receiver; // 배송지명(자택, 회사..)
	private String receiver_name; // 수신자 이름
	private String receiver_phone; // 수신자 폰번호
	private String receiver_postcode; // 수신자 우편번호
	private String receiver_addr; // 수신자 기본주소
	private String receiver_addr_detail; // 수신자 상세주소
	private String receiver_msg; // 배송메세지
	private String receiver_date; // 배송지 저장날짜
	private String receiver_member_id; // member 테이블의 id(아이디)
	private int receiver_basic_num; // 기본배송지 여부

	public int getReceiver_num() {
		return receiver_num;
	}
	public void setReceiver_num(int receiver_num) {
		this.receiver_num = receiver_num;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
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
	public String getReceiver_msg() {
		return receiver_msg;
	}
	public void setReceiver_msg(String receiver_msg) {
		this.receiver_msg = receiver_msg;
	}
	public String getReceiver_date() {
		return receiver_date;
	}
	public void setReceiver_date(String receiver_date) {
		this.receiver_date = receiver_date;
	}
	public String getReceiver_member_id() {
		return receiver_member_id;
	}
	public void setReceiver_member_id(String receiver_member_id) {
		this.receiver_member_id = receiver_member_id;
	}
	public int getReceiver_basic_num() {
		return receiver_basic_num;
	}
	public void setReceiver_basic_num(int receiver_basic_num) {
		this.receiver_basic_num = receiver_basic_num;
	}
	
}
