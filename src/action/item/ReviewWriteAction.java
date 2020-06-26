package action.item;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.ReviewWriteSVC;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewWriteAction");
		ActionForward forward = new ActionForward();
		ReviewBean reviewBean = new ReviewBean();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("id") == null) {
			session.setAttribute("id", "guest");
		}
		String member_id = (String)session.getAttribute("id");
		
		request.setCharacterEncoding("UTF-8");
		reviewBean.setReview_skill(Integer.parseInt(request.getParameter("skill")));
		reviewBean.setReview_design(Integer.parseInt(request.getParameter("design")));
		reviewBean.setReview_price(Integer.parseInt(request.getParameter("price")));
		reviewBean.setReview_quality(Integer.parseInt(request.getParameter("quality")));
		reviewBean.setReview_content(request.getParameter("content"));
		reviewBean.setReview_member_id(member_id);
		reviewBean.setReview_product_num(Integer.parseInt(request.getParameter("product_num")));
		
		ReviewWriteSVC reviewWriteSVC = new ReviewWriteSVC();
		boolean isWriteSuccess = reviewWriteSVC.registReview(reviewBean);
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('review 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			System.out.println("review 등록 성공!");
			forward.setRedirect(true);
			forward.setPath("itemReview.item");
		}
		
		return forward;
	}

}
