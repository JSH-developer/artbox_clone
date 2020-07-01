package action.item;

import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.ReviewListSVC;
import vo.ActionForward;
import vo.PageInfo;
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

		int page = 1; // 현재 페이지 번호를 저장할 변수
		int limit = 8; // 한 페이지 당 출력할 게시물 수 지정
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ReviewListSVC reviewListSVC = new ReviewListSVC();
		ArrayList<ProductBean> reviewList = reviewListSVC.getReviewList((String)session.getAttribute("id"),page,limit);
		request.setAttribute("reviewList",reviewList);
		
		
		
		int listCount = reviewListSVC.getListCount((String)session.getAttribute("id"));
		// 1. 최대 페이지 번호 계산 : 전체 게시물 수 / limit 결과를 반올림 처리 위해 0.95 더함
		int maxPage = (int)((double)listCount / limit + 0.95);
		// 2. 현재 페이지에서 표시할 시작 페이지 번호 계산(1, 11, 21 등)
		int startPage = (((int)((double)page / 10 + 0.9)) - 1) * 10 + 1;
		// 3. 현재 페이지에서 표시할 끝 페이지 번호 계산(10, 20, 30 등)
		int endPage = startPage + 10 - 1;
		// 단, 끝 페이지 번호가 최대 페이지 번호보다 클 경우 
		// => 최대 페이지 번호를 끝 페이지 번호로 사용
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이징 정보를 저장할 PageInfo 객체 생성 및 데이터 저장
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		
		// request 객체에 PageInfo 객체와 ArrayList 객체 저장
		request.setAttribute("pageInfo", pageInfo);
		
		
		
//		String tab = request.getParameter("tab");
//		if(tab=="mod") {
//			
//		}
		
//		Timestamp now = new Timestamp(System.currentTimeMillis());
//		request.setAttribute("now", now);
//		System.out.println(now);
//		
//		for(ProductBean product : reviewList) {
//			System.out.println(product.getProduct_regdate());
//		}
		
		forward = new ActionForward();
		forward.setPath("/item/itemReview.jsp");
		return forward;
	}

}
