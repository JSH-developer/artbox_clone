package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.member.MemberCheckService;
import svc.member.MyPageBuyService;
import svc.member.MyPageOrdersService;
import vo.ActionForward;
import vo.OrdersBean;

public class MyPageBuyProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		// svc에 전달할 주문번호, 포인트, 아이디 받아오기
		String orders_order_num = request.getParameter("orders_order_num");
		int point = Integer.parseInt(request.getParameter("point"));
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageBuyService myPageBuyService = new MyPageBuyService();
		myPageBuyService.changeBuyState(orders_order_num); // svc에서 구매확정 수행
		myPageBuyService.changeBuyPoint(point, id); // svc에서 포인트 적립 수행
		myPageBuyService.changeGrade(id);// svc에서 등급변경 수행
		
		MyPageOrdersService myPageOrdersService = new MyPageOrdersService();
		List<OrdersBean> myOrders = myPageOrdersService.getMyOrders(id); // svc에서 ArrayList받아오기
		
		// request에 값 저장
		request.setAttribute("myOrders", myOrders);
		
		forward.setPath("/member/myPageOrders.jsp");
		return forward;
	}


}
