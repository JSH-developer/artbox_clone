package action.Basket;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.Basket.BasketQuantityUpdateService;
import vo.ActionForward;

// 장바구니 수량 옵션 변경하는 BasketQuantityUpdateAction 클래스 정의
public class BasketQuantityUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("BasketQuantityUpdateAction");
		ActionForward forward = new ActionForward();
		
		int basketIdx = Integer.parseInt(request.getParameter("basketIdx")); // 장바구니 번호
		int quantity = Integer.parseInt(request.getParameter("qty")); // 상품수량
		
		// BasketQuantityUpdateService 인스턴스 생성 후 updateBasket() 메서드 호출하여 수량 변경하기
		// 파라미터 : (basketIdx, quantity), 리턴타입 : boolean(isUpdateSuccess)
		boolean isUpdateSuccess = BasketQuantityUpdateService.updateBasket(basketIdx, quantity);
		
		// 수량 변경 결과에 따른 처리
		// => isUpdateSuccess 가 false 일 경우
		//    자바스크립트 사용하여 "수정 실패!" 출력 후 이전페이지로 이동
		// => 아니면 ActionForward 객체를 사용하여 listBasket.basket 로 포워딩
		if(!isUpdateSuccess) { 
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('수량 변경 실패!')");
			out.println("history.back();");
			out.println("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("listBasket.basket");
		}
		return forward;
	}
}
