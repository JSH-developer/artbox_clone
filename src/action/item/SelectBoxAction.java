package action.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import vo.ActionForward;

public class SelectBoxAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward fw = new ActionForward();
		fw.setPath("/item/itemList.jsp");
		String kwd = request.getParameter("kwd");
		String status = request.getParameter("status");
		
		System.out.println("kwd = "+kwd);
		System.out.println("status = "+status);
		
		
		
		return fw;
	}

}
