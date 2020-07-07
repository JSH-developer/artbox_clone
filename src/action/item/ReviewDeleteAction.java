package action.item;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import svc.item.ReviewDeleteSVC;
import svc.item.ReviewUpdateSVC;
import svc.item.ReviewWriteSVC;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		request.setCharacterEncoding("UTF-8");
		int review_num = Integer.parseInt(request.getParameter("review_num"));
		
		ReviewDeleteSVC reviewDeleteSVC = new ReviewDeleteSVC();
		boolean isDeleteSuccess = reviewDeleteSVC.deleteReview(id,review_num);
	
		if(!isDeleteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('review 삭제 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			forward.setRedirect(true);
			forward.setPath("itemReview.item");
		}
		
		return forward;
	}

}
