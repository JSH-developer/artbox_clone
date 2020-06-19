package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminChangeStateService;
import vo.ActionForward;

public class AdminChangeStateProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward= null;
		
		int state = Integer.parseInt(request.getParameter("state"));
		int num = Integer.parseInt(request.getParameter("num"));
		
		AdminChangeStateService adminChangeStateService = new AdminChangeStateService();
		boolean isChange = adminChangeStateService.changeState(state, num);
		
		if(isChange) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('변경에 성공하였습니다!!');");
			out.println("opener.location.reload();"); 
			out.println("window.close();");
			out.println("</script>");
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('변경에 실패하였습니다!!')");
			out.println("</script>");
		}
		
		
		
		
		return forward;
	}

}
