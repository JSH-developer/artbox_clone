package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import svc.member.ReceiverSelectService;
import vo.ActionForward;

public class receiverList implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		System.out.println("id - "+id);
		ReceiverSelectService ReceiverSelectService = new ReceiverSelectService();
		List list = ReceiverSelectService.ReceiverSelect(id);
		
		request.setAttribute("list", list);
		
		forward = new ActionForward();
		forward.setPath("/member/myPageDelivery.jsp");
		
		return forward;
	}

}
