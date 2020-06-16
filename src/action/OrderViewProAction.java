package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.OrderViewService;
import vo.ActionForward;
import vo.OrdersBean;

public class OrderViewProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		OrdersBean ordersBean = null;
		
		int orders_num = Integer.parseInt(request.getParameter("num"));
		
		OrderViewService orderViewService = new OrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num);
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("orders_num", orders_num);
		
		forward.setPath("/admin/viewOrder.jsp");
		return forward;		
	}

}
