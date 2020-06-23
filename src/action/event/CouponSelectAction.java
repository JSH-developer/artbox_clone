package action.event;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import svc.OrderOneListService;
import vo.ActionForward;
import vo.CouponBean;

public class CouponSelectAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String id = "jini";
		
//		String arrBasket = request.getParameter("arrBasket");
//		System.out.println("가져온값" + arrBasket);
		
//		OrderOneListService orderOneListService = new OrderOneListService();
//		List orderList = orderOneListService.getOrderOneList(id, arrBasket);
		
		
		ArrayList<String> orderList = new ArrayList<String>();
		orderList.add("DT01"); //값 추가
		orderList.add("DT02"); //null값도 add가능
		orderList.add("DT03"); //index 1뒤에 10 삽입
		request.setAttribute("orderList", orderList);
		
		
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
