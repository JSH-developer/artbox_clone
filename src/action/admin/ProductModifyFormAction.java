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
		
		int num = Integer.parseInt(request.getParameter("num")); // svc에 전달할 Product 인덱스 값
		
		ProductViewService productViewService = new ProductViewService();
		ProductBean productBean = productViewService.infoProduct(num); // svc에서 상품정보 ProductBean으로 받아옴
		
		if(productBean != null) {
			forward = new ActionForward();
			forward.setPath("/admin/modifyProduct.jsp");
			
		}
		
		// request에 값 저장
		request.setAttribute("productBean", productBean);
		
		return forward;
	}

}
