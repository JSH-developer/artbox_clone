package action.Basket;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.CouponService;
import svc.Basket.OrderListService;
import vo.ActionForward;
import vo.CouponBean;

// Basket.jsp 페이지에서 선택된 상품 주문을 하기위한 OrderListAction 클래스 정의
public class OrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderListAction");
		request.setCharacterEncoding("UTF-8");
		
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
		
		//---쿠폰-------------------------------------------------------------------------------
		// 쿠폰 불러오기
		CouponService couponService = new CouponService();
		ArrayList itemcoupon = couponService.getCouponCategory();
		request.setAttribute("itemcoupon", itemcoupon);
		
		String product_num = request.getParameter("product_num"); // 상품 번호 가져오기
		
		couponService = new CouponService();
		ArrayList<CouponBean> mycouponList= couponService.getmycouponlist(id);
		
		if(mycouponList != null) {
			request.setAttribute("mycouponList", mycouponList);
		} else {
			System.out.println("쿠폰 리스트 불러오기 실패");
		}
		
		// OrderListService 인스턴스 생성 후 getOrderOneList() 메서드 호출하여 주문하는 상품 목록 가져오기
		// => 파라미터 : (id, product_num) , 리턴타입 : List
		OrderListService orderListService = new OrderListService();
		List orderList = new ArrayList();
		orderList = orderListService.getOrderList(id, product_num);
		// getBasicReceiverList() 메서드 호출하여 기본배송지 목록 가져오기
		// getLastReceiverList() 메서드 호출하여 최근배송지 목록 가져오기
		List receiverBasicList = orderListService.getBasicReceiverList(id); // 기본배송지
		List receiverLastList = orderListService.getLastReceiverList(id); // 최근배송지
		
		forward = new ActionForward();
		// request 에 orderList / product_num / receiverBasicList / receiverLastList 담기
		request.setAttribute("orderListOne", orderList.get(0)); // 상품명 뿌리기 위해서 한 칸 담음
		request.setAttribute("orderList", orderList);
		request.setAttribute("product_num", product_num); // 주문한 장바구니 번호 들고가기
		request.setAttribute("stockqty", request.getParameter("stockqty")); // 주문한 상품에 해당하는 수량 들고가기
		request.setAttribute("receiverBasicList", receiverBasicList);
		request.setAttribute("receiverLastList", receiverLastList);
		forward.setPath("/basket/OrderPay.jsp");
		
		return forward;
	}
}
