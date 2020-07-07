package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.member.MemberCheckService;
import svc.member.MyPageOrdersService;
import vo.ActionForward;
import vo.MemberBean;
import vo.OrdersBean;

public class MyPageOrdersProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageOrdersService myPageOrdersService = new MyPageOrdersService();
		List<OrdersBean> myOrders = myPageOrdersService.getMyOrders(id);
		
		MemberBean bb = myPageOrdersService.myPoint(id);
		
		request.setAttribute("point", bb.getPoint());
		
		request.setAttribute("myOrders", myOrders);
		
		
		forward.setPath("/member/myPageOrders.jsp");
		return forward;
	}


}
