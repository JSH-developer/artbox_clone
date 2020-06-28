package action.event;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.CouponService;
import svc.EventService;
import vo.ActionForward;
import vo.CouponBean;

public class PointListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		
		ServletContext context = request.getServletContext();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");

		EventService memberService = new EventService();
	
		
		return forward;
	}

}
