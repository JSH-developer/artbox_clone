package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.member.MyPageReService;
import vo.ActionForward;
import vo.OrdersBean;

public class MyPageReProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		// id 받아오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		MyPageReService myPageReService = new MyPageReService();
		List<OrdersBean> myRes = myPageReService.getMyRes(id); // svc에서 ArrayList 받아오기
		
		// request에 값 저장
		request.setAttribute("myRes", myRes);
		
		forward.setPath("/member/myPageRe.jsp");
		return forward;
	}


}
