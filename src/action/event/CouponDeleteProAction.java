package action.event;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import vo.ActionForward;

public class CouponDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = null;
		
		String coupon_num =request.getParameter("coupon_num");
		
		CouponService couponService = new CouponService();
		Boolean isDelete = couponService.deleteCoupon(coupon_num);
		
		
		if(!isDelete) {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('쿠폰 삭제 실패')");
			out.println("history.back()"); 
			out.println("</script>");
			
		}else {
			System.out.println("글삭제성공!");
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("listCoupon.coupon");
			
		}
		
		
		return forward;
	}

}
