package action.item;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.item.ReviewListSVC;
import vo.ActionForward;
import vo.PageInfo;
import vo.ReviewBean;

public class ReviewListAction  implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewListAction");
		ActionForward forward = null;
		
		request.setCharacterEncoding("UTF-8");
		int porduct_num = Integer.parseInt(request.getParameter("product_num"));
		
		int page = 1; // 현재 페이지 번호를 저장할 변수
		int limit = 2; // 한 페이지 당 출력할 게시물 수 지정
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ReviewListSVC reviewListSVC = new ReviewListSVC();
		ArrayList<ReviewBean> reviewList = reviewListSVC.getReviewList(porduct_num,page,limit);
		request.setAttribute("reviewList",reviewList);

		
		int listCount = reviewListSVC.getReviewListCount(porduct_num);
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
		request.setAttribute("reviewPageInfo", pageInfo);

		
		forward = new ActionForward();
		forward.setPath("/item/reviewList.jsp");
		return forward;
	}
	
}
