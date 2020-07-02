package action.item;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.admin.ProductViewService;
import svc.item.GetCategorySVC;
import svc.item.OtherOptionListSVC;
import svc.item.QuestionListSVC;
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
		
		String category_sup = productBean.getProduct_category_code().substring(0,2); 
		if(category_sup.equals("DT")) {category_sup = "인형/토이";}
		else if(category_sup.equals("FA")) {category_sup = "문구";}
		else if(category_sup.equals("FS")) {category_sup = "패션";}
		else if(category_sup.equals("KB")) {category_sup = "주방";}
		else if(category_sup.equals("LD")) {category_sup = "리빙/데코";}
		else if(category_sup.equals("DI")) {category_sup = "디지털/가전";}
		else if(category_sup.equals("TR")) {category_sup = "여행";}
		else if(category_sup.equals("BE")) {category_sup = "뷰티";}
		request.setAttribute("category_sup", category_sup);
		
		GetCategorySVC getCategorySVC = new GetCategorySVC();
		String category_sub = getCategorySVC.getCategorySub(productBean.getProduct_category_code());
		request.setAttribute("category_sub", category_sub);
		
		//----------------------------------------------------------------------------------
		
		OtherOptionListSVC otherOptionListSVC = new OtherOptionListSVC();
		ArrayList<ProductBean> otherOptionList = otherOptionListSVC.getOtherOptionList(productBean.getProduct_option_code());
		request.setAttribute("otherOptionList", otherOptionList);
		
		
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
