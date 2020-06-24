package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.admin.Action;
import action.admin.AdminChangeStateProAction;
import action.admin.AdminOrderListProAction;
import action.admin.AdminOrderViewProAction;
import action.admin.CategoryDeleteProAction;
import action.admin.CategoryListProAction;
import action.admin.CategoryWriteProAction;
import action.admin.MemberDeleteProAction;
import action.admin.MemberListProAction;
import action.admin.MemberViewProAction;
import action.admin.OptionDeleteProAction;
import action.admin.OptionListProAction;
import action.admin.OptionWriteProAction;
import action.admin.ProductDeleteProAction;
import action.admin.ProductListProAction;
import action.admin.ProductModifyFormAction;
import action.admin.ProductModifyProAction;
import action.admin.ProductViewProAction;
import action.admin.ProductWriteProAction;
import svc.admin.OptionWriteService;
import svc.admin.ProductWriteService;
import vo.ActionForward;

@WebServlet("*.admin")
public class AdminFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String command = request.getServletPath();
		
		Action action = null;
		ActionForward forward = null;
		
		ProductWriteService productWriteService = new ProductWriteService();
		OptionWriteService optionWriteService = new OptionWriteService();
		
		if(command.equals("/home.admin")) { // 관리자 페이지 메인화면
			forward = new ActionForward();
			forward.setPath("/admin/adminHome.jsp");
		}else if(command.equals("/CategoryWriteForm.admin")) {
			// 글쓰기 페이지 요청은 비즈니스 로직이 없는 View 페이지(JSP)로 바로 연결 수행
			// => ActionForward 객체의 포워딩 방식을 별도로 설정하지 않음 => dispatcher 방식...
			forward = new ActionForward();
//			forward.setRedirect(false); 기본값이라서 생략 가능함
			forward.setPath("/admin/registCategory.jsp");
		}else if(command.equals("/CategoryWritePro.admin")) {
			action = new CategoryWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/CategoryList.admin")) {
			action = new CategoryListProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/CategoryDeletePro.admin")) { // 카테고리 삭제 수행
			action = new CategoryDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductWriteForm.admin")) { // 상품 등록 페이지
			forward = new ActionForward();
			
			String categorySelectList = productWriteService.categorySelectList();
			request.setAttribute("categorySelectList", categorySelectList);
//			String optionSelectList = productWriteService.optionSelectList();
//			request.setAttribute("optionSelectList", optionSelectList);
			
			forward.setPath("/admin/registProduct.jsp");
			
		}else if(command.equals("/ProductWritePro.admin")) { // 상품 등록 수행
			action = new ProductWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductList.admin")) { // 상품 리스트 페이지
			action = new ProductListProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductView.admin")) { // 상품 보기 페이지
			action = new ProductViewProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductModifyForm.admin")) { // 상품 수정 페이지 보기
			action = new ProductModifyFormAction();
			
			String categorySelectList = productWriteService.categorySelectList();
			request.setAttribute("categorySelectList", categorySelectList);
			String optionSelectList = productWriteService.optionSelectList();
			request.setAttribute("optionSelectList", optionSelectList);
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductModifyPro.admin")) { // 상품 수정 페이지 수행
			action = new ProductModifyProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductDeletePro.admin")) { // 상품 삭제 수행
			action = new ProductDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/OptionWriteForm.admin")) { // 옵션 등록 페이지
			String productSelectList = optionWriteService.productSelectList();
			request.setAttribute("productSelectList", productSelectList);
			forward = new ActionForward();
			forward.setPath("/admin/registOption.jsp");
			
		}else if(command.equals("/OptionWritePro.admin")) { // 옵션 등록 하기
			action = new OptionWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/OptionDeletePro.admin")) { // 옵션 삭제 수행
			action = new OptionDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/OptionList.admin")) { // 옵션 리스트 페이지
			action = new OptionListProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberList.admin")) { // 회원 리스트 페이지
			action = new MemberListProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberView.admin")) { // 회원 보기 페이지
			action = new MemberViewProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/MemberDeletePro.admin")) { // 회원 삭제 
			action = new MemberDeleteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/OrderList.admin")) { // 주문 리스트 페이지
			action = new AdminOrderListProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/OrderView.admin")) { // 주문 상세보기 페이지
			action = new AdminOrderViewProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/changeState.admin")) { // 배송 상태변경 페이지 연결
			try {
				forward=new ActionForward();
				forward.setPath("/admin/changeStateOfOrder.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/changeStatePro.admin")) { // 배송 상태변경 수행 
			action = new AdminChangeStateProAction();
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