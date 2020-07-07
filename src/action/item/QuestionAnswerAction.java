package action.item;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.QuestionAnswerSVC;
import svc.item.QuestionWriteSVC;
import vo.ActionForward;
import vo.QuestionBean;

public class QuestionAnswerAction implements Action {

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
		int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
		String qnaContent = request.getParameter("qnaContent");
		QuestionAnswerSVC questionAnswerSVC = new QuestionAnswerSVC();
		boolean isWriteSuccess = questionAnswerSVC.registAnswer(qnaNum,qnaContent);
		
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
