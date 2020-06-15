package vo;

public enum MajorCategory {

	인형토이("DT"),문구("FA"),패션("FS"),주방욕실("KB"),리빙데코("LD"),디지털가전("DI"),여행("TR"),뷰티("BE");
	
	
	final private String code;

	public String getCode() {
		return code;
	}

	private MajorCategory(String code) {
		this.code = code;
	}
	
	
}
