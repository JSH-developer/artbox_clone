package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import vo.ActionForward;

/**
 * Servlet implementation class HomeFrontController
 */
@WebServlet("*.home")
public class HomeFrontController extends HttpServlet {
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	String command = request.getServletPath();
	
	Action action = null;
	ActionForward forward = null;

// 쿠폰 등록 입력
	if(command.equals("/Home.home")){
		System.out.println("/Home.home");
//		view로 이동할것임
		// 글쓰기 페이지 요청은 비즈니스 로직이 없는 View 페이지(jsp)로 바로 연결 수행
		// => ActionForward 객체의 포워딩 방식을 별도로 설정하지 않음(주소변경 x)
		forward = new ActionForward();
//		forward.setRedirect(false); // 포워딩 박식을 Dispatcher 방식으로 설정(기본값 생략 가능)
		forward.setPath("/home/home.jsp"); // 이동할 View 페이지 경로 지정
		
// 쿠폰 등록 Pro
	}
       
	// ActionForward 객체 내의 포워딩 방식에 따라 각각의 포워딩 작업 수행
	if(forward != null) {
		
		if(forward.isRedirect()) { // redirect 방식
			response.sendRedirect(forward.getPath());
		}else { // dispatcher 방식
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
			dispatcher.forward(request, response);
		}
		
	}
	
	
	
}	

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doProcess(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doProcess(request, response);
}

}
