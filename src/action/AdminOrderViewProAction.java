package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminOrderViewService;
import vo.ActionForward;
import vo.OrdersBean;
import vo.ReceiverBean;

public class AdminOrderViewProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		OrdersBean ordersBean = null;
		ReceiverBean receiverBean = null;
		
		int orders_num = Integer.parseInt(request.getParameter("num"));
		
		AdminOrderViewService orderViewService = new AdminOrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num);
		receiverBean = orderViewService.infoReceiver(ordersBean.getOrders_order_num());
		
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("orders_num", orders_num);
		request.setAttribute("receiverBean", receiverBean);
		
		forward.setPath("/admin/viewOrder.jsp");
		return forward;		
	}

}
