package action.Basket;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.BasketInsertService;
import vo.ActionForward;
import vo.BasketBean;

// itemDetail 페이지에서 장바구니 담기 버튼 클릭시 장바구니에 추가하는 BasketAddAction 클래스 정의
// 장바구니 담기 성공 시 장바구니 목록(listBasket.basket)으로 이동
public class BasketInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BasketInsertAction");
		ActionForward forward = null;
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		request.setCharacterEncoding("UTF-8");
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/memberLoginForm.member");
			return forward;
		}
		String result = request.getParameter("result");
		
		// 장바구니 추가를 위해 입력받은 데이터를 저장할 BasketBean 객체 생성
		BasketBean basketBean = new BasketBean();
		// request 객체로부터 입력받은 데이터를 가져와서 BasketBean 객체에 저장
		basketBean.setBasket_quantity(Integer.parseInt(request.getParameter("stockqty"))); // 수량
		basketBean.setBasket_member_id(id); // 아이디
		basketBean.setBasket_product_num(Integer.parseInt(request.getParameter("num"))); // 상품번호
		
		// basketAddService 인스턴스 생성 후 insertBasket() 메서드 호출하여 장바구니 추가하기
		BasketInsertService basketAddService = new BasketInsertService();
		// 파라미터 : BasketBean 객체, 리턴타입 : boolean(isBasketAddSuccess)
		boolean isBasketAddSuccess = basketAddService.insertBasket(basketBean);
		
		// 리턴받은 결과를 사용하여 장바구니 등록 결과 판별
		if(!isBasketAddSuccess) {
			System.out.println("장바구니 등록 실패!");
			// 2. response 객체의 getWriter() 메서드를 호출하여
			//    출력스트림 객체(PrintWriter)를 리턴받음
			PrintWriter out = response.getWriter();
			// 3. PrintWriter 객체의 println() 메서드를 호출하여
			//    웹에서 수행할 작업(자바스크립트 출력 등)을 기술
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('장바구니 등록 실패!')"); // 다이얼로그 메세지 출력
			out.println("history.back();"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그
		} else {
			System.out.println("장바구니 등록 성공!");
			if(result.equals("true")) { // 장바구니 등록 후 장바구니로 이동
				// 현재 페이지에서 listBasket.basket 서블릿 주소를 요청하여 Redirect 방식으로 포워딩
				// 1. ActionForward 객체 생성
				forward = new ActionForward();
				// 2. 포워딩 방식 지정 => Redirect 방식이므로 파라미터에 true 전달(필수)
				forward.setRedirect(true);
				// 3. 포워딩 할 주소 지정 => 서블릿 주소 listBasket.basket 요청
				forward.setPath("listBasket.basket");
			} else { // 장바구니 등록은 했으나 장바구니로 이동하지 않고 상품디테일 페이지 유지
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("productDetail.basket");
			}
		}
		
		return forward;
	}

}
