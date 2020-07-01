package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.admin.BestItemAction;
import action.admin.CategoryWriteProAction;
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

	if(command.equals("/Home.home")){
		action = new BestItemAction();
		try {
			forward = action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
       
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
