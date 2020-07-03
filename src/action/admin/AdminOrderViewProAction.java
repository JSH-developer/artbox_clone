package action.admin;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.AdminOrderViewService;
import vo.ActionForward;
import vo.OrdersBean;
import vo.OrdersDetailBean;
import vo.ReceiverBean;

public class AdminOrderViewProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		OrdersBean ordersBean = null;
		ReceiverBean receiverBean = null;
		ArrayList<OrdersDetailBean> ordersDetailBeans = null;
		
		int orders_num = Integer.parseInt(request.getParameter("num"));
		
		AdminOrderViewService orderViewService = new AdminOrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num);
		ordersDetailBeans = orderViewService.infoOrdersDetail(ordersBean.getOrders_order_num());
		receiverBean = orderViewService.infoReceiver(ordersDetailBeans.get(0).getReceiver_num());
		
		
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("orders_num", orders_num);
		request.setAttribute("receiverBean", receiverBean);
		request.setAttribute("ordersDetailBeans", ordersDetailBeans);
		
		forward.setPath("/admin/viewOrder.jsp");
		return forward;		
	}

}
