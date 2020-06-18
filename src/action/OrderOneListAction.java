package action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.CouponService;
import svc.OrderOneListService;
import vo.ActionForward;
import vo.CouponBean;

public class OrderOneListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderOneListAction");
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
		String arrBasket = request.getParameter("arrBasket");
		System.out.println("가져온값" + arrBasket);
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/login.basket");
			return forward;
		}
		
		CouponService couponService = new CouponService();
		ArrayList<CouponBean> mycouponList= couponService.getmycouponlist(id);
		
		if(mycouponList != null) {
			System.out.println(id+"님 쿠폰 리스트 갖고옴");
			
			request.setAttribute("mycouponList", mycouponList);
			
		}else {
			System.out.println("리스트 불러오기 실패");
		}
		
		// basketListService 인스턴스 생성 후 getBasketList() 메서드 호출하여 장바구니 목록 가져오기
		// => 파라미터 : id , 리턴타입 : Vector
		OrderOneListService orderOneListService = new OrderOneListService();
		List orderList = orderOneListService.getOrderOneList(id, arrBasket);
		
		System.out.println("이건 사이즈" +orderList.size());
		forward = new ActionForward();
		// request 에 basketList / itemsList 담기
		request.setAttribute("orderListOne", orderList.get(0));
		request.setAttribute("orderList", orderList);
		forward.setPath("/basket/OrderPay.jsp");
		
/*		
		String product_num = request.getParameter("optionidx");
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/login.basket");
			return forward;
		}
		
		// basketListService 인스턴스 생성 후 getBasketList() 메서드 호출하여 장바구니 목록 가져오기
		// => 파라미터 : id , 리턴타입 : Vector
		OrderOneListService orderOneListService = new OrderOneListService();
		List list = orderOneListService.getOrderOneList(id, product_num);
		List productList = (List)list.get(0);
		List basketList = (List)list.get(1);
		List memberList = (List)list.get(2);
		
		forward = new ActionForward();
		// request 에 basketList / itemsList 담기
		request.setAttribute("productList", productList);
		request.setAttribute("basketList", basketList);
		request.setAttribute("memberList", memberList);
		forward.setPath("/basket/OrderPay.jsp");
*/
		
		return forward;
	}

}
