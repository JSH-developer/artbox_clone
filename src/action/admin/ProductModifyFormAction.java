package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.ProductViewService;
import vo.ActionForward;
import vo.ProductBean;

public class ProductModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProductViewService productViewService = new ProductViewService();
		ProductBean productBean = productViewService.infoProduct(num);
		
		if(productBean != null) {
			forward = new ActionForward();
			forward.setPath("/admin/modifyProduct.jsp");
			
		}
		
		request.setAttribute("productBean", productBean);
		
		return forward;
	}

}
