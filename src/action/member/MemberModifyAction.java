package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberModifyService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("MemberModifyAction");
		MemberBean mb = new MemberBean();
		mb.setId(request.getParameter("id"));
		mb.setGender(request.getParameter("gender"));
		mb.setBirth(request.getParameter("birth"));
		mb.setPostcode(request.getParameter("postcode"));
		mb.setAddr_basic(request.getParameter("addr_basic"));
		mb.setAddr_detail(request.getParameter("addr_detail"));
		mb.setEmail(request.getParameter("email"));
		mb.setPhone(request.getParameter("phone"));
		
		MemberModifyService MemberModifyService = new MemberModifyService();
		int success = MemberModifyService.MemberUpdate(mb);
		
//		response.setContentType("text/html;charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		out.println("<script>");
//		out.println("alert('성공적으로 변경됨')");
//		out.println("</script>");
		
//		if(success == 1) {
		forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("/artbox_clone/Home.home");
//		}
		
		
		
		return forward;
	}

}
