package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberReceiverModifyService;
import vo.ActionForward;
import vo.ReceiverBean;

public class MemberDeliveryModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("MemberDeliveryModifyAction");
		
		int receiverNum = Integer.parseInt(request.getParameter("num"));
		System.out.println("receiverNum - "+receiverNum);
		
		MemberReceiverModifyService MemberReceiverModifyService = new MemberReceiverModifyService();
		ReceiverBean rb = MemberReceiverModifyService.MemberReceiverModify(receiverNum);
		
		request.setAttribute("rb", rb);
		
		forward = new ActionForward();
		forward.setPath("/member/myPageDeliveryModify.jsp");
		
		return forward;
	}

}
