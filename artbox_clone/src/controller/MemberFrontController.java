package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import action.Action;
import action.MemberJoinAction;
import action.MemberJoinCheckAction;
import action.MemberLoginAction;
import vo.ActionForward;

@WebServlet("*.member")
public class MemberFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	
    	String command = request.getServletPath();
    	System.out.println(command);
    	Action action = null;
    	ActionForward forward = null;
    	
    	if(command.equals("#")) {
    		forward = new ActionForward();
    		forward.setPath("/member/join.jsp");
    		
    	}else if(command.equals("/member/joinPro.member")) {
    		
    		action = new MemberJoinAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/member/reidCheck.member")) {
    		String id = request.getParameter("id");
    		MemberJoinCheckAction idcheckAction = new MemberJoinCheckAction();
    		boolean booleanid = idcheckAction.execute(id);
    		
    		JSONObject idcheck = new JSONObject();
    		
    		idcheck.put("data", booleanid);
    		
    		PrintWriter writer = response.getWriter();
    		
    		writer.print(idcheck);
    		writer.flush();
    		writer.close();
    		
    	} else if(command.equals("/member/loginPro.member")) {
    		action = new MemberLoginAction();
    		
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
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

}
