package action.item;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.item.QuestionWriteSVC;
import vo.ActionForward;
import vo.QuestionBean;

public class QuestionWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		request.setCharacterEncoding("UTF-8");
		QuestionBean questionBean = new QuestionBean();
		questionBean.setQuestion_email(request.getParameter("email"));
		questionBean.setQuestion_field(request.getParameter("fild"));
		questionBean.setQuestion_title(request.getParameter("title"));
		questionBean.setQuestion_content(request.getParameter("content"));
		questionBean.setQuestion_member_id(request.getParameter("id"));
		questionBean.setQuestion_product_num(Integer.parseInt(request.getParameter("product_num")));
		
		QuestionWriteSVC questionWriteSVC = new QuestionWriteSVC();
		boolean isWriteSuccess = questionWriteSVC.registQuestion(questionBean);
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('qna 등록 실패!')");
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
