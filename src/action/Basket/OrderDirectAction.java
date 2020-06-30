package action.Basket;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.CouponService;
import svc.Basket.OrderDirectService;
import svc.Basket.OrderListService;
import vo.ActionForward;
import vo.CouponBean;
import vo.ProductBean;

// Basket.jsp 페이지에서 선택된 상품 주문을 하기위한 OrderOneListAction 클래스 정의
// itemDetail.jsp 페이지에서 바로주문하기 버튼 클릭 시 상품 주문을 하기위한 OrderOneListAction 클래스 정의
public class OrderDirectAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("OrderDirectAction");
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
		
		ProductBean productBean = new ProductBean(); // 담아갈 ProductBean 객체 생성
		productBean.setProduct_num(Integer.parseInt(request.getParameter("product_num"))); // 상품번호
		productBean.setProduct_code(request.getParameter("product_code")); // 상품코드
		productBean.setProduct_name(request.getParameter("product_name")); // 상품이름
		productBean.setProduct_image(request.getParameter("product_image")); // 상품이미지명
		productBean.setProduct_price(Integer.parseInt(request.getParameter("product_price"))); // 상품가격
		productBean.setProduct_stock_count(Integer.parseInt(request.getParameter("stockqty"))); // 주문 수량 임시로 담음
		productBean.setProduct_category_code(request.getParameter("product_category_code")); // 상품카테고리
		
		CouponService couponService = new CouponService();
		ArrayList<CouponBean> mycouponList= couponService.getmycouponlist(id);
		
		if(mycouponList != null) {
			request.setAttribute("mycouponList", mycouponList);
		} else {
			System.out.println("OrderDirectAction - 쿠폰 리스트 불러오기 실패");
		}
		
		// OrderDirectService 인스턴스 생성 후 getOrderDirectList() 메서드 호출하여 주문하는 상품 목록 가져오기
		// => 파라미터 : (id, 상품번호) , 리턴타입 : List
		OrderDirectService orderDirectService = new OrderDirectService();
		List orderList = new ArrayList();
		orderList = orderDirectService.getOrderDirectList(id, productBean);
		// getBasicReceiverList() 메서드 호출하여 기본배송지 목록 가져오기
		// getLastReceiverList() 메서드 호출하여 최근배송지 목록 가져오기
		OrderListService orderListService = new OrderListService();
		List receiverBasicList = orderListService.getBasicReceiverList(id); // 기본배송지
		List receiverLastList = orderListService.getLastReceiverList(id); // 최근배송지
		
		forward = new ActionForward();
		// request 에 orderList / product_num / receiverBasicList / receiverLastList 담기
		request.setAttribute("orderListOne", orderList.get(0)); // 상품명 뿌리기 위해서 한 칸 담음
		request.setAttribute("orderList", orderList);
		request.setAttribute("product_num", Integer.parseInt(request.getParameter("product_num"))); // 주문한 상품번호 들고가기
		request.setAttribute("receiverBasicList", receiverBasicList);
		request.setAttribute("receiverLastList", receiverLastList);
		forward.setPath("/basket/OrderPay.jsp");
		
		return forward;
	}
}
