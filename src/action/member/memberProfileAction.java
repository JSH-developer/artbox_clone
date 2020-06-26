package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberCheckService;
import vo.ActionForward;

public class memberProfileAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("memberProfileAction");
		ActionForward forward = null;
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		System.out.println("아이디 값 : "+id);
		System.out.println("패스워드 값 : "+pw);
		
		MemberCheckService MemberCheckService = new MemberCheckService();
		boolean pwcheck = MemberCheckService.profileCheck(id, pw);
		
		if(pwcheck) {
		forward = new ActionForward();
		forward.setPath("/member/modify.jsp");
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
