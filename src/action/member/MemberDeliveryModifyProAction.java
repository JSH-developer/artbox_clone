package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.member.MemberReceiverModifyService;
import vo.ActionForward;
import vo.ReceiverBean;

public class MemberDeliveryModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		System.out.println("MemberDeliveryModifyProAction");
		
		int receiverNum = Integer.parseInt(request.getParameter("num"));
		String receiver = request.getParameter("receiver");
		String receiver_name = request.getParameter("receiver_name");
		String receiver_phone = request.getParameter("receiver_phone");
		String receiver_postcode = request.getParameter("postcode");
		String receiver_addr = request.getParameter("addr");
		String receiver_addr_detail = request.getParameter("addr_detail");
		
		ReceiverBean rb = new ReceiverBean();
		rb.setReceiver(receiver);
		rb.setReceiver_num(receiverNum);
		rb.setReceiver_name(receiver_name);
		rb.setReceiver_phone(receiver_phone);
		rb.setReceiver_postcode(receiver_postcode);
		rb.setReceiver_addr(receiver_addr);
		rb.setReceiver_addr_detail(receiver_addr_detail);
		
		MemberReceiverModifyService rModifyPro = new MemberReceiverModifyService();
		rModifyPro.rModifyPro(rb);
		
		
		
		
		
		forward = new ActionForward();
		forward.setPath("/delivery.member");
		
		return forward;
	}

}
