package event.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.EventService;
import vo.ActionForward;
import vo.EventBean;
import vo.PageInfo;

public class EventListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int page = 1;
		int limit = 10;
		
		
		String event_category = request.getParameter("event_category");
		
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		
		
		EventService eventService = new EventService();
		
		int listCount = eventService.getListCount(event_category);
		System.out.println("EventListAction - listCount : "+listCount);
		
		ArrayList<EventBean> articleList = eventService.getArticleList(page,limit,event_category);
		
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
			
		// request 객체에 PageInfo 객체와 ArrayList 객체 저장
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("articleList", articleList);
		
		forward = new ActionForward();
		forward.setPath("/event/EventHome.jsp");
		
		
		return forward;
	}

}
