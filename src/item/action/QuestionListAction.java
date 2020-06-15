package item.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import item.svc.QuestionListSVC;
import vo.ActionForward;
import vo.QuestionBean;
import vo.QuestionPageInfo;

public class QuestionListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("QuestionListAction");
		ActionForward forward = null;
		
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int pageBlock = Integer.parseInt(request.getParameter("pageBlock"));
		
		QuestionListSVC questionListSVC = new QuestionListSVC();
		ArrayList<QuestionBean> questionList = questionListSVC.getQuestionList(product_num, pageNum, pageSize);
		request.setAttribute("questionList", questionList);

		QuestionPageInfo questionPageInfo = questionListSVC.getPageInfo(product_num, pageNum, pageSize, pageBlock);
		request.setAttribute("questionPageInfo", questionPageInfo);
		
		forward = new ActionForward();
		forward.setPath("/item/questionList.jsp");
		return forward;
	}

}
