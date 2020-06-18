package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CategoryDeleteService;
import svc.OptionDeleteService;
import vo.ActionForward;

public class OptionDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page");
		
		OptionDeleteService optionDeleteService = new OptionDeleteService();
		boolean isDelete = optionDeleteService.deleteOption(num);
		
		if(isDelete) {
			
			forward = new ActionForward();
			forward.setPath("/OptionList.admin?page="+page);
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('삭제에 실패 하였습니다!!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
