package action.event;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.CouponService;
import svc.EventService;
import vo.ActionForward;
import vo.CouponBean;
import vo.EventBean;
import vo.PageInfo;
import vo.ProductBean;

public class EventDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("EventDetailAction");
		// 이벤트 상세 내용보여주기
		ActionForward forward = new ActionForward();
		
		int page = 1;
		int limit = 9;
		
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		// 조건 불러오기
		String condition = request.getParameter("condition");
		// 이벤트 조건, 이벤트 글num 불러오기
		int eBoard_Num = Integer.parseInt(request.getParameter("board_num"));
		
		request.setAttribute("e_condition", condition);
		request.setAttribute("e_board_num", eBoard_Num);
		
		
		// EventService 객체 호출
		EventService eventService = new EventService();
		// 조건에 맞는 이벤트 상품 카운트
		int listCount = eventService.selectEventItemListCount(condition);
		
		// 클릭한 이벤트 저장
		EventBean eventArticle = eventService.getEventArticle(eBoard_Num);
		
		// 조건에 맞는 이벤트 조건에 맞는 상품 불러오기
		ArrayList<ProductBean> itemList = eventService.getEventItemList(page,limit,condition);
		
		
		// 페이징 처리를 위해 페이지 수 계산
		// 1. 최대 페이지 번호 계산: 전체 게시물 수 / limit 결과를 반올림 처리 위해 0.95
		int maxPage = (int)((double)listCount / limit + 0.95);
		// 2. 현재 페이지에서 표시할 시작 페이지 번호 계산 (1, 11, 21 등)
		int startPage = (((int)((double)page/10+0.9)) - 1) *10 + 1 ;
		// 3. 현재 페이지에서 표시할 끝 페이지 번호 계산 (10,20,30 등)
		int endPage = startPage + 10 -1;
		// 단, 끝 페이지 번호가 최대 페이지 번호보다 클 경우
		// => 최대 페이지 번호를 끝 페이지 번호로 사용
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이징 정보를 저장할 PageInfo 객체 생성 및 데이터 저장
		PageInfo pageInfo = new PageInfo(page,maxPage,startPage,endPage,listCount);
		
		
		// 관련 쿠폰 불러오기
		CouponService couponService = new CouponService();
		CouponBean itemcoupon = couponService.getCouponList(condition);
		request.setAttribute("itemcoupon", itemcoupon);
		
			
		// request 객체에 PageInfo 객체와 ArrayList 객체 저장
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("itemList", itemList);
		request.setAttribute("eventArticle", eventArticle);
		
		
		
		
		forward.setPath("/event/EventDetail.jsp");
		
		
		return forward;
	}

}
