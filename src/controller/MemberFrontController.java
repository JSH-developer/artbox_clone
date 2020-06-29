package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import action.member.Action;
import action.member.MemberCheckAction;
import action.member.MemberDeleteAction;
import action.member.MemberDeliveryAddAction;
import action.member.MemberJoinAction;
import action.member.MemberJoinCheckAction;
import action.member.MemberLoginAction;
import action.member.MemberPwModifyAction;
import action.member.MemberModifyAction;
import action.member.memberProfileAction;
import action.member.receiverList;
import vo.ActionForward;

@WebServlet("*.member")
public class MemberFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings({ "unchecked" })
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	
    	String command = request.getServletPath();
    	Action action = null;
    	ActionForward forward = null;
    	
    	if(command.equals("/memberJoinForm.member")) {
    		forward = new ActionForward();
    		forward.setPath("/member/join.jsp");
    		
    	}else if(command.equals("/joinPro.member")) {
    		
    		action = new MemberJoinAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/reidCheck.member")) {
    		String id = request.getParameter("id");
    		MemberCheckAction idcheckAction = new MemberCheckAction();
    		boolean booleanid = idcheckAction.execute(id);
    		
    		JSONObject idcheck = new JSONObject();
    		idcheck.put("data", booleanid);
    		
    		PrintWriter writer = response.getWriter();
    		
    		writer.print(idcheck);
    		writer.flush();
    		writer.close();
    		
    	} else if(command.equals("/loginForm.member")) {
    		forward = new ActionForward();
    		forward.setPath("/member/Login.jsp");
    		
    	} else if(command.equals("/loginPro.member")){
    		String id = request.getParameter("id");
    		String pw = request.getParameter("pw");
    		MemberLoginAction checkAction = new MemberLoginAction();
    		
    		int id_pw_check = checkAction.execute(id, pw,request );
    		
    		JSONObject idcheck = new JSONObject();
    		idcheck.put("data", id_pw_check);
    		
    		PrintWriter writer = response.getWriter();
    		
    		writer.print(idcheck);
    		writer.flush();
    		writer.close();
    	} else if (command.equals("/login.member")) {
    		forward = new ActionForward();
    		forward.setRedirect(true);
    		forward.setPath("/artbox_clone/Home.home");
    		
    	} else if(command.equals("/findId.member")) {
    		forward = new ActionForward();
    		forward.setPath("/member/findId.jsp");

    		
    		
    	}else if(command.equals("/myPageOrders.member")) { // myPageOrders
    		forward = new ActionForward();
    		forward.setPath("/member/myPageOrders.jsp");
    		
    	}else if(command.equals("/myPageRe.member")) { // myPageRe
    		forward = new ActionForward();
    		forward.setPath("/member/myPageRe.jsp");
    		
    	}else if(command.equals("/myPageWishlist.member")) { // myPageWishlist
    		forward = new ActionForward();
    		forward.setPath("/member/myPageWishlist.jsp");
    		
    	}else if(command.equals("/myPageQ&A.member")) { ///myPageQ&A
    		forward = new ActionForward();
    		forward.setPath("/member/myPageQ&A.jsp");
    		
    	}else if(command.equals("/myPageQuestion.member")) { //myPageQuestion
    		forward = new ActionForward();
    		forward.setPath("/member/myPageQuestion.jsp");
    	}else if(command.equals("/profileChange.member")) {
    		forward = new ActionForward();
    		forward.setPath("/member/profileChange.jsp");
    	}else if(command.equals("/profile.member")) {
    		
    		action = new memberProfileAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/logout.member")) {
    		HttpSession session = request.getSession();
    		session.invalidate();
    		forward = new ActionForward();
    		forward.setRedirect(true);
    		forward.setPath("/artbox_clone/Home.home");
    	}else if (command.equals("/home.member")) {
    		forward = new ActionForward();
    		forward.setRedirect(true);
    		forward.setPath("/artbox_clone/Home.home");
    	}else if(command.equals("/delivery.member")) {
    		action = new receiverList();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/MyPageDeliveryAdd.member")) {
    		forward = new ActionForward();
    		forward.setPath("/member/myPageDeliveryAdd.jsp");
    	}else if(command.equals("/pwProModify.member")) {
    		action = new MemberPwModifyAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/deliveryAdd.member")) {
    		action = new MemberDeliveryAddAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/modifySuccess.member")) {
    		action = new MemberModifyAction();
    		try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if(command.equals("/memberDelete.member")) {
    		forward = new ActionForward();
    		forward.setPath("/member/memberDelete.jsp");
    	}else if(command.equals("/deleteCheck.member")) {
    		action = new MemberDeleteAction();
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