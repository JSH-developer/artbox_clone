package action.item;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.ItemReviewListSVC;
import vo.ActionForward;
import vo.PageInfo;
import vo.ProductBean;

public class ItemReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		System.out.println(id);
		int page = 1; // 현재 페이지 번호를 저장할 변수
		int limit = 10; // 한 페이지 당 출력할 게시물 수 지정
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ItemReviewListSVC itemReviewListSVC = new ItemReviewListSVC();
		ArrayList<ProductBean> itemReviewList = itemReviewListSVC.getItemReviewList(id,page,limit);
		request.setAttribute("itemReviewList",itemReviewList);
		
		
		
		int listCount = itemReviewListSVC.getItemReviewListCount(id);
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
		
//		Date now = new Timestamp(System.currentTimeMillis());
//		Date now2 = null;
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		now = sdf.parse(now.toString());
//		request.setAttribute("now", now);
//		System.out.println("now : "+now);
//		
//		for(ProductBean product : reviewList) {
//			System.out.println("now2 : "+product.getProduct_regdate());
//			now2 = sdf.parse(product.getProduct_regdate().toString());
//			System.out.println("now after : "+now);
//			System.out.println("now2 after : "+now2);
//			
//			if(now2.after(now)) System.out.println("now2는 now보다 미래이다!");
//			if(now2.before(now)) {
//				System.out.println("now2는 now보다 과거이다!");
//			}
//			if(now2.equals(now)) System.out.println("now2는 now와 같다!!");
//		}
		
		forward = new ActionForward();
		forward.setPath("/item/itemReview.jsp");
		return forward;
	}

}
