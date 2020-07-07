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
		// 이벤트 삭제 action
		ActionForward forward = null;
		
		// admin 확인 절차 넣기
		
		String board_num = request.getParameter("board_num");
		String condition = request.getParameter("condition");
		
		EventService eventService = new EventService();
		boolean isDelete = eventService.deleteEvent(board_num,condition);
		
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(!isDelete) {
			
			out.println("<script type=\"text/javascript\">");
			out.println("alert('이벤트 삭제 실패')");
			out.println("history.back()"); 
			out.println("</script>");
			
		}else {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('이벤트 삭제되었습니다')");
			out.println("</script>");
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("listEvent.event");
			
		}
		


		
		
		return forward;
	}

}
