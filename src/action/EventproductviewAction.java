package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.admin.Action;
import svc.CouponService;
import svc.admin.ProductViewService;
import vo.ActionForward;
import vo.CouponBean;
import vo.ProductBean;

public class EventproductviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		CouponService couponService = new CouponService();
		
		
		ArrayList<CouponBean> couponList = couponService.getCouponAllList();
		
		request.setAttribute("couponList", couponList);
		
		// 상품 불러오기
		ProductBean productBean = null;
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		
		ProductViewService productViewService = new ProductViewService();
		productBean = productViewService.infoProduct(product_num);
		
		
		request.setAttribute("productBean", productBean);
		request.setAttribute("product_num", product_num);
		
		forward = new ActionForward();
		forward.setPath("event/productView.jsp");
		
		return forward;
	}

}
