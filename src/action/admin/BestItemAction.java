package action.admin;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.NewsAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.EventService;
import svc.HomeService;
import svc.admin.BestItemService;
import vo.ActionForward;
import vo.EventBean;
import vo.ProductBean;

public class BestItemAction implements action.Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
//		베스트아이템 리스트
		BestItemService bestItemService = new BestItemService();
		
		List<ProductBean> bestItems = bestItemService.getBestList(); // svc에서 ArrayList 받아오기
		
		// request에 저장
		request.setAttribute("bestItems", bestItems);
		
//		new arrival 리스트
		HomeService newItemService = new HomeService();
		List<ProductBean> newItems = newItemService.getNewList();
		
		request.setAttribute("newItems", newItems);
		



		
//		event 리스트
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		EventService eventService = new EventService();
		int listCount = eventService.getAllListCount();
		System.out.println("EventListAction - listCount : "+listCount);
		
		ArrayList<EventBean> eventList = eventService.getAllArticleList(page,limit);
		
//		drop event
		System.out.println("dropEvent");
		eventService.dropEvent(eventList);
		
		request.setAttribute("eventList", eventList);
		
		
		forward.setPath("/home/home.jsp");
		return forward;
	}

}
