package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.ProductViewService;
import vo.ActionForward;
import vo.ProductBean;

public class ProductViewProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		ProductBean productBean = null;
		
		int product_num = Integer.parseInt(request.getParameter("num")); // svc에 전달할 product 인덱스
		
		ProductViewService productViewService = new ProductViewService();
		productBean = productViewService.infoProduct(product_num); // svc에서 상품정보 담긴 ProductBean 반환
		
		// request에 값 저장
		request.setAttribute("productBean", productBean);
		request.setAttribute("product_num", product_num);
		
		forward.setPath("/admin/viewProduct.jsp");
		return forward;		
	}

}
