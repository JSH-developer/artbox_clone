package vo;

public class PrintCategory {
	
	private String category;
	private String code;
	
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	
	
	public String[] 인형토이() {
		String[] toy = {"FUN/TOY","PARTY","쿠션인형","미니인형","DIY취미","피규어"};		
		return toy;
	}
	
	public String[] 문구() {
		String[] stationery = {"다이어리/플래너","캘린더","노트/메모","점착메모지","필기구","필통","파일","스티커/스탬프","데스크소품","카드/편지지","앨범","선물포장"};
		return stationery;
	}
	
	public String[] 패션() {
		String[] fasion = {"지갑/파우치","가방","우산","장갑양말","패션잡화","키링/뱃지/와펜","타투스티커","슬리퍼","여름시즌소품"};
		return fasion;
	}
	
	public String[] 주방욕실(){
		String[] kitchen = {"텀블러","컵/머그/잔","술잔","도시락","기타주방용품","푸드","칫솔케이스/살균기","욕실용품"};
		return kitchen;
	}
	
	public String[] 리빙데코() {
		String[] deco = {"시계","조명","디퓨저/방향제","거울","방석/쿠션","담요","인테리어소품","패브릭소품","생활소품"};
		return deco;
	}
	
	public String[] 디지털가전() {
		String[] digital = {"알뜰폰요금제","고데기/드라이어","PC액세서리","가습기","스마트폰액세서리","스피커/이어폰/액세서리","보조배터리","기타생활가전","USB"};
		return digital;
	}
	
	public String[] 여행() {
		String[] trip = {"캐리어/트래블백","여행용품","여권케이스러기지택","여행용파우치","차량용품","핫팩"};
		return trip;
	}
	
	public String[] 뷰티() {
		String[] beauty = {"미용소품","마스크/팩","헤어/바디케어용품","스킨케어","메이크업"};
		return beauty;
	}

}
