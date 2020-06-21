package action.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderAllListService;
import svc.OrderOneListService;
import vo.ActionForward;

public class OrderAllListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderAllListAction");
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
//		int cartidx = Integer.parseInt(request.getParameter("cartidx"));
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/login.cart");
			return forward;
		}
		
		// cartListService 인스턴스 생성 후 getCartList() 메서드 호출하여 장바구니 목록 가져오기
		// => 파라미터 : id , 리턴타입 : Vector
		OrderAllListService orderAllListService = new OrderAllListService();
		List list = orderAllListService.getOrderAllList(id/*, cartidx*/);
		List productList = (List)list.get(0);
		List cartList = (List)list.get(1);
		List memberList = (List)list.get(2);
		
		forward = new ActionForward();
		// request 에 cartList / itemsList 담기
		request.setAttribute("productList", productList);
		request.setAttribute("cartList", cartList);
		request.setAttribute("memberList", memberList);
		forward.setPath("/cart/OrderPay.jsp");
		
		return forward;
	}

}
