package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.event.EventDeleteProAction;
import action.event.EventDetailAction;
import action.event.EventCategoryListAction;
import action.event.EventModifyFormAction;
import action.event.EventModifyProAction;
import action.event.EventWriteProAction;
import action.event.EventproductviewAction;
import action.event.listEventAction;
import svc.admin.ProductWriteService;
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
			
		}else if(command.equals("/EventCategoryList.event")) { // 이벤트 메인리스트 - sale_event
			System.out.println("/EventCategoryList.event");
			action = new EventCategoryListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}else if(command.equals("/EventDetail.event")) { // 클릭한 이벤트 컨텐츠
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
		}else if(command.equals("/listEvent.event")) { // 이벤트 삭제
			System.out.println("/listEvent.event");
			action = new listEventAction();
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