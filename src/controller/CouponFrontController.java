package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.event.CouponAllListAction;
import action.event.CouponDeleteProAction;
import action.event.CouponIssuedAction;
import action.event.CouponSelectAction;
import action.event.CouponWriteProAction;
import action.event.MypageCouponListAction;
import vo.ActionForward;


@WebServlet("*.coupon")
public class CouponFrontController extends HttpServlet {


	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();

		Action action = null;
		ActionForward forward = null;


		if(command.equals("/listCoupon.coupon")){	// 쿠폰 등록 입력
			System.out.println("/listCoupon.coupon");

			action = new CouponAllListAction(); 
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}else if(command.equals("/CouponWritePro.coupon")) {	// 쿠폰 등록 Pro
			System.out.println("/CouponWritePro.coupon");
			action = new CouponWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/MypageCouponList.coupon")) {	// 마이페이지 
			System.out.println("/MypageCouponList.coupon");
			action = new MypageCouponListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/testSelectmain.coupon")) {	// 쿠폰 적용 테스트
			System.out.println("/testSelectmain.coupon");

			forward = new ActionForward();
			//		forward.setRedirect(false); // 포워딩 방식을 Dispatcher 방식으로 설정(기본값 생략 가능)
			forward.setPath("/event/PayCoupon.jsp"); // 이동할 View 페이지 경로 지정

			
		}else if(command.equals("/CouponIssued.coupon")) {	// 버튼누르면 쿠폰 발급
			System.out.println("/CouponIssued.coupon");
			action = new CouponIssuedAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/CouponSelect.coupon")) {	// 쿠폰 확인
			System.out.println("/CouponSelect.coupon");
			action = new CouponSelectAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/CouponDeletePro.coupon")) {	// 쿠폰 확인
			System.out.println("/CouponDeletePro.coupon");
			action = new CouponDeleteProAction();
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
