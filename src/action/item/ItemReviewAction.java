package action.item;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.ReviewListSVC;
import vo.ActionForward;
import vo.ProductBean;

public class ItemReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ItemReviewAction");
		ActionForward forward = null;
		
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
		
		forward = new ActionForward();
		forward.setPath("/item/itemReview.jsp");
		return forward;
	}

}
