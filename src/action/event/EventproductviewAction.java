package action.event;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import svc.admin.ProductViewService;
import vo.ActionForward;
import vo.CouponBean;
import vo.ProductBean;

public class EventproductviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		// 조건 불러오기
		String condition = request.getParameter("condition");
		
		
		// 상품에 맞는 쿠폰
		CouponService couponService = new CouponService();
		CouponBean itemcoupon = couponService.getCouponList(condition);
		request.setAttribute("itemcoupon", itemcoupon);
		
		
		// 상품 불러오기
		ProductBean productBean = null;
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		ProductViewService productViewService = new ProductViewService();
		productBean = productViewService.infoProduct(product_num);
		
		
		request.setAttribute("item", productBean);
		request.setAttribute("product_num", product_num);
		
		forward = new ActionForward();
		forward.setPath("event/productView.jsp");
		
		return forward;
	}

}
