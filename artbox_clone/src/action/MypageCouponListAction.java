package action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CouponService;
import vo.ActionForward;

public class MypageCouponListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(request.getParameter("ActionForward"));
		
		ActionForward forward = new ActionForward();
		
		ServletContext context = request.getServletContext();
		
		String id = "jini";
		
		CouponService couponService = new CouponService();
		int isSuccess = couponService.getcouponlist(id);
		
		if(isSuccess>0) {
			
			
			
		}else {
			
		}
		
		
		return null;
	}

}
