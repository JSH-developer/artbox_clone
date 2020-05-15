package vo;

public class ActionForward {
	/*
	 * 서블릿에서 클라이언트로부터 요청을 받아 처리 후 View 페이지로 포워딩 할 때
	 * 이동할 View 페이지의 URL와 포워딩 방식을 다루기 위한 클래스
	 */
	
	private String path; // 포워딩할 View 페이지의 URL을 저장할 변수
	private boolean redirect; // 포워딩 방식을 저장할 변수 (true : redirect, false : Dispatch) 
	
	public String getPath() {
		return path;
	}
	
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return redirect;
	}
	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
	
}
