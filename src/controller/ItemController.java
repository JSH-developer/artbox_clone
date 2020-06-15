package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import item.action.CategoryLinkAction;
import item.action.ItemDetailAction;
import item.action.QuestionListAction;
import item.action.QuestionWriteAction;
import item.action.UploadTestAction;
import vo.ActionForward;


@WebServlet("*.item")
public class ItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();
		// 경로 추적하기위해 출력중
		System.out.println(command);
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/itemList.item")) {
			action = new CategoryLinkAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/itemDetail.item")) {
			action = new ItemDetailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/questionWrite.item")) {
			action = new QuestionWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/questionList.item")) {
			action = new QuestionListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/uploadtest.itme")) {
			action = new UploadTestAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(forward != null) {
			if(forward.isRedirect()) { 
				response.sendRedirect(forward.getPath());
			}else { 
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
