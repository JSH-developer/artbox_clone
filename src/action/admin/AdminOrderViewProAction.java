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
		
		// 상품인덱스 받아오기
		int orders_num = Integer.parseInt(request.getParameter("num"));
		
		AdminOrderViewService orderViewService = new AdminOrderViewService();
		ordersBean = orderViewService.infoOrders(orders_num);
		ordersDetailBeans = orderViewService.infoOrdersDetail(ordersBean.getOrders_order_num()); // svc에서 ArrayList 받아오기
		receiverBean = orderViewService.infoReceiver(ordersDetailBeans.get(0).getReceiver_num()); // svc에서 ReceiverBean 받아오기
		
		// request에 값 저장
		request.setAttribute("ordersBean", ordersBean);
		request.setAttribute("orders_num", orders_num);
		request.setAttribute("receiverBean", receiverBean);
		request.setAttribute("ordersDetailBeans", ordersDetailBeans);
		
		forward.setPath("/admin/viewOrder.jsp");
		return forward;		
	}

}
