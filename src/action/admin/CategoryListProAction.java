package action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.CategoryListService;
import vo.ActionForward;
import vo.CategoryBean;
import vo.PageInfo;

public class CategoryListProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		int page = 1; // 현재 페이지 번호를 저장할 변수
		int limit = 20; // 한 페이지 당 출력할 게시물 수 지정
		
		// 파라미터로 전달받은 페이지 번호가 있을 경우 가져와서 page 변수에 저장
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		CategoryListService categoryListService = new CategoryListService();
		int listCount = categoryListService.getListCount();
		ArrayList<CategoryBean> categoryList =categoryListService.getCateogryList(page, limit);
		
		int maxPage = (int)((double)listCount / limit + 0.95);
		int startPage = (((int)((double)page / 10 + 0.9))-1)*10 +1 ;
		int endPage = startPage + 10  - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("categoryList", categoryList);
		
		forward.setPath("/admin/listCategory.jsp");
		return forward;
	}

}
