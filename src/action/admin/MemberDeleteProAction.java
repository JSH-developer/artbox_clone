package action.admin;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.MemberDeleteService;
import svc.admin.ProductDeleteService;
import vo.ActionForward;

public class MemberDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		// 상품 인덱스, 페이지, opt(분류기준), kwd(검색단어) 받아오기 -> 원래 페이지 이동을 위해
		int num = Integer.parseInt(request.getParameter("num"));
		String page = request.getParameter("page");
		String opt = request.getParameter("opt"); 
		String kwd = request.getParameter("kwd"); 
		
		
		MemberDeleteService memberDeleteService = new MemberDeleteService();
		boolean isDelete = memberDeleteService.deleteMember(num); // svc에서 삭제 수행
		
		if(isDelete) {
			forward = new ActionForward();
			forward.setPath("/MemberList.admin?page="+page+"&opt="+opt+"&kwd="+kwd);
		}else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('삭제에 실패하였습니다!!')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}

}
