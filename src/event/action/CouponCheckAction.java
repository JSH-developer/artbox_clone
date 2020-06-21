package event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import vo.ActionForward;

public class CouponCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = request.getParameter("getid");
		String couponName = request.getParameter("couponName");
		
		CouponService cService = new CouponService();
		int check = cService.selectCouponCheck(id,couponName);
		
		
//		return null;
		response.getWriter().write(check+"");
		return null;
	}

}
