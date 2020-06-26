package action.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.ProductViewService;
import vo.ActionForward;
import vo.ProductBean;

public class ItemDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		ProductBean productBean = null;
		//파라미터로 전달된 게시물 넘버값 
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		//로그인 안했으면 id값 guest
		HttpSession session = request.getSession();
		if(session.getAttribute("id") == null) {
			session.setAttribute("id", "guest");
		}
		//admin의 svc.ProductViewService 객체 재활용 
		ProductViewService pvs = new ProductViewService();
		productBean = pvs.infoProduct(product_num);
	
		request.setAttribute("productBean", productBean);
		
		//dispatcher 포워딩 
		forward = new ActionForward();
		forward.setPath("/item/itemDetail.jsp");
		
		return forward;
	}

}
