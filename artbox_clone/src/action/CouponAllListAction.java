package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CouponService;
import svc.EventService;
import vo.ActionForward;
import vo.CouponBean;
import vo.EventBean;
import vo.PageInfo;

public class CouponAllListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		CouponService couponService = new CouponService();
		
		
		ArrayList<CouponBean> couponList = couponService.getCouponAllList();
		
		request.setAttribute("couponList", couponList);
		
		forward = new ActionForward();
		forward.setPath("/event/registCoupon.jsp");
		
		
		return forward;
	}

}
