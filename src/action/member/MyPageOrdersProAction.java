package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.member.MyPageOrdersService;
import vo.ActionForward;
import vo.MemberBean;
import vo.OrdersBean;

public class MyPageOrdersProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		// id값 저장
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageOrdersService myPageOrdersService = new MyPageOrdersService();
		List<OrdersBean> myOrders = myPageOrdersService.getMyOrders(id); // svc에서 ArrayList 받아오기
		
		MemberBean bb = myPageOrdersService.myPoint(id);
		int orderCount = myPageOrdersService.orderCount(id);
		int coupCount = myPageOrdersService.coupCount(id);
		int reviewCount = myPageOrdersService.reviewCount(id);
		
		request.setAttribute("myOrders", myOrders);
		request.setAttribute("point", bb.getPoint());
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("coupCount", coupCount);
		request.setAttribute("reviewCount", reviewCount);
		
		
		forward.setPath("/member/myPageOrders.jsp");
		return forward;
	}


}
