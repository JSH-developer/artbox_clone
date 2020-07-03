package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberDeliveryAddService;
import svc.member.ReceiverSelectService;
import vo.ActionForward;
import vo.ReceiverBean;

public class MemberDeliveryAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		ReceiverBean rb = new ReceiverBean();
		rb.setReceiver_member_id(request.getParameter("id")); // 아이디
		rb.setReceiver(request.getParameter("receiver")); // 배송지명
		rb.setReceiver_name(request.getParameter("receiver_name")); // 수신자 이름
		rb.setReceiver_phone(request.getParameter("receiver_phone")); // 수신자 폰번호
		rb.setReceiver_postcode(request.getParameter("postcode")); // 수신자 우편번호
		rb.setReceiver_addr(request.getParameter("addr")); // 수신자 기본주소
		rb.setReceiver_addr_detail(request.getParameter("addr_detail")); // 수신자 상세주소
		
		MemberDeliveryAddService MemberDeliveryAddService = new MemberDeliveryAddService();
		int success = MemberDeliveryAddService.MemberDeliveryAdd(rb);
		
		if(success == 1) {
			ReceiverSelectService ReceiverSelectService = new ReceiverSelectService();
			List list = ReceiverSelectService.ReceiverSelect(rb.getReceiver_member_id());
			
			request.setAttribute("list", list);
			System.out.println("list - "+list);
		}
		
		forward = new ActionForward();
		forward.setPath("/member/myPageDelivery.jsp");
		
		return forward;
	}

}
