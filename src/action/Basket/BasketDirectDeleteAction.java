package action.Basket;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.BasketDeleteService;
import vo.ActionForward;

// itemList.jsp 에서 특정 물품을 삭제하는 BasketDirectDeleteAction 클래스 정의
public class BasketDirectDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BasketDirectDeleteAction");
		ActionForward forward = null;
		
		// 세션값(id) 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		System.out.println("가져온 값 : " + id + " , " + product_num);
		// BasketDeleteOneService 인스턴스 생성 후 deleteBasket() 메서드 호출하여 장바구니 삭제하기
		// => 파라미터 : (id, product_num), 리턴타입 : boolean(isDeleteSuccess)
		boolean isDeleteSuccess = BasketDeleteService.deleteBasket(id, product_num);
	
		if(!isDeleteSuccess) { 
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('장바구니 삭제실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back();"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그
		}
		return forward;
	}
}
