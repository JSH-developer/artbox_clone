package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.member.MemberDeleteService;
import svc.member.MemberLoginService;
import vo.ActionForward;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
//		System.out.println("MemberDelete / "+id+" / "+pw);
		
		MemberLoginService pwcheck = new MemberLoginService();
		int success = pwcheck.LoginSuccess(id, pw);
		
		if(success == 1) {
			MemberDeleteService MemberDeleteService = new MemberDeleteService();
			MemberDeleteService.MemberDelete(id);
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/Home.home");
			
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 틀림')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		return forward;
	}

}
