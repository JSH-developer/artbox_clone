package action.Basket;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.BasketInsertService;
import vo.ActionForward;
import vo.BasketBean;

// itemDetail.jsp 페이지에서 장바구니 담기 버튼 클릭시 장바구니에 추가하는 BasketInsertAction 클래스 정의
// 장바구니 담기 성공 시 장바구니 목록(listBasket.basket)으로 이동
public class BasketInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("BasketInsertAction");
		request.setCharacterEncoding("UTF-8");
		ActionForward forward = null;
		
		// 세션값(id) 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		// 세션값(id) 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/loginForm.member");
			return forward;
		}
		
		String result = request.getParameter("result");
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		// 장바구니 추가를 위해 입력받은 데이터를 저장할 BasketBean 객체 생성
		BasketBean basketBean = new BasketBean();
		// request 객체로부터 입력받은 데이터를 가져와서 BasketBean 객체에 저장
		basketBean.setBasket_quantity(Integer.parseInt(request.getParameter("stockqty"))); // 수량
		basketBean.setBasket_member_id(id); // 아이디
		basketBean.setBasket_product_num(product_num); // 상품번호
		
		// BasketInsertService 인스턴스 생성 후 insertBasket() 메서드 호출하여 장바구니 추가하기
		// 파라미터 : BasketBean 객체, 리턴타입 : boolean(isBasketInsertSuccess)
		BasketInsertService basketInsertService = new BasketInsertService();
		boolean isBasketInsertSuccess = basketInsertService.insertBasket(basketBean);
		
		// 리턴받은 결과를 사용하여 장바구니 등록 결과 판별
		if(!isBasketInsertSuccess) {
			System.out.println("장바구니 등록 실패!");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('장바구니 등록 실패!')");
			out.println("history.back();");
			out.println("</script>");
		} else {
			System.out.println("장바구니 등록 성공!");
			if(result.equals("true")) { // 장바구니 등록 후 장바구니로 이동(listBasket.basket)
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("listBasket.basket");
			} else { // 장바구니 등록은 했으나 장바구니로 이동하지 않고 상품디테일 페이지 유지(productDetail.basket)
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("itemDetail.item?product_num="+product_num);
			}
		}
		return forward;
	}
}
