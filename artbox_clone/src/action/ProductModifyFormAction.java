package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ProductViewService;
import vo.ActionForward;
import vo.ProductBean;

public class ProductModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		
		ProductViewService productViewService = new ProductViewService();
		ProductBean productBean = productViewService.infoProduct(product_num);
		
		if(productBean != null) {
			forward = new ActionForward();
			forward.setPath("/admin/modifyProduct.jsp");
			
		}
		
		request.setAttribute("productBean", productBean);
		
		return forward;
	}

}
