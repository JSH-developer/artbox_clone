package action.item;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import action.Action;
import svc.item.CategoryMajorLinkSVC;
import svc.item.CategoryMinorLinkSVC;
import svc.item.SearchSVC;
import vo.ActionForward;
import vo.MajorCategory;
import vo.PrintCategory;
import vo.ProductBean;

public class CategoryLinkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ActionForward actionForward = new ActionForward();
		String majorCategory = request.getParameter("major");
		String minorCategory = request.getParameter("minor");
		String kwd = request.getParameter("kwd");
		String doOrder = request.getParameter("doOrder");
		int page = Integer.parseInt(request.getParameter("page"));
		List<ProductBean> productBean = new ArrayList<ProductBean>();
		int count = 0;
System.out.println(kwd);

	if(!kwd.equals("")) { //검색시 
		System.out.println("키워드 검색시");
		SearchSVC searchSVC = new SearchSVC();
		//검색된 상품 
		productBean = searchSVC.search(kwd);
		// 검색된 총 상품갯수 
		count = productBean.size();
		//셀렉트박스 검색을 위한 저장
		request.setAttribute("kwd", kwd);
		//기존에 존재하던 하위카테고리 삭제 
		session.removeAttribute("printCategory");
	}else{
		System.out.println("키워드 검색이 아니다 !");
		if(!majorCategory.equals("") && minorCategory.equals("")) { //대분류 카테고리까지 선택시 
			System.out.println("대분류 선택시");
			//대분류 파라미터 검증 
			findCategory(majorCategory,request,session);
			
			//대분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMajorLinkSVC majorLinkSVC = new CategoryMajorLinkSVC();
			productBean = majorLinkSVC.linkSVC(majorCategory);
			//상품 총 갯수 
			count = productBean.size();
			
		}else { //소분류 카테고리까지 선택시 
			System.out.println("소분류 선택시");
			//소분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMinorLinkSVC minorLinkSVC = new CategoryMinorLinkSVC();
			productBean = minorLinkSVC.minorLinkSVC(minorCategory);
			//상품 총 갯수 
			count = productBean.size();
			
			request.setAttribute("minorCategoryCode", minorCategory);
			
		}
		
	}
	//셀렉트박스 정렬
	if(!doOrder.equals("")) {
		System.out.println("셀렉트 박스 정렬");
			for(ProductBean a:productBean) {// null값 0으로 초기화 (null pointer exception 방지)
				if(a.getProduct_cnt_review()==null) {
					a.setProduct_cnt_review("0");
				}
				if(a.getProduct_cnt_order()==null) {
					a.setProduct_cnt_order("0");
				}
			}
			productBean = selectBox(doOrder, productBean);
	}
	//--------------------------페이징처리-----------------------------
	//startPage 구하기 
	int startIndex = 0; 
	int startPage = page-(page-1)%5;
	//startIndex 구하기 
		if(page==1) {
			startIndex=0;
		}else {
			startIndex=(page+(page-2))*10;
		}
		//lastPage 구하기 
		int lastPage=0;
		if(count%20 != 0) lastPage=(count/20)+1;
		else if(count%20 == 0) lastPage=count/20;
	//--------------------------페이징처리-------------------------------
		
		//페이지에 따른 상품 불러오기 
		List<ProductBean> productBeanPaging = new ArrayList<ProductBean>();
		if(page==lastPage || lastPage==0) {
		productBeanPaging = productBean.subList(startIndex, productBean.size());

		}else {
		productBeanPaging = productBean.subList(startIndex, startIndex+20);
		}
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("page", page);
		request.setAttribute("productBean", productBeanPaging);
		request.setAttribute("count", count);
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
		// 카테고리 한글이름의 확장성을 위한 대분류 검증 
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
	
	public List<ProductBean> selectBox(String doOrder, List<ProductBean> productBean) {
//		1 = 신상품순
//		2 = 인기상품순
//		3 = 낮은가격순
//		4 = 높은가격순
//		5 = 높은할인율순
//		6 = 상품평순  
		
		if(doOrder.equals("1")) {//		1 = 신상품순 asc
		Collections.sort(productBean, new Comparator<ProductBean>() {
			@Override
			public int compare(ProductBean o1, ProductBean o2) {
				return o1.getProduct_regdate().compareTo(o2.getProduct_regdate());
			}
		});
		Collections.reverse(productBean); //desc
		}
		if(doOrder.equals("2"))//		2 = 인기상품순 asc
		Collections.sort(productBean, new Comparator<ProductBean>() {
			@Override
			public int compare(ProductBean o1, ProductBean o2) {
				return o1.getProduct_cnt_order().compareTo(o2.getProduct_cnt_order());
			}
		});
		Collections.reverse(productBean);
		if(doOrder.equals("3"))//		3 = 낮은가격순 asc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					if (o1.getProduct_price()-o1.getProduct_sale_price() < o2.getProduct_price()-o2.getProduct_sale_price()) {
	                    return -1;
	                } else if (o1.getProduct_price()-o1.getProduct_sale_price() > o2.getProduct_price()-o2.getProduct_sale_price()) {
	                    return 1;
	                }
	                return 0;
				}
			});
		if(doOrder.equals("4"))//		4 = 높은가격순 desc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					if (o1.getProduct_price()-o1.getProduct_sale_price() > o2.getProduct_price()-o2.getProduct_sale_price()) {
	                    return -1;
	                } else if (o1.getProduct_price()-o1.getProduct_sale_price() < o2.getProduct_price()-o2.getProduct_sale_price()) {
	                    return 1;
	                }
	                return 0;
				}
			});
		if(doOrder.equals("5"))//		5 = 높은할인율순 desc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					if (o1.getProduct_sale_price() > o2.getProduct_sale_price()) {
	                    return -1;
	                } else if (o1.getProduct_sale_price() < o2.getProduct_sale_price()) {
	                    return 1;
	                }
	                return 0;
				}
			});
		if(doOrder.equals("6")) {//		6 = 상품평순
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					return o1.getProduct_cnt_review().compareTo(o2.getProduct_cnt_review());
				}
			});
		Collections.reverse(productBean); //desc
		}
		return productBean;
	}
	

}