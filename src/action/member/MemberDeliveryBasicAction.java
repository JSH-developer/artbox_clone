package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberReceiverModifyService;
import vo.ActionForward;

public class MemberDeliveryBasicAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberDeliveryBasicAction");
		ActionForward forward = null;
		
		int receiverNum = Integer.parseInt(request.getParameter("num"));
		String id = request.getParameter("id");
		System.out.println("action id - "+id);
		MemberReceiverModifyService ReceiverBasic = new MemberReceiverModifyService();
		ReceiverBasic.ReceiverBasic(receiverNum, id);
		
		forward = new ActionForward();
		forward.setPath("delivery.member");
		
		return forward;
	}

}
