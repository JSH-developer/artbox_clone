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
			String grade = bb.getGrade();
			int point = bb.getPoint();
			
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			session.setAttribute("id", id);
			session.setAttribute("grade", grade);
			session.setAttribute("mpoint", point);
			System.out.println(grade);
			System.out.println(name);
		}
		
		return dbid;
	}
	
	

}
