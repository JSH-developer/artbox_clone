package action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.MemberListService;
import svc.admin.ProductListService;
import vo.ActionForward;
import vo.MemberBean;
import vo.PageInfo;
import vo.ProductBean;

public class MemberListProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		int page = 1; // 현재 페이지 번호를 저장할 변수
		int limit = 20; // 한 페이지 당 출력할 게시물 수 지정
		
		// 파라미터로 전달받은 페이지 번호가 있을 경우 가져와서 page 변수에 저장
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		String opt = request.getParameter("opt");
		String kwd = "";
		if(request.getParameter("kwd") != null) {
			kwd = request.getParameter("kwd");
		}
		
		MemberListService memberListService = new MemberListService();
		int listCount = 0;
		ArrayList<MemberBean> memberList = null;
		if(kwd.equals("")) { // 검색 안했을 때
			listCount = memberListService.getListCount();
			memberList = memberListService.getMemberList(page, limit); // svc에서 ArrayList 받아오기
		}else { // 검색 했을 때
			listCount = memberListService.getListCount(opt, kwd);
			memberList = memberListService.getMemberList(page, limit, opt, kwd); // svc에서 ArrayList 받아오기
		}
		
		int maxPage = (int)((double)listCount / limit + 0.95);
		int startPage = (((int)((double)page / 10 + 0.9))-1)*10 +1 ;
		int endPage = startPage + 10  - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		// request에 값 저장
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("memberList", memberList);
		
		forward.setPath("/admin/listMember.jsp");
		
		return forward;
	}

}
