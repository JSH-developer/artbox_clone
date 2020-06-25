package action.Basket;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.OrderDetailListService;
import vo.ActionForward;
import vo.OrdersDetailBean;

public class OrderDetailListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderDetailListAction");
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/memberLoginForm.member");
			return forward;
		}
		
		// basketListService 인스턴스 생성 후 getBasketList() 메서드 호출하여 장바구니 목록 가져오기
		// => 파라미터 : id , 리턴타입 : Vector
		OrderDetailListService orderDetailListService = new OrderDetailListService();
		List list = orderDetailListService.getOrderDetailList(id);
		
		forward = new ActionForward();
		// request 에 basketList / itemsList 담기
		request.setAttribute("list", list);
		forward.setPath("/basket/OrderPayComplete.jsp");
		
		return forward;
	}

}
