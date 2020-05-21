package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.CategoryLinkAction;
import action.ItemDetailAction;
import vo.ActionForward;


@WebServlet("*.item")
public class ItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();
		Action action = null;
		ActionForward fw = null;
		
		if(command.equals("itemList.item")) {
			action = new CategoryLinkAction();
			fw = action.execute(request, response);
		}else if(command.equals("itemDetail.item")) {
			action = new ItemDetailAction();
			fw = action.execute(request, response);
		}
		
		
		
		
		
		if(fw != null) {
			
			if(fw.isRedirect()) { 
				response.sendRedirect(fw.getPath());
			}else { 
				RequestDispatcher dispatcher = request.getRequestDispatcher(fw.getPath());
				dispatcher.forward(request, response);
			}
			
		}
		
	}

   
    

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			doProcess(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			doProcess(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
