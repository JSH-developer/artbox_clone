package action.admin;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.OptionDeleteService;
import svc.admin.ProductDeleteService;
import vo.ActionForward;

public class ProductDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		// 상품 인덱스, 페이지 , 상품코드 받아오기
		int num = Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page");
		String option_code = request.getParameter("option_code");
		
		ProductDeleteService productDeleteService = new ProductDeleteService();
		boolean isDelete = productDeleteService.deleteProduct(num); //svc에서 상품삭제 수행
		
		// 상품 삭제시 옵션도 같이 삭제
		OptionDeleteService optionDeleteService = new OptionDeleteService();
		boolean isDelete2 = optionDeleteService.deleteOption(option_code); //svc에서 옵션삭제 수행
		
		if(isDelete && isDelete2) { // 두가지 삭제 모두 성공 시
			forward = new ActionForward();
			forward.setPath("/ProductList.admin?page="+page);
		}else { // 실패시 alert 생성
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
