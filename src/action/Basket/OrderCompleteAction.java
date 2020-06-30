package action.Basket;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.BasketDeleteService;
import svc.Basket.OrderCompleteService;
import svc.Basket.OrderItemListService;
import svc.Basket.OrderListService;
import vo.ActionForward;
import vo.OrdersBean;
import vo.ReceiverBean;

// OrderPay.jsp 페이지에서 구매하기 버튼 클릭시 주문 정보를 가져와서 저장하는 OrderCompleteAction 클래스 정의
// 구매 성공 시 주문 디테일 화면을 보여주는 액션(listOrderDetail.order)으로 이동
public class OrderCompleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("OrderCompleteAction");
		request.setCharacterEncoding("UTF-8");
		
		// 세션값(id) 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");

		ActionForward forward = null;
		String product_num = request.getParameter("product_num"); // 상품 번호(배열로 받아옴)
		String stockqty = request.getParameter("stockqty"); // 상품 수량(배열로 받아옴)
		System.out.println(stockqty);

		// 세션값(id) 없으면 로그인페이지로 돌아가기
		if(id == null) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/loginForm.member");
			return forward;
		}
		
		// OrderListService 인스턴스 생성 후 getOrderList() 메서드 호출하여 주문 정보 추가하기
		// 파라미터 : (id, arrBasket), 리턴타입 : List
		OrderItemListService orderItemListService = new OrderItemListService();
		List orderList = orderItemListService.getOrderItemList(product_num, stockqty);
		
		int BasicAddr = 0; // 기본 배송지 여부 (default 0, 1:기본배송지)
		if(request.getParameter("BasicAddr") != null) {
			BasicAddr = 1;
		}
		
//		System.out.println("사용한 포인트" + request.getParameter("UseMileagePrice"));
//		System.out.println("기본 배송지 여부 : " + BasicAddr);
//		System.out.println("적립포인트 : " + request.getParameter("point"));
//		System.out.println("저장할 포인트" );
//		System.out.println("가격 : " + request.getParameter("Total"));
//		System.out.println("이름 : " + request.getParameter("memname"));
//		System.out.println("이메일 : " + request.getParameter("mememail"));
//		System.out.println("폰번호 : " + request.getParameter("tel"));
//		System.out.println("배송이름 : " + request.getParameter("shipname"));
//		System.out.println("배송우편 : " + request.getParameter("shipzipcode"));
//		System.out.println("배송주소 : " + request.getParameter("shipaddr"));
//		System.out.println("배송메세지 : " + request.getParameter("shipalertdesc"));
//		System.out.println("배송전화번호 : " + request.getParameter("shipcpnum1")+"-"+request.getParameter("shipcpnum2")+"-"+request.getParameter("shipcpnum3"));
//		System.out.println("페이방법 : " +  request.getParameter("pay_method"));
		
		// 주문정보 추가를 위해 입력받은 데이터를 저장할 OrdersBean 객체 생성
		OrdersBean ordersbean = new OrdersBean();
		// request 객체로부터 입력받은 데이터를 가져와서 OrdersBean 객체에 저장
		ordersbean.setOrders_member_id(id); // 아이디
		ordersbean.setOrders_order_name(request.getParameter("memname")); // 주문자명
		ordersbean.setOrders_order_email(request.getParameter("mememail")); // 주문자이메일
		ordersbean.setOrders_order_phone(request.getParameter("tel")); // 주문자번호
		ordersbean.setOrders_msg(request.getParameter("shipalertdesc")); // 배송메세지
		ordersbean.setOrders_point(0); // 포인트
		ordersbean.setOrders_total_price(Integer.parseInt(request.getParameter("Total"))); // 총합계
		ordersbean.setOrders_payMethod("card"); // 결제 페이방법
		ordersbean.setOrders_state(0); // 배송상태 (0 default:결제완료-배송준비중)
		
		// 배송지 추가를 위해 입력받은 데이터를 저장할 ReceiverBean 객체 생성
		ReceiverBean receiverBean = new ReceiverBean();
		// request 객체로부터 입력받은 데이터를 가져와서 ReceiverBean 객체에 저장
		receiverBean.setReceiver_basic_num(BasicAddr); // 기본배송지 여부
		receiverBean.setReceiver(request.getParameter("receiver")); // 배송지명
		receiverBean.setReceiver_name(request.getParameter("shipname")); // 배송자명
		receiverBean.setReceiver_phone(request.getParameter("shipcpnum1")+"-"+request.getParameter("shipcpnum2")+"-"+request.getParameter("shipcpnum3")); // 배송자 전화번호
		receiverBean.setReceiver_postcode(request.getParameter("shipzipcode")); // 배송지 우편번호
		receiverBean.setReceiver_addr(request.getParameter("shipaddr")); // 배송지 주소
		receiverBean.setReceiver_addr_detail(request.getParameter("shipaddrd")); // 배송지 상세주소
		receiverBean.setReceiver_member_id(id); // 아이디
		
		// OrderCompleteService 인스턴스 생성 후 insertOrder() 메서드 호출하여 주문정보 추가하기
		// 파라미터 : (ordersbean, receiverBean, orderList, id), 리턴타입 : boolean(isInsertSuccess)
		OrderCompleteService orderCompleteService = new OrderCompleteService();
		boolean isInsertSuccess = orderCompleteService.insertOrder(ordersbean, receiverBean, orderList, id);
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		// 리턴받은 결과를 사용하여 주문정보 등록 결과 판별
		if(!isInsertSuccess) {
			System.out.println("isInsertSuccess 주문 실패!");
			out.println("<script>");
			out.println("alert('주문 실패!')");
			out.println("history.back();");
			out.println("</script>");
		} else {
			// BasketDeleteOneService 인스턴스 생성 후 deleteBasket() 메서드 호출하여 장바구니 삭제하기
			// 파라미터 : arrBasket, 리턴타입 : boolean(isDeleteSuccess)
//			boolean isDeleteSuccess = BasketDeleteService.deleteBasket(id, product_num); // 장바구니 삭제(상품개수 수정은 Admin 에서 관리!)
//			if(!isDeleteSuccess) {
//				System.out.println("isDeleteSuccess 주문 실패!");
//				out.println("<script>");
//				out.println("alert('주문 실패!')");
//				out.println("history.back();");
//				out.println("</script>");
//			} else {
				System.out.println("주문 성공!");
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("listOrderDetail.order?product_num="+product_num);
//			}
		}
		return forward;
	}
}
