package action.Basket;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.Basket.BasketDeleteOneService;
import vo.ActionForward;

// 장바구니에서 선택된 물품을 삭제하는 BasketDeleteOneAction 클래스 정의
// 장바구니 삭제 성공 시 장바구니 목록(listBasket.basket)으로 이동
public class BasketDeleteOneAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BasketDeleteOneAction");
		ActionForward forward = null;
		
		String arrBasket = request.getParameter("arrBasket");
		System.out.println("가져온값" + arrBasket);
		
		// BasketDeleteOneService 인스턴스 생성 후 deleteBasket() 메서드 호출하여 장바구니 삭제하기
		// => 파라미터 : 장바구니 인덱스번호 배열로 받음(arrBasket), 리턴타입 : boolean(isDeleteSuccess)
		boolean isDeleteSuccess = BasketDeleteOneService.deleteBasket(arrBasket);
	
		// 삭제 결과에 따른 처리
		// => isDeleteSuccess 가 false 일 경우
		//    자바스크립트 사용하여 "삭제 실패!" 출력 후 이전페이지로 이동
		// => 아니면 ActionForward 객체를 사용하여 listBasket.basket 로 포워딩
		if(!isDeleteSuccess) { 
			// 자바 스크립트를 사용하여 "수정 실패!" 띄운 후 이전페이지로 돌아가기
			// 1. response 객체를 사용하여 문서 타입 및 인코딩 설정
			response.setContentType("text/html;charset=UTF-8");
			// 2. response 객체의 getWriter() 메서드를 호출하여
			//    출력스트림 객체(PrintWriter)를 리턴받음
			PrintWriter out = response.getWriter();
			// 3. PrintWriter 객체의 println() 메서드를 호출하여
			//    웹에서 수행할 작업(자바스크립트 출력 등)을 기술
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('장바구니 삭제실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back();"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그
		} else {
			System.out.println("장바구니 삭제 성공!");
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("listBasket.basket"); // listBasket.basket 로 포워딩
		}
		return forward;
	}
}
