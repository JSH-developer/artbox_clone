package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.member.MemberCheckService;
import svc.member.MyPageBuyService;
import svc.member.MyPageCancelService;
import svc.member.MyPageOrdersService;
import svc.member.MyPageReService;
import vo.ActionForward;
import vo.OrdersBean;

public class MyPageCancelProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String orders_order_num = request.getParameter("orders_order_num");
		int point = Integer.parseInt(request.getParameter("point"));
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageCancelService myPageCancelService = new MyPageCancelService();
		myPageCancelService.changeCancelState(orders_order_num);
		myPageCancelService.changeCancelPoint(point, id);
		
		MyPageReService myPageReService = new MyPageReService();
		List<OrdersBean> myRes = myPageReService.getMyRes(id);
		
		request.setAttribute("myRes", myRes);
		
		forward.setPath("/member/myPageRe.jsp");
		return forward;
	}


}
