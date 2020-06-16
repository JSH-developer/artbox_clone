package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.OrderViewService;
import vo.ActionForward;
import vo.OrdersBean;
import vo.ReceiverBean;

public class OrderViewProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		OrdersBean ordersBean = null;
		ReceiverBean receiverBean = null;
		
		int orders_num = Integer.parseInt(request.getParameter("num"));
		
		OrderViewService orderViewService = new OrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num);
		receiverBean = orderViewService.infoReceiver(ordersBean.getOrders_order_num());
		
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("orders_num", orders_num);
		request.setAttribute("receiverBean", receiverBean);
		
		forward.setPath("/admin/viewOrder.jsp");
		return forward;		
	}

}
