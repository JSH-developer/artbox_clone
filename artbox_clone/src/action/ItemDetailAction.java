package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ProductViewService;
import vo.ActionForward;
import vo.ProductBean;

public class ItemDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		ProductBean productBean = null;
		
		// 파라미터로 전달된 게시물 번호(product_num) 가져오기
//		int product_num = Integer.parseInt(request.getParameter("product_num"));
		int product_num = Integer.parseInt(request.getParameter("num"));

		// ItemDetailService 인스턴스 생성 후 getArticle() 메서드 호출하여 상세내용 가져오기
		ProductViewService pvs = new ProductViewService();
		productBean = pvs.infoProduct(product_num);
		// request 객체에 BoardBean 객체 저장
		request.setAttribute("productBean", productBean);
		
		// board 폴더 내의 qna_board_view.jsp 페이지로 포워딩
		// => 요청된 서블릿 주소가 유지되므로 Dispatcher 방식으로 포워딩
		forward = new ActionForward();
		forward.setPath("/item/itemDetail.jsp");
		
		return forward;
	}

}
