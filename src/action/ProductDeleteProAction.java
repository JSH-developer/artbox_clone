package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ProductDeleteService;
import vo.ActionForward;

public class ProductDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page");
		
		ProductDeleteService productDeleteService = new ProductDeleteService();
		boolean isDelete = productDeleteService.deleteProduct(num);
		
		if(isDelete) {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('삭제가 완료 되었습니다!!')");
			out.println("</script>");
			
			forward = new ActionForward();
			forward.setPath("/ProductList.admin?page="+page);
		}else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./home.admin");
		}
		
		return forward;
	}

}
