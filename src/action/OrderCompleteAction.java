package action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.BasketDeleteOneService;
import svc.BasketListService;
import svc.OrderCompleteService;
import svc.OrderOneListService;
import vo.ActionForward;
import vo.OrdersBean;
import vo.ReceiverBean;

public class OrderCompleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderCompleteAction");
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		request.setCharacterEncoding("UTF-8");
		
		ActionForward forward = null;
		
		String arrBasket = request.getParameter("arrBasket");
		System.out.println("가져온값" + arrBasket);

		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/login.basket");
			return forward;
		}
		
		// 자바빈 OrderBean 객체 생성 orderbean
		OrdersBean ordersbean=new OrdersBean();
		ReceiverBean receiverBean=new ReceiverBean();
		
		// 한글처리
		request.setCharacterEncoding("utf-8");
		
//		BasketListService basketListService = new BasketListService();
//		List list = basketListService.getBasketList(id);
//		// 첫번째 vector 칸의 값인 basketList 저장
//		List basketList = (List)list.get(0);
//		// 두번째 vector 칸의 값인 itemsList 저장
//		List itemList = (List)list.get(1);
		
		OrderOneListService orderOneListService = new OrderOneListService();
		List orderList = orderOneListService.getOrderOneList(id, arrBasket);
//		System.out.println("사이즈~~~!" + orderList.size());
		
		System.out.println("아이디 : " + id);
		System.out.println("가격 : " + request.getParameter("TotalPriceAmount"));
		System.out.println("이름 : " + request.getParameter("memname"));
		System.out.println("이메일 : " + request.getParameter("mememail"));
		System.out.println("폰번호 : " + request.getParameter("phone123"));
		System.out.println("배송이름 : " + request.getParameter("i_shipname"));
		System.out.println("배송우편 : " + request.getParameter("i_shipzipcode"));
		System.out.println("배송주소 : " + request.getParameter("i_shipaddr"));
		
		// 폼 => 자바빈 저장
		// 상품결제 Bean 저장
		ordersbean.setOrders_member_id(id);
		ordersbean.setOrders_order_name(request.getParameter("memname"));
		ordersbean.setOrders_order_email(request.getParameter("mememail"));
		ordersbean.setOrders_order_phone(request.getParameter("phone123"));
		ordersbean.setOrders_point(Integer.parseInt("1"));
		ordersbean.setOrders_total_price(Integer.parseInt(request.getParameter("TotalPriceAmount")));
		ordersbean.setOrders_payMethod("페이방법");
		ordersbean.setOrders_state(Integer.parseInt("1"));
		
		// 배송지 Bean 저장
		receiverBean.setReceiver("회사");
		receiverBean.setReceiver_name(request.getParameter("memname"));
		receiverBean.setReceiver_phone(request.getParameter("phone123"));
		receiverBean.setReceiver_postcode("12345");
		receiverBean.setReceiver_addr("주소연습");
		receiverBean.setReceiver_addr_detail("주소디테일연습");
		receiverBean.setReceiver_msg("배송지연습");
		receiverBean.setReceiver_member_id(id);
		
		// 주문상세보기 Bean 저장
//		for(int i = 0; i < basketList.size(); i++){
//			OrdersDetailBean ordersDetailBean=new OrdersDetailBean();
//			ordersDetailBean.setOrdersDetail_quantity(Integer.parseInt(request.getParameter("TotalPriceAmount")));
//			ordersDetailBean.setOrdersDetail_orders_order_num(Integer.parseInt(request.getParameter("TotalPriceAmount")));
//			ordersDetailBean.setOrdersDetail_product_num(Integer.parseInt(request.getParameter("TotalPriceAmount")));
//			ordersDetailBean.setOrdersDetail_receiver_num(Integer.parseInt(request.getParameter("TotalPriceAmount")));
//			ordersDetailBean.setOrdersDetail_code(request.getParameter("TotalPriceAmount"));
//			ordersDetailBean.setOrdersDetail_name(request.getParameter("TotalPriceAmount"));
//			ordersDetailBean.setOrdersDetail_image(request.getParameter("TotalPriceAmount"));
//			ordersDetailBean.setOrdersDetail_price(Integer.parseInt(request.getParameter("TotalPriceAmount")));
//		}
		
		// OrderDAO 객체생성 orderdao
//		OrderDAO orderdao = new OrderDAO();
		// 메서드 호출  => 주문정보저장
		// 메서드호출 addOrder(orderbean,basketList,itemList)
		OrderCompleteService orderCompleteService = new OrderCompleteService();
		boolean isInsertSuccess = orderCompleteService.insertOrder(ordersbean, receiverBean, orderList, id);
		
		// 리턴받은 결과를 사용하여 장바구니 등록 결과 판별
		PrintWriter out = response.getWriter();
		if(!isInsertSuccess) {
			System.out.println("isInsertSuccess 주문 실패!");
			out.println("<script>");
			out.println("alert('주문 실패!')");
			out.println("history.back();");
			out.println("</script>");
		} else {
//			boolean isDeleteSuccess = BasketDeleteOneService.deleteBasket(arrBasket);
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
				forward.setPath("listOrderDetail.order");
//			}
		}
		
		// 상품전체개수 수정 itemdao    updateAmount(basketList)
//		ItemDao itemdao=new ItemDao();
		//itemdao.updateAmount(basketList);
		
		// 장바구니 정보 삭제 basketdao // deleteAllBasket(id)
//		basketdao.deleteAllBasket(id, arrBasket);
		
		// 이동 /OrderComplete.order
//		forward.setRedirect(true);
//		forward.setPath("/OrderComplete.order");
		
		// 4. ActionForward 객체 리턴
		return forward;
	}

}
