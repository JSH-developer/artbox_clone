package action.event;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import vo.ActionForward;

public class MypageGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 마이페이지에서 회원 등급별 페이지 불러오기
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
//		String id = (String)session.getAttribute("id");
//		String id = "jini";
//
//		EventService memberService = new EventService();
//		ArrayList<PointBean> Mypointrecode= memberService.selectMyPoint(id);
//		System.out.println(id);
//	
//		request.setAttribute("Mypointrecode", Mypointrecode);
		forward = new ActionForward();
		forward.setPath("event/myPageGrade.jsp");
		
		return forward;
	}

}
