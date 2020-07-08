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
		//svc에 전달할 주문번호, 포인트, 아이디 저장
		String orders_order_num = request.getParameter("orders_order_num");
		int point = Integer.parseInt(request.getParameter("point"));
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageCancelService myPageCancelService = new MyPageCancelService();
		myPageCancelService.changeCancelState(orders_order_num); // svc에서 주문취소 수행
		myPageCancelService.changeCancelPoint(point, id); // svc에서 포인트 추가 수행
		
		MyPageReService myPageReService = new MyPageReService();
		List<OrdersBean> myRes = myPageReService.getMyRes(id);// svc에서 ArrayList 받아오기
		
		//request 값 저장
		request.setAttribute("myRes", myRes);
		
		forward.setPath("/myPageRe.member");
		return forward;
	}


}
