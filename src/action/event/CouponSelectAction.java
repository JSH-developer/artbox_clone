package action.event;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import vo.ActionForward;
import vo.CouponBean;

public class CouponSelectAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String id = "jini";
		
		CouponService couponService = new CouponService();
		ArrayList<CouponBean> mycouponList= couponService.getmycouponlist(id);
		
		
		
		
		if(mycouponList != null) {
			System.out.println(id+"님 쿠폰 리스트 갖고옴");
			
			request.setAttribute("mycouponList", mycouponList);
			
			forward = new ActionForward();
			forward.setPath("/event/CouponSelect.jsp");
			
		}else {
			System.out.println("리스트 불러오기 실패");
		}
		
		return forward;
	}
	

}
