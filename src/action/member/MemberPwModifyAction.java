package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberCheckService;
import svc.member.MemberPwModifyService;
import vo.ActionForward;

public class MemberPwModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("MemberPwModifyAction"); //잘 옴
		ActionForward forward = null;
		String id = request.getParameter("id");
		String nowpw = request.getParameter("nowpw");
		String newpw = request.getParameter("newpw");
		String newrepw = request.getParameter("newrepw");
//		System.out.println(id+"/"+nowpw+"/"+newpw+"/"+newrepw); // 잘 옴
		
		MemberCheckService MemberCheckService = new MemberCheckService();
		boolean pwcheck = MemberCheckService.profileCheck(id,nowpw);
		if(pwcheck) {
			MemberPwModifyService MemberPwModifyService = new MemberPwModifyService();
			MemberPwModifyService.MemberPwModify(id,newpw);
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('성공적으로 변경됨')");
			out.println("</script>");
			
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
