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
		String orders_order_num = request.getParameter("orders_order_num");
		int point = Integer.parseInt(request.getParameter("point"));
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageBuyService myPageBuyService = new MyPageBuyService();
		myPageBuyService.changeBuyState(orders_order_num);
		myPageBuyService.changeBuyPoint(point, id);
		myPageBuyService.changeGrade(id);
		
		MyPageOrdersService myPageOrdersService = new MyPageOrdersService();
		List<OrdersBean> myOrders = myPageOrdersService.getMyOrders(id);
		
		request.setAttribute("myOrders", myOrders);
		
		forward.setPath("/member/myPageOrders.jsp");
		return forward;
	}


}
