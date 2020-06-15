package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.CartListService;
import vo.ActionForward;

// 장바구니 목록을 보여주는 CartListAction 클래스 정의
public class CartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CartListAction");
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/login.cart");
			return forward;
		}
		
		// cartListService 인스턴스 생성 후 getCartList() 메서드 호출하여 장바구니 목록 가져오기
		// => 파라미터 : id , 리턴타입 : Vector
		CartListService cartListService = new CartListService();
		List list = cartListService.getCartList(id);
		if(list == null) {
			forward = new ActionForward();
			forward.setPath("/cart/Cart.jsp");
		} else {
			// 첫번째 vector 칸의 값인 cartList 저장
			List cartList = (List)list.get(0);
			// 두번째 vector 칸의 값인 itemsList 저장
			List itemsList = (List)list.get(1);
			
			forward = new ActionForward();
			// request 에 cartList / itemsList 담기
			request.setAttribute("cartList", cartList);
			request.setAttribute("itemsList", itemsList);
			forward.setPath("/cart/Cart.jsp");
			
		}
		
		return forward;
	}

}
