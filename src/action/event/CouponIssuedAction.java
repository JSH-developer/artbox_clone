package action.event;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import vo.ActionForward;

public class CouponIssuedAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		String getid = request.getParameter("getid");
		int getCouponNum = Integer.parseInt(request.getParameter("couponNum"));
		
		CouponService couponService = new CouponService();
		Boolean isSuceess = couponService.couponIssued(getid,getCouponNum);
		
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(!isSuceess) {
	
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('쿠폰 발급 실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그

			System.out.println("쿠폰 등록 실패!");


		}else {
			System.out.println("쿠폰 발급받기 성공");
			
			out.println("<script>");
			out.println("if(confirm('쿠폰을 확인하시겠습니까?'))");
			out.println("{location.href='MypageCouponList.coupon';}");
			out.println("else");
			out.println("{history.back()}");
			out.println("</script>");
			out.close();


//			forward = new ActionForward();
//			forward.setPath("MypageCouponList.coupon");
			
			
			
			
		}
		
		return forward;
	}

}
