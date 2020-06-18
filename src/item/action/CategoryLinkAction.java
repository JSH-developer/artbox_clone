package item.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import action.Action;
import item.svc.CategoryMajorLinkSVC;
import item.svc.CategoryMinorLinkSVC;
import vo.ActionForward;
import vo.MajorCategory;
import vo.PrintCategory;
import vo.ProductBean;

public class CategoryLinkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward actionForward = new ActionForward();
		HttpSession session = request.getSession();
		String majorCategory = request.getParameter("major");
		String minorCategory = request.getParameter("minor");
		ArrayList<ProductBean> productBean = new ArrayList<ProductBean>();
		int count = 0;
		
		if(minorCategory==null) {
			//대분류 파라미터 검증 
			findCategory(majorCategory,request,session);
			
			//대분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMajorLinkSVC majorLinkSVC = new CategoryMajorLinkSVC();
			productBean = majorLinkSVC.linkSVC(majorCategory);
			count = productBean.size();
			request.setAttribute("productBean", productBean);
			request.setAttribute("count", count);
			request.setAttribute("nowStatus", 1);
			
		}else {
			//소분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMinorLinkSVC minorLinkSVC = new CategoryMinorLinkSVC();
			productBean = minorLinkSVC.minorLinkSVC(minorCategory);
			count = productBean.size();
			request.setAttribute("productBean", productBean);
			request.setAttribute("count", count);
			request.setAttribute("select", minorCategory);
			request.setAttribute("nowStatus", 2);
			
		}
		
		
		
		actionForward.setPath("/item/itemList.jsp");
		return actionForward;
	}
	
	public void setAttribute(String majorCategory, String name, String[] printCategory, HttpServletRequest request, HttpSession session) {
		
		session.setAttribute("code", majorCategory);
		session.setAttribute("name", name);
		request.setAttribute("select", majorCategory);
		session.setAttribute("printCategory", printCategory);
	}
	
	public void findCategory(String majorCategory, HttpServletRequest request, HttpSession session) {
		String[] printCategory = null;
		PrintCategory print = new PrintCategory();
		
		if(majorCategory.equals(MajorCategory.디지털가전.getCode())) {
			printCategory = print.디지털가전();
			setAttribute(majorCategory,"디지털/가전",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.리빙데코.getCode())) {
			printCategory = print.리빙데코();
			setAttribute(majorCategory,"리빙/데코",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.문구.getCode())) {
			printCategory = print.문구();
			setAttribute(majorCategory,"문구",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.여행.getCode())) {
			printCategory = print.여행();
			setAttribute(majorCategory,"여행",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.뷰티.getCode())) {
			printCategory = print.뷰티();
			setAttribute(majorCategory,"뷰티",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.인형토이.getCode())) {
			printCategory = print.인형토이();
			setAttribute(majorCategory,"인형/토이",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.주방욕실.getCode())) {
			printCategory = print.주방욕실();
			setAttribute(majorCategory,"주방/욕실",printCategory,request,session);
		}
		if(majorCategory.equals(MajorCategory.패션.getCode())) {
			printCategory = print.패션();
			setAttribute(majorCategory,"패션",printCategory,request,session);
		}
	}
	

}
