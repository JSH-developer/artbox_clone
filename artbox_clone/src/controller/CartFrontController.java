package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.CartAddAction;
import action.CartListAction;
import vo.ActionForward;

@WebServlet("*.cart")
public class CartFrontController extends HttpServlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String command = request.getServletPath();
		
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/productDetail.cart")) {
			forward = new ActionForward();
			forward.setPath("/item/itemDetail.jsp");
		} else if(command.equals("/addCart.cart")) {
			// BoardWriteProAction 클래스 인스턴스 생성 => Action 타입으로 업캐스팅
			action = new CartAddAction();
			// 공통 메서드인 execute() 메서드를 호출하여 request, response 객체 전달
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/listCart.cart")) {
			// BoardWriteProAction 클래스 인스턴스 생성 => Action 타입으로 업캐스팅
			action = new CartListAction();
			// 공통 메서드인 execute() 메서드를 호출하여 request, response 객체 전달
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
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
