package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.admin.Action;
import svc.CartQuantityUpdateService;
import vo.ActionForward;

// 장바구니 수량 옵션 변경하는 CartQuantityUpdateAction 클래스 정의
public class CartQuantityUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CartQuantityUpdateAction");
		ActionForward forward = new ActionForward();
		int cartidx = Integer.parseInt(request.getParameter("cartidx"));
		int quantity = Integer.parseInt(request.getParameter("qty"));
		
		boolean isUpdateSuccess = CartQuantityUpdateService.updateCart(cartidx, quantity);
		
		// 수량 변경 결과에 따른 처리
		// => isUpdateSuccess 가 false 일 경우
		//    자바스크립트 사용하여 "수정 실패!" 출력 후 이전페이지로 이동
		// => 아니면 ActionForward 객체를 사용하여 listCart.cart 로 포워딩
		if(!isUpdateSuccess) { 
			// 1. response 객체를 사용하여 문서 타입 및 인코딩 설정
			response.setContentType("text/html;charset=UTF-8");
			// 2. response 객체의 getWriter() 메서드를 호출하여
			//    출력스트림 객체(PrintWriter)를 리턴받음
			PrintWriter out = response.getWriter();
			// 3. PrintWriter 객체의 println() 메서드를 호출하여
			//    웹에서 수행할 작업(자바스크립트 출력 등)을 기술
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('수량 변경 실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back();"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("listCart.cart");
		}
		
		return forward;
	}

}
