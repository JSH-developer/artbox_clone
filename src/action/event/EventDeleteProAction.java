package action.event;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.EventService;
import vo.ActionForward;

public class EventDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		// admin 확인 절차 넣기
		
		String board_num = request.getParameter("board_num");
		String event_category = request.getParameter("event_category");
		
		EventService eventService = new EventService();
		boolean isDelete = eventService.deleteEvent(board_num);
		
		if(!isDelete) {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('이벤트 삭제 실패')");
			out.println("history.back()"); 
			out.println("</script>");
			
		}else {
			System.out.println("글삭제성공!");
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("EventList.event?event_category="+event_category);
			
		}
		


		
		
		return forward;
	}

}
