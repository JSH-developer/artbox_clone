package action.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import vo.ActionForward;
import vo.ReviewBean;

public class ItemReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ItemReviewAction");
		ActionForward forward = null;
		ReviewBean reviewBean = null;
		
		//로그인 안했으면 id값 guest
		HttpSession session = request.getSession();
		if(session.getAttribute("id") == null) {
			session.setAttribute("id", "guest");
		}
		
		
		
		
		
		
		
		
		forward = new ActionForward();
		forward.setPath("/item/itemReview.jsp");
		return forward;
	}

}
