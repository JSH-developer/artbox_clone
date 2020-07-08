package action.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.admin.AdminOrderViewService;
import svc.member.MemberCheckService;
import svc.member.MyPageOrdersService;
import vo.ActionForward;
import vo.MemberBean;
import vo.OrdersBean;
import vo.OrdersDetailBean;
import vo.ReceiverBean;

public class MyPageOrdersDetailProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		// svc에 전달할 주문인덱스, 주문코드 받아오기
		int orders_num = Integer.parseInt(request.getParameter("num"));
		String orders_order_num = request.getParameter("orders_num");
		
		AdminOrderViewService adminOrderViewService = new AdminOrderViewService();
		List<OrdersDetailBean> myDetailOrders = adminOrderViewService.infoOrdersDetail(orders_order_num);
		// svc에서 ArrayList 받아오기
		
		OrdersBean ordersBean = null;
		ReceiverBean receiverBean = null;
		
		AdminOrderViewService orderViewService = new AdminOrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num); // svc에서 OrdersBean 받아오기
		receiverBean = orderViewService.infoReceiver(myDetailOrders.get(0).getReceiver_num()); // svc에서 ReceiverBean 받아오기
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		MyPageOrdersService myPageOrdersService = new MyPageOrdersService();
		MemberBean bb = myPageOrdersService.myPoint(id);
		int orderCount = myPageOrdersService.orderCount(id);
		int coupCount = myPageOrdersService.coupCount(id);
		int reviewCount = myPageOrdersService.reviewCount(id);
		
		request.setAttribute("point", bb.getPoint());
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("coupCount", coupCount);
		request.setAttribute("reviewCount", reviewCount);
		
		// request에 저장
		request.setAttribute("myDetailOrders", myDetailOrders);
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("receiverBean", receiverBean);
		
		forward.setPath("/member/myPageOrdersDetail.jsp");
		return forward;
	}


}
