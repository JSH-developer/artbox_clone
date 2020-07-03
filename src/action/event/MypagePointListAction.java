package action.event;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.EventService;
import vo.ActionForward;
import vo.PointBean;

public class MypagePointListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
//		String id = (String)session.getAttribute("id");
		String id = (String)session.getAttribute("id");

		EventService memberService = new EventService();
		ArrayList<PointBean> Mypointrecode= memberService.selectMyPoint(id);
		System.out.println(id);
	
		request.setAttribute("Mypointrecode", Mypointrecode);
		forward = new ActionForward();
		forward.setPath("event/myPagePoint.jsp");
		
		return forward;
	}

}
