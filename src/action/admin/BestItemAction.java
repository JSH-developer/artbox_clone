package action.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.admin.BestItemService;
import vo.ActionForward;
import vo.ProductBean;

public class BestItemAction implements action.Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		BestItemService bestItemService = new BestItemService();
		
		List<ProductBean> bestItems = bestItemService.getBestList();
		
		request.setAttribute("bestItems", bestItems);
		
		forward.setPath("/home/home.jsp");
		return forward;
	}

}
