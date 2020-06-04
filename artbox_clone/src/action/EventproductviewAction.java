package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CouponService;
import vo.ActionForward;
import vo.CouponBean;

public class EventproductviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		CouponService couponService = new CouponService();
		
		
		ArrayList<CouponBean> couponList = couponService.getCouponAllList();
		
		request.setAttribute("couponList", couponList);
		
		
		
		forward = new ActionForward();
		forward.setPath("event/productView.jsp");
		
		
		return forward;
	}

}
