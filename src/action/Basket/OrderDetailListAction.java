package action.Basket;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.OrderDetailListService;
import vo.ActionForward;

// 주문정보(OrderPayComplete.jsp)을 보여주는 OrderDetailListAction 클래스 정의
public class OrderDetailListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("OrderDetailListAction");
		
		// 세션값(id) 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
		// 세션값(id) 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/loginForm.member");
			return forward;
		}
		
		// OrderDetailListService 인스턴스 생성 후 getOrderDetailList() 메서드 호출하여 주문정보 가져오기
		// => 파라미터 : id , 리턴타입 : List
		OrderDetailListService orderDetailListService = new OrderDetailListService();
		List list = orderDetailListService.getOrderDetailList(id);
		
		forward = new ActionForward();
		// request 에 list 담기
		request.setAttribute("list", list);
		forward.setPath("/basket/OrderPayComplete.jsp");
		
		return forward;
	}
}
