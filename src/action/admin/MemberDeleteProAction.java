package action.admin;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.MemberDeleteService;
import svc.admin.ProductDeleteService;
import vo.ActionForward;

public class MemberDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page");
		String opt = request.getParameter("opt"); 
		String kwd = request.getParameter("kwd"); 
		
		
		MemberDeleteService memberDeleteService = new MemberDeleteService();
		boolean isDelete = memberDeleteService.deleteMember(num);
		
		if(isDelete) {
			forward = new ActionForward();
			forward.setPath("/MemberList.admin?page="+page+"&opt="+opt+"&kwd="+kwd);
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('삭제에 실패하였습니다!!')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}

}
