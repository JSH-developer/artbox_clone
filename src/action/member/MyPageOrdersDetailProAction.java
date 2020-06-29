package action.member;

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

public class MyPageOrdersDetailProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String orders_order_num = request.getParameter("orders_num");
		
		AdminOrderViewService adminOrderViewService = new AdminOrderViewService();
		List<OrdersDetailBean> myDetailOrders = adminOrderViewService.infoOrdersDetail(orders_order_num);
		
		
		request.setAttribute("myDetailOrders", myDetailOrders);
		
		
		forward.setPath("/member/myPageOrdersDetail.jsp");
		return forward;
	}


}
