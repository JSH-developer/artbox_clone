package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.EventService;
import vo.ActionForward;
import vo.EventBean;

public class EventModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("EventModifyFormAction");
		
		ActionForward forward  =null;
		
		// 이벤트 조건, 이벤트 글num 불러오기
		int eBoard_Num = Integer.parseInt(request.getParameter("board_num"));
		
		// EventService 객체 호출
		EventService eventService = new EventService();
		EventBean eventArticle = eventService.getEventArticle(eBoard_Num);
		request.setAttribute("eventArticle", eventArticle);
		
		
		forward = new ActionForward();
		forward.setPath("/event/modifyEvent.jsp");
		
		return forward;
	}

}
