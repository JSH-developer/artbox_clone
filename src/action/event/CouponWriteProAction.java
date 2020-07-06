package action.event;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import vo.ActionForward;
import vo.CouponBean;

public class CouponWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 쿠폰 리스트 작성 aciton
		ActionForward forward = new ActionForward();

		CouponBean couponBean = new CouponBean();
		couponBean.setCoupon_name(request.getParameter("coupon_name"));
		couponBean.setCoupon_price(Integer.parseInt(request.getParameter("coupon_price")));
		
		String coup_condition = request.getParameter("coupon_p_condition");
		System.out.println("condition: "+coup_condition);
		System.out.println("p_condition: "+request.getParameter("coupon_p_condition"));
		
		if(coup_condition != null) {
			System.out.println("안들어오나?");
			couponBean.setCoupon_condition(request.getParameter("coupon_p_condition"));
		}else {
			System.out.println("0아닐때");
			couponBean.setCoupon_condition(request.getParameter("coupon_condition"));
		}
		
		couponBean.setCoupon_start(request.getParameter("coupon_start"));
		couponBean.setCoupon_limit(request.getParameter("coupon_limit"));
		couponBean.setCoupon_reason(request.getParameter("coupon_reason"));
		couponBean.setCoupon_category(request.getParameter("coupon_category"));

		// 쿠폰 등록
		CouponService couponService = new CouponService();
		boolean isRegist = couponService.registCoupon(couponBean);

		if(isRegist) {
			System.out.println("쿠폰 등록 성공 -"+request.getParameter("coupon_name"));

			forward = new ActionForward();
			forward.setPath("/listCoupon.coupon");


		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('쿠폰 등록 실패!')"); // 다이얼로그 메세지 출력
//			out.println("history.back()"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그

			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("listCoupon.coupon");
		}


		return forward;
	}

}
