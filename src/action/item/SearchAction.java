package action.item;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.item.SearchSVC;
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
		//검색된 상품 
		product = searchSVC.search(kwd);
		request.setAttribute("productBean", product);
		
		// 검색된 총 상품갯수 
		int count = product.size();
		request.setAttribute("count", count);
		
		//셀렉트박스 검색을 위한 저장
		request.setAttribute("select", kwd);
		request.setAttribute("nowStatus", 0);
		
		//기존에 존재하던 하위카테고리 삭제 
		HttpSession session = request.getSession();
		session.removeAttribute("printCategory");
		
		return fw;
	}

}
