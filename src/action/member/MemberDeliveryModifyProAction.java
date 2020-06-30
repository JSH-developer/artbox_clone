package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class MemberDeliveryModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("MemberDeliveryModifyProAction");

		String id = request.getParameter("id");
		int receiverNum = Integer.parseInt(request.getParameter("num"));
		String receiver_name = request.getParameter("receiver_name");
		String receiver_phone = request.getParameter("receiver_phone");
		String receiver_postcode = request.getParameter("sample6_postcode");
		String receiver_addr = request.getParameter("sample6_address");
		String receiver_addr_detail = request.getParameter("addr_detail");
		
		
		
		
		forward = new ActionForward();
		forward.setPath("/member/myPageDeliveryModify.jsp");
		
		return forward;
	}

}
