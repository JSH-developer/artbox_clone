package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ProductViewProService;
import vo.ActionForward;
import vo.ProductBean;

public class ProductViewProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		ProductBean productBean = null;
		
		int product_num = Integer.parseInt(request.getParameter("num"));
		
		ProductViewProService productViewProService = new ProductViewProService();
		productBean = productViewProService.infoProduct(product_num);
		request.setAttribute("productBean", productBean);
		request.setAttribute("product_num", product_num);
		
		forward.setPath("/admin/viewProduct.jsp");
		return forward;		
	}

}
