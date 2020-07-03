package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberReceiverModifyService;
import vo.ActionForward;

public class MemberDeliveryDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberDeliveryDeleteAction");
		ActionForward forward = null;
		
		int receiverNum = Integer.parseInt(request.getParameter("num"));
		
		MemberReceiverModifyService ReceiverDelete = new MemberReceiverModifyService();
		ReceiverDelete.ReceiverDelete(receiverNum);
		
		
		forward = new ActionForward();
		forward.setPath("delivery.member");
		
		return forward;
	}

}
