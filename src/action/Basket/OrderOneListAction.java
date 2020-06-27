package action.Basket;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.CouponService;
import svc.Basket.OrderOneListService;
import vo.ActionForward;
import vo.CouponBean;

// Basket.jsp 페이지에서 선택된 상품 주문을 하기위한 OrderOneListAction 클래스 정의
// itemDetail.jsp 페이지에서 바로주문하기 버튼 클릭 시 상품 주문을 하기위한 OrderOneListAction 클래스 정의
public class OrderOneListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		System.out.println("OrderOneListAction");
		
		// 세션값(id) 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = null;
		
		// 세션값(id) 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/memberLoginForm.member");
			return forward;
		}
		
		String arrBasket = request.getParameter("arrBasket"); // 상품 번호 가져오기(Basket.jsp에서)
		System.out.println("OrderOneListAction 가져온값" + arrBasket);
		
		CouponService couponService = new CouponService();
		ArrayList<CouponBean> mycouponList= couponService.getmycouponlist(id);
		
		if(mycouponList != null) {
			request.setAttribute("mycouponList", mycouponList);
		} else {
			System.out.println("쿠폰 리스트 불러오기 실패");
		}
		
		// OrderOneListService 인스턴스 생성 후 getOrderOneList() 메서드 호출하여 주문하는 상품 목록 가져오기
		// => 파라미터 : (id, 상품번호) , 리턴타입 : List
		OrderOneListService orderOneListService = new OrderOneListService();
		List orderList = new ArrayList();
		orderList = orderOneListService.getOrderOneList(id, arrBasket);
		// getBasicReceiverList() 메서드 호출하여 기본배송지 목록 가져오기
		// getLastReceiverList() 메서드 호출하여 최근배송지 목록 가져오기
		List receiverBasicList = orderOneListService.getBasicReceiverList(id); // 기본배송지
		List receiverLastList = orderOneListService.getLastReceiverList(id); // 최근배송지
		
		System.out.println("이건 사이즈" +orderList.size());
		forward = new ActionForward();
		// request 에 orderList / arrBasket / receiverBasicList / receiverLastList 담기
		request.setAttribute("orderListOne", orderList.get(0));
		request.setAttribute("orderList", orderList);
		request.setAttribute("arrBasket", arrBasket); // 주문한 상품번호 들고가기
		request.setAttribute("receiverBasicList", receiverBasicList);
		request.setAttribute("receiverLastList", receiverLastList);
		forward.setPath("/basket/OrderPay.jsp");
		
		return forward;
	}
}
