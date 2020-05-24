package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.CategoryWriteService;
import vo.ActionForward;
import vo.CategoryBean;

public class CategoryWriteProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		CategoryWriteService categoryWriteService = new CategoryWriteService();
		CategoryBean categoryBean = new CategoryBean();
		categoryBean.setCategory_sup(request.getParameter("category_sup"));
		categoryBean.setCategory_sub(request.getParameter("category_sub"));
		boolean isRegist = categoryWriteService.registCategory(categoryBean);
		if(isRegist) {
			forward = new ActionForward();
			forward.setPath("/CategoryList.admin");
		}else {
			System.out.println("카테고리 등록 실패");
		}
		
		return forward;
	}

}
