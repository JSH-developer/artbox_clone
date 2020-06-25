package action.admin;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.CategoryDeleteService;
import svc.admin.ProductDeleteService;
import vo.ActionForward;

public class CategoryDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page");
		
		CategoryDeleteService categoryDeleteService = new CategoryDeleteService();
		boolean isDelete = categoryDeleteService.deleteCategory(num);
		
		if(isDelete) {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('삭제가 완료 되었습니다!!')");
			out.println("location.href='CategoryList.admin?page="+page+"'");
			out.println("</script>");
			
//			forward = new ActionForward();
//			forward.setPath("/CategoryList.admin?page="+page);
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('삭제에 실패 하였습니다. 상품이 연동되어있는지 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
