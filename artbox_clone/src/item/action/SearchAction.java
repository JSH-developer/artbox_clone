package item.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import item.svc.SearchSVC;
import vo.ActionForward;
import vo.ProductBean;

public class SearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward fw = new ActionForward();
		fw.setPath("/item/itemList.jsp");
		ArrayList<ProductBean> product = new ArrayList<ProductBean>();
		String kwd = request.getParameter("kwd");
		SearchSVC searchSVC = new SearchSVC();
		product = searchSVC.search(kwd);
		request.setAttribute("productBean", product);
		
		int count = product.size();
		request.setAttribute("count", count);
		
		HttpSession session = request.getSession();
		session.removeAttribute("printCategory");
		
		return fw;
	}

}
