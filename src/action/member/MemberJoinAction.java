package action.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberJoinService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberJoinAction");

		ActionForward forward = null;

		MemberJoinService service = new MemberJoinService();
		MemberBean bb = new MemberBean();
		
		String id = request.getParameter("id"); //
		String pw = request.getParameter("pw"); //
		String name = request.getParameter("name");
		String postcode = request.getParameter("postcode");
		String addr_basic = request.getParameter("addr_basic");
		String addr_detail = request.getParameter("addr_detail");
		String email = request.getParameter("email"); //
		String phone = request.getParameter("phone"); //
		String gender = request.getParameter("gender");
		String birth = request.getParameter("birth"); //
		

			bb.setId(id);
			bb.setPw(pw);
			bb.setName(name);
			bb.setPostcode(postcode);
			bb.setAddr_basic(addr_basic);
			bb.setAddr_detail(addr_detail);
			bb.setEmail(email);
			bb.setPhone(phone);
			bb.setGender(gender);
			bb.setBirth(birth);



			boolean joinSuccess = service.JoinSuccess(bb);
//			System.out.println("joinSuccess ??"+joinSuccess);
			
			
			if(!joinSuccess) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();

				out.println("<script>");
				out.println("alert('글 등록 실패')");
				out.println("history.back()");
				out.println("</script>");

			}else {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();

				System.out.println("글 등록 성공");
				forward = new ActionForward();
				forward.setPath("/Main.jsp");
			}




		return forward;
	}

	
}
