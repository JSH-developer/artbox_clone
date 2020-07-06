package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.MemberViewService;
import svc.admin.ProductViewService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberViewProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		MemberBean memberBean = null;
		
		int num = Integer.parseInt(request.getParameter("num")); // svc에 전달할 인덱스 값 받아오기
		
		MemberViewService memberViewService = new MemberViewService();
		memberBean = memberViewService.infoMember(num); // svc에서 MemberBean 받아오기
		// request에 값 저장
		request.setAttribute("memberBean", memberBean);
		request.setAttribute("num", num);
		
		forward.setPath("/admin/viewMember.jsp");
		return forward;
	}

}
