package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.CouponAllListAction;
import action.CouponIssuedAction;
import action.CouponOrderPayFormAction;
import action.CouponWriteProAction;
import action.EventDeleteProAction;
import action.EventDetailAction;
import action.EventListAction;
import action.EventModifyFormAction;
import action.EventModifyProAction;
import action.EventWriteProAction;
import action.EventproductviewAction;
import action.MypageCouponListAction;
import svc.ProductWriteService;
import vo.ActionForward;

@WebServlet("*.event")
public class EventFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();
		
		Action action = null;
		ActionForward forward = null;
		ProductWriteService productWriteService = null;

		
		if(command.equals("/index.event")){	// 이벤트 관련 링크들
			System.out.println("/index.event");
			// view로 이동할것임
			// 글쓰기 페이지 요청은 비즈니스 로직이 없는 View 페이지(jsp)로 바로 연결 수행
			// => ActionForward 객체의 포워딩 방식을 별도로 설정하지 않음(주소변경 x)
			forward = new ActionForward();
			// forward.setRedirect(false); // 포워딩 박식을 Dispatcher 방식으로 설정(기본값 생략 가능)
			forward.setPath("/basic.jsp"); // 이동할 View 페이지 경로 지정
			
		}else if(command.equals("/CouponWriteForm.event")){	// 쿠폰 등록 입력
			System.out.println("/CouponWriteForm.event");

			action = new CouponAllListAction(); 
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		
		}else if(command.equals("/CouponWritePro.event")) {	// 쿠폰 등록 Pro
			System.out.println("/CouponWritePro.event");
			action = new CouponWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/MypageCouponList.event")) {	// 마이페이지 
			System.out.println("/MypageCouponList.event");
			action = new MypageCouponListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/OrderPayForm.event")) {	// 주문에서 쿠폰 적용
			System.out.println("/OrderPayForm.event");
			action = new CouponOrderPayFormAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/testSelectmain.event")) {	// 쿠폰 적용 테스트
			System.out.println("/testSelectmain.event");

			forward = new ActionForward();
			//		forward.setRedirect(false); // 포워딩 방식을 Dispatcher 방식으로 설정(기본값 생략 가능)
			forward.setPath("/event/PayCoupon.jsp"); // 이동할 View 페이지 경로 지정

			
		}else if(command.equals("/CouponIssued.event")) {	// 버튼누르면 쿠폰 발급
			System.out.println("/CouponIssued.event");
			action = new CouponIssuedAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/EventWriteForm.event")){	// 이벤트 등록
			System.out.println("/EventWriteForm.event");
			// 카테고리 불러오기
			productWriteService = new ProductWriteService();
			String categorySelectList = productWriteService.categorySelectList();
			request.setAttribute("categorySelectList", categorySelectList);
			
			forward = new ActionForward();
			forward.setPath("/event/registEvent.jsp"); 
			
		}else if(command.equals("/EventWritePro.event")) {	// 이벤드 등록 pro
			System.out.println("/EventWritePro.event");
			action = new EventWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/EventModifyForm.event")){	// 이벤트 수정
			System.out.println("/EventModifyForm.event");
			// 카테고리 불러오기
			productWriteService = new ProductWriteService();
			String categorySelectList = productWriteService.categorySelectList();
			request.setAttribute("categorySelectList", categorySelectList);
			
			action = new EventModifyFormAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventModifyPro.event")) {	// 이벤트 수정 Pro
			System.out.println("/EventModifyPro.event");
			action = new EventModifyProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/EventList.event")) { // 이벤트 메인리스트
			System.out.println("/EventList.event");
			action = new EventListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}else if(command.equals("/EventDetail.event")) { // 이벤트 컨텐츠
			System.out.println("/EventDetail.event");
			action = new EventDetailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/Eventproductview.event")) { // 이벤트 관련 상품 불러오기
			System.out.println("/Eventproductview.event");
			action = new EventproductviewAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/EventDeletePro.event")) { // 이벤트 삭제
			System.out.println("/EventDeletePro.event");
			action = new EventDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		
		
		
		
		// ActionForward 객체 내의 포워딩 방식에 따라 각각의 포워딩 작업 수행
		if(forward != null) {
			
			if(forward.isRedirect()) { // redirect 방식
				response.sendRedirect(forward.getPath());
			}else { // dispatcher 방식
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
			
		}
		
		
		
	}	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}