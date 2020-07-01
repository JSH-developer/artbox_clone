package action.item;

import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.ReviewListSVC;
import vo.ActionForward;
import vo.PageInfo;
import vo.ProductBean;

public class ItemReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ItemReviewAction");
		ActionForward forward = null;
		PageInfo pageInfo = new PageInfo();
		if(request.getParameter("page") != null) {
			pageInfo.setPage(Integer.parseInt(request.getParameter("page")));
		}
		
		//로그인 안했으면 id값 guest
		HttpSession session = request.getSession();
		if(session.getAttribute("id") == null) {
			session.setAttribute("id", "guest");
		}
		
		ReviewListSVC reviewListSVC = new ReviewListSVC();
		ArrayList<ProductBean> reviewList = reviewListSVC.getReviewList((String)session.getAttribute("id"));
		request.setAttribute("reviewList",reviewList);
		
		String tab = request.getParameter("tab");
		if(tab=="mod") {
			
		}
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		request.setAttribute("now", now);
		System.out.println(now);
		
		for(ProductBean product : reviewList) {
			System.out.println(product.getProduct_regdate());
		}
		
		forward = new ActionForward();
		forward.setPath("/item/itemReview.jsp");
		return forward;
	}

}
