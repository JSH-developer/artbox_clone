package action.item;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.QuestionAnswerSVC;
import svc.item.QuestionWriteSVC;
import svc.item.ReviewAnswerSVC;
import vo.ActionForward;
import vo.QuestionBean;

public class ReviewAnswerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		

		HttpSession session = request.getSession();
		String grade = (String)session.getAttribute("grade");

		if(!grade.equals("ADMIN")) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자가 아닙니다')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		request.setCharacterEncoding("UTF-8");
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		int reNum = Integer.parseInt(request.getParameter("reNum"));
		String reName = request.getParameter("reName");
		String reContent = request.getParameter("reContent");
		
		ReviewAnswerSVC reviewAnswerSVC = new ReviewAnswerSVC();
		boolean isWriteSuccess = reviewAnswerSVC.registAnswer(reNum,reName,reContent);
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('답변 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			request.setAttribute("product_num", request.getParameter("product_num"));
			forward.setRedirect(true);
			forward.setPath("itemDetail.item?product_num="+request.getParameter("product_num"));
		}
		return forward;
	}

}
