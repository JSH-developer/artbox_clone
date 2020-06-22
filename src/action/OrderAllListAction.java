package action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.CouponService;
import svc.OrderAllListService;
import svc.OrderOneListService;
import vo.ActionForward;
import vo.CouponBean;

public class OrderAllListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderAllListAction");
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
//		int basketidx = Integer.parseInt(request.getParameter("basketidx"));
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/login.basket");
			return forward;
		}
		

		
		
		// basketListService 인스턴스 생성 후 getBasketList() 메서드 호출하여 장바구니 목록 가져오기
		// => 파라미터 : id , 리턴타입 : Vector
		OrderAllListService orderAllListService = new OrderAllListService();
		List list = orderAllListService.getOrderAllList(id/*, basketidx*/);
		List productList = (List)list.get(0);
		List basketList = (List)list.get(1);
		List memberList = (List)list.get(2);
		
		forward = new ActionForward();
		// request 에 basketList / itemsList 담기
		request.setAttribute("productList", productList);
		request.setAttribute("basketList", basketList);
		request.setAttribute("memberList", memberList);
		forward.setPath("/basket/OrderPay.jsp");
		
		return forward;
	}

}