package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberFindId;
import vo.ActionForward;
import vo.MemberBean;

public class MemberFindIdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("MemberFindIdAction");
		
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		MemberBean bb = new MemberBean();
		bb.setName(name);
		bb.setPhone(phone);
		bb.setEmail(email);
		
		MemberFindId MemberFindId = new MemberFindId();
		String id = MemberFindId.findId(bb);
		
		if(id != null) {
			request.setAttribute("id", id);
			forward = new ActionForward();
			forward.setPath("findId.member");
		
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter(); 
			out.println("<script>");
			out.println("alert('존재하지않는 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		
		
		
		
		return forward;
	}

}
