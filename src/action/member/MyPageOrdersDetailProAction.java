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
import vo.OrdersBean;
import vo.OrdersDetailBean;
import vo.ReceiverBean;

public class MyPageOrdersDetailProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		int orders_num = Integer.parseInt(request.getParameter("num"));
		String orders_order_num = request.getParameter("orders_num");
		
		AdminOrderViewService adminOrderViewService = new AdminOrderViewService();
		List<OrdersDetailBean> myDetailOrders = adminOrderViewService.infoOrdersDetail(orders_order_num);
		
		OrdersBean ordersBean = null;
		ReceiverBean receiverBean = null;
		
		AdminOrderViewService orderViewService = new AdminOrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num);
		receiverBean = orderViewService.infoReceiver(myDetailOrders.get(0).getReceiver_num());
		
		
		
		request.setAttribute("myDetailOrders", myDetailOrders);
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("receiverBean", receiverBean);
		
		forward.setPath("/member/myPageOrdersDetail.jsp");
		return forward;
	}


}
