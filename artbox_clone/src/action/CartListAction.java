package action;

import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import svc.CartListService;
import vo.ActionForward;

// 사용자로부터 전달되는 데이터를 가져와서 DB 작업을 위한 준비 수행하는 Action 클래스
// DB 작업 후 결과를 전달받아 사용자에게 보여질 정보를 준비하는 클래스
public class CartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CartListAction");
		
		//세션 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("member_id");
		//세션값 없으면  ./MemberLogin.me
		ActionForward forward = null;
		
		// +
		CartListService cartListService = new CartListService();
		
		Vector cartList = cartListService.getCartList(id);
		// +
		
//		if(id==null){
//			forward.setRedirect(true);
//			forward.setPath("main.jsp");
//			return forward;
//		}
		//BasketDAO 객체 생성 basketdao
//		CartDAO cartDAO = new CartDAO();
		//Vector vector= 메서드호출  getBasketList(String id)
		//  => Vector vector=new Vector();
//		Vector vector = cartDAO.selectCartList(id);
		//List basketList = vector 첫번째데이터
//		List cartList = (List)vector.get(0);
		//List goodsList = vector 두번째데이터
//		List itemsList = (List)vector.get(1);
		// 저장 basketList goodsList
//		request.setAttribute("cartList", cartList);
//		request.setAttribute("itemsList", itemsList);
		forward = new ActionForward();
		request.setAttribute("cartList", cartList);
		forward.setPath("/cart/Cart.jsp");
		
		return forward;
	}

}
