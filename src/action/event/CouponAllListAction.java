package action.event;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import svc.admin.ProductWriteService;
import vo.ActionForward;
import vo.CouponBean;

public class CouponAllListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 모든 쿠폰 불러오는 action - admin
		ActionForward forward = null;
		
		// 저장된 쿠폰 리스트 불러오기
		CouponService couponService = new CouponService();
		ArrayList<CouponBean> couponList = couponService.getCouponAllList();
		request.setAttribute("couponList", couponList);
		
		// 카테고리 불러오기
		ProductWriteService productWriteService = new ProductWriteService();
		String categorySelectList = productWriteService.categorySelectList();
		request.setAttribute("categorySelectList", categorySelectList);
		
		
		forward = new ActionForward();
		forward.setPath("/event/listCoupon.jsp");
		
		
		return forward;
	}

}
