package item.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import item.svc.QuestionListSVC;
import svc.ProductViewService;
import vo.ActionForward;
import vo.ProductBean;
import vo.QuestionBean;
import vo.QuestionPageInfo;

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
		
		//----------------------------------------------------------------------------------
		
		System.out.println("question시작");
		int q_pageNum = 1;	// 현재 페이지 번호
		int q_pageSize = 2;	// 한 페이지에 보여줄 게시물 수
		int q_pageBlock = 2;// 한 화면에 보여줄 페이지 수
		
		
		QuestionListSVC questionListSVC = new QuestionListSVC();
		ArrayList<QuestionBean> questionList = questionListSVC.getQuestionList(product_num, q_pageNum, q_pageSize);
		request.setAttribute("questionList", questionList);

		QuestionPageInfo questionPageInfo = questionListSVC.getPageInfo(product_num, q_pageNum, q_pageSize, q_pageBlock);
		request.setAttribute("questionPageInfo", questionPageInfo);
		
		//dispatcher 포워딩 
		forward = new ActionForward();
		forward.setPath("/item/itemDetail.jsp");
		
		return forward;
	}

}
