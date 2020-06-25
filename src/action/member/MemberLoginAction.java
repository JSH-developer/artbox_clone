package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import svc.member.MemberBeanService;
import svc.member.MemberLoginService;
import vo.MemberBean;

public class MemberLoginAction {

	public int execute(String id, String pw, HttpServletRequest request) {
		System.out.println("MemberLoginAction");
		MemberLoginService MemberLoginService = new MemberLoginService();
		
		int dbid = MemberLoginService.LoginSuccess(id, pw);
		if(dbid == 1) {
			MemberBeanService MemberBeanService = new MemberBeanService();
			
			
			MemberBean bb = MemberBeanService.myName(id);
			String name = bb.getName();
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			session.setAttribute("id", id);
			System.out.println(name);
		}
		
		return dbid;
	}
	
	

}
