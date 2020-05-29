package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberLoginService;
import vo.ActionForward;

public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginAction");
		ActionForward forward = null;
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
//		System.out.println(id +", "+pw);
		
		MemberLoginService MemberLoginService = new MemberLoginService();
		
		boolean LoginSuccess = MemberLoginService.LoginSuccess(id, pw);
		
		
		return forward;
	}

}
