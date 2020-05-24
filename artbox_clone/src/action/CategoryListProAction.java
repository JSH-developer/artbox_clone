package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CategoryListService;
import vo.ActionForward;
import vo.CategoryBean;

public class CategoryListProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		CategoryListService categoryListService = new CategoryListService();
		ArrayList<CategoryBean> categoryList =categoryListService.getCateogryList();
		
		request.setAttribute("categoryList", categoryList);
		
		forward.setPath("/admin/listCategory.jsp");
		return forward;
	}

}
