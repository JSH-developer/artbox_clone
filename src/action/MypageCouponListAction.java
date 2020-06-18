package action;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;

import svc.CouponService;
import vo.ActionForward;
import vo.CouponBean;

public class MypageCouponListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(request.getParameter("ActionForward"));
		
		ActionForward forward = new ActionForward();
		
		ServletContext context = request.getServletContext();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");

		
		CouponService couponService = new CouponService();
		ArrayList<CouponBean> mycouponList= couponService.getmycouponlist(id);
		
		
		
		if(mycouponList != null) {
			System.out.println("리스트 갖고오긴 함");
			
			request.setAttribute("mycouponList", mycouponList);
			
			forward = new ActionForward();
			forward.setPath("/event/myPageCoupon.jsp");
			
		}else {
			System.out.println("리스트 불러오기 실패");
		}
	
		
		return forward;
	}

}
