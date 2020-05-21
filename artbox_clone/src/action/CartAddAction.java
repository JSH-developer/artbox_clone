package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import svc.CartAddService;
import svc.CartListService;
import vo.ActionForward;
import vo.CartBean;

public class CartAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CartAddAction");
		
		// 세션값 가져오기
		// 세션값 없으면  main.jsp
//		HttpSession session = request.getSession();
//		String id = (String)session.getAttribute("member_id");
		
		ActionForward forward = null;
		
		// +
		CartBean cartBean = new CartBean();
		CartAddService cartAddService = new CartAddService();
		cartAddService.addCart(cartBean);
		// +
		
//		if(id == null){
//			forward.setRedirect(true);
//			forward.setPath("main.jsp");
//			return forward;
//		}
		
//		CartBean cartBean = new CartBean();
//		cartBean.setCart_num(Integer.parseInt(request.getParameter("cart_num")));
//		cartBean.setCart_quantity(Integer.parseInt(request.getParameter("cart_quantity")));
//		cartBean.setCart_member_id(id);
//		cartBean.setCart_product_num(Integer.parseInt(request.getParameter("cart_product_num")));
		

//		CartDAO cartDAO = new CartDAO();
		//int check=상품 중복체크 중복이면 수량 update <= 1
		//      checkGoods(BasketBean basketbean)
//		int check=cartDAO.checkItems(cartBean);
//		if(check!=1){
			//메서드호출 basketAdd(basketbean)
//			cartDAO.insertCart(cartBean);
//		}
		
		forward = new ActionForward();
		// 2. 포워딩 방식 지정 => Redirect 방식이므로 파라미터에 true 전달(필수)
		forward.setRedirect(true);
		// 3. 포워딩 할 주소 지정 => 서블릿 주소 BoardList.bo 요청
		forward.setPath("listCart.cart");
		
		return forward;
	}

}
