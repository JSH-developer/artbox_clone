package action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminDAO;
import svc.admin.AdminOrderListService;
import svc.admin.ProductListService;
import vo.ActionForward;
import vo.OrdersBean;
import vo.PageInfo;
import vo.ProductBean;

public class AdminOrderListProAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		int page = 1; // 현재 페이지 번호를 저장할 변수
		int limit = 20; // 한 페이지 당 출력할 게시물 수 지정
		
		// 파라미터로 전달받은 페이지 번호가 있을 경우 가져와서 page 변수에 저장
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		int state = -10; // 기본상태를 안겹치는 숫자 -10으로 지정
		if(request.getParameter("state") != null) { // 주문상태 받아오기
			state = Integer.parseInt(request.getParameter("state"));
		}
		
		
		AdminOrderListService orderListService = new AdminOrderListService();
		int listCount = 0;
		if (state == -10) { // 분류값으로 주문상태를 지정하지 않을시
			listCount = orderListService.getListCount(); // svc에서 int값 가져오기
		}else { // 분류값으로 주문상태를 지정지
			listCount = orderListService.getListCount(state);
		}
		
		ArrayList<OrdersBean> orderList = null;
		if (state == -10) { // 분류값으로 주문상태를 지정하지 않을시
			orderList = orderListService.getOrderList(page, limit); // svc에서 ArrayList 받아오기
		}else {// 분류값으로 주문상태를 지정지
			orderList = orderListService.getOrderList(page, limit, state);
		}
		
		int maxPage = (int)((double)listCount / limit + 0.95);
		int startPage = (((int)((double)page / 10 + 0.9))-1)*10 +1 ;
		int endPage = startPage + 10  - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		
		// request 값 저장
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("orderList", orderList);
		
		
		forward.setPath("/admin/listOrder.jsp?&state="+state);
		return forward;
	}

}
