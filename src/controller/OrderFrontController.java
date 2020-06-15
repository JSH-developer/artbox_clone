package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.OrderAllListAction;
import action.OrderOneListAction;
import vo.ActionForward;

@WebServlet("*.order")
public class OrderFrontController extends HttpServlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String command = request.getServletPath();
		
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/order.order")) {
			forward = new ActionForward();
			forward.setPath("/cart/OrderPay.jsp");
		} else if(command.equals("/orderOne.order")) {
			action = new OrderOneListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/orderAll.order")) {
			action = new OrderAllListAction();
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
