package action.Basket;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.BasketDeleteOneService;
import svc.Basket.BasketListService;
import svc.Basket.OrderCompleteService;
import svc.Basket.OrderOneListService;
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
		System.out.println("OrderCompleteAction 가져온값" + arrBasket);

		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null) {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/memberLoginForm.member");
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
		int BasicAddr =0;
		System.out.println("들고온 베이직넘버" + request.getParameter("BasicAddr"));
		if(request.getParameter("BasicAddr") != null) {
			BasicAddr = 1;
		}
		System.out.println("기본 배송지 여부" + BasicAddr);
		System.out.println("포인트 : " + request.getParameter("point"));
		System.out.println("가격 : " + request.getParameter("Total"));
		System.out.println("이름 : " + request.getParameter("memname"));
		System.out.println("이메일 : " + request.getParameter("mememail"));
		System.out.println("폰번호 : " + request.getParameter("tel"));
		System.out.println("배송이름 : " + request.getParameter("shipname"));
		System.out.println("배송우편 : " + request.getParameter("shipzipcode"));
		System.out.println("배송주소 : " + request.getParameter("shipaddr"));
		System.out.println("배송메세지 : " + request.getParameter("shipalertdesc"));
		System.out.println("배송전화번호 : " + request.getParameter("shipcpnum1")+"-"+request.getParameter("shipcpnum2")+"-"+request.getParameter("shipcpnum3"));
		System.out.println("페이방버ㅂ: " +  request.getParameter("pay_method"));
		
		// 폼 => 자바빈 저장
		// 상품결제 Bean 저장
		ordersbean.setOrders_member_id(id);
		ordersbean.setOrders_order_name(request.getParameter("memname"));
		ordersbean.setOrders_order_email(request.getParameter("mememail"));
		ordersbean.setOrders_order_phone(request.getParameter("tel"));
		ordersbean.setOrders_msg(request.getParameter("shipalertdesc"));
		ordersbean.setOrders_point(0);
		ordersbean.setOrders_total_price(Integer.parseInt(request.getParameter("Total")));
		ordersbean.setOrders_payMethod("card");
		ordersbean.setOrders_state(0);
		
		// 배송지 Bean 저장
		receiverBean.setReceiver_basic_num(BasicAddr);
		receiverBean.setReceiver(request.getParameter("receiver"));
		receiverBean.setReceiver_name(request.getParameter("shipname"));
		receiverBean.setReceiver_phone(request.getParameter("shipcpnum1")+"-"+request.getParameter("shipcpnum2")+"-"+request.getParameter("shipcpnum3"));
		receiverBean.setReceiver_postcode(request.getParameter("shipzipcode"));
		receiverBean.setReceiver_addr(request.getParameter("shipaddr"));
		receiverBean.setReceiver_addr_detail(request.getParameter("shipaddrd"));
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
//			boolean isDeleteSuccess = BasketDeleteOneService.deleteBasket(arrBasket); // 장바구니 삭제
//			boolean isUpdateItemQuantity = itemdao.updateAmount(arrBasket); // 상품개수 수정
//			if(!isDeleteSuccess || !isUpdateItemQuantity) {
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
