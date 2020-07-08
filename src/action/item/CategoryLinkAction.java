package action.item;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
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
		String majorCategory = request.getParameter("major"); //대분류 카테고리 값 
		String minorCategory = request.getParameter("minor"); //소분류 카테고리 값 
		String kwd = request.getParameter("kwd"); // 검색시 입력값 
		String doOrder = request.getParameter("doOrder"); // 셀렉트박스 정렬시 정렬종류 값 
		int page = Integer.parseInt(request.getParameter("page")); // 현재 페이지가 몇 페이지인지에 대한 값 
		// 셀렉트박스 정렬시 Comparator 객체가 List를 파라미터로 받으므로 List타입으로 선언 
		List<ProductBean> productBean = new ArrayList<ProductBean>(); 
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); // 최근등록상품 표시를 위한 현재 날짜의 데이터 포멧 
		Date time = new Date();
		String now = date.format(time); // 현재시간이 년월일만 출력되도록 셋팅 
		int count = 0;
		if (!kwd.equals("")) { // 검색시
			SearchSVC searchSVC = new SearchSVC();
			// 검색한 List에서 소분류 클릭시 사용할 파라미터 (대분류 카테고리가 넘어옴) 
			String src = request.getParameter("src");
			// 검색된 상품
			productBean = searchSVC.search(kwd);
			//기존의 소분류 카테고리 삭제
			int searchEffectiveness = productBean.size();
			if(searchEffectiveness==0) {
				request.setAttribute("effectiveness", searchEffectiveness);
			}
			session.removeAttribute("printCategory");
			//검색한 List에서 소분류 카테고리 선택시 
			if (!src.equals(""))
				// 셀렉트박스 정렬을 위한 재 저장
				request.setAttribute("src", src);
			//각 소분류에 해당하는 List생성 
			List<ProductBean> DT = new ArrayList<ProductBean>();
			List<ProductBean> FA = new ArrayList<ProductBean>();
			List<ProductBean> FS = new ArrayList<ProductBean>();
			List<ProductBean> KB = new ArrayList<ProductBean>();
			List<ProductBean> LD = new ArrayList<ProductBean>();
			List<ProductBean> DI = new ArrayList<ProductBean>();
			List<ProductBean> TR = new ArrayList<ProductBean>();
			List<ProductBean> BE = new ArrayList<ProductBean>();
			// 검색한 전체 List를 각 소분류 List로 분해
			listRefactoring(productBean, DT, FA, FS, KB, LD, DI, TR, BE);
			// listRefactoring 에서 분해 해놓은 List를 productBean 변수에 다시 저장
			// 해당 카테고리 선택시 선택한 카테고리의 아이템만 불러오기 위함 
			productBean = listInject(productBean, DT, FA, FS, KB, LD, DI, TR, BE, src);
			//각 카테고리별로 검색된 item이 몇개인지 저장
			String di = "디지털/가전(" + DI.size() + ")";
			String ld = "리빙/데코(" + LD.size() + ")";
			String fa = "문구(" + FA.size() + ")";
			String be = "뷰티(" + BE.size() + ")";
			String tr = "여행(" + TR.size() + ")";
			String dt = "인형/토이(" + DT.size() + ")";
			String kb = "주방/욕실(" + KB.size() + ")";
			String fs = "패션(" + FS.size() + ")";
			//해당 링크이름과 링크시 넘겨줄 파라미터를 각각 세팅하기위한 ArrayList 
			ArrayList<PrintCategory> print = new ArrayList<PrintCategory>();
			PrintCategory cate = null;
			String[] category = { dt, fa, fs, kb, ld, di, tr, be }; //view에 출력되는 링크 이름 
			String[] cateCode = { "DT", "FA", "FS", "KB", "LD", "DI", "TR", "BE" };
			
			for (int i = 0; i < category.length; i++) {
				cate = new PrintCategory();
				cate.setCategory(category[i]);
				cate.setCode(cateCode[i]);
				print.add(cate);
			}
			request.setAttribute("printCategory", print);
			// 검색된 총 상품갯수
			count = productBean.size();
			// 셀렉트박스 검색을 위한 저장
			request.setAttribute("kwd", kwd);

		} else {
			if (!majorCategory.equals("") && minorCategory.equals("")) { // 대분류 카테고리까지 선택시
				// 대분류 파라미터 검증
				findCategory(majorCategory, request, session);

				// 대분류 파라미터에 해당하는 상품목록 불러오기
				CategoryMajorLinkSVC majorLinkSVC = new CategoryMajorLinkSVC();
				productBean = majorLinkSVC.linkSVC(majorCategory);
				// 상품 총 갯수
				count = productBean.size();

			} else { // 소분류 카테고리까지 선택시
				// 소분류 파라미터에 해당하는 상품목록 불러오기
				CategoryMinorLinkSVC minorLinkSVC = new CategoryMinorLinkSVC();
				productBean = minorLinkSVC.minorLinkSVC(minorCategory);
				// 상품 총 갯수
				count = productBean.size();

				request.setAttribute("minorCategoryCode", minorCategory);

			}

		}
		// 셀렉트박스 정렬
		if (!doOrder.equals("")) {
			request.setAttribute("doOrder", doOrder);
			for (ProductBean pb : productBean) {// null값 0으로 초기화 (null pointer exception 방지)
				if (pb.getProduct_cnt_review() == null) {
					pb.setProduct_cnt_review("0");
				}
				if (pb.getProduct_cnt_order() == null) {
					pb.setProduct_cnt_order("0");
				}
			}
			productBean = selectBox(doOrder, productBean);
		}
		

		// --------------------------페이징처리 start-----------------------------
		// startPage 구하기
		int startPage = (page/5)*page+1;
		int startIndex = 0;
		int lastPage = 0;
		// startIndex 구하기
		if (page == 1) {
			startIndex = 0;
		} else {
			startIndex = (page + (page - 2)) * 10;
		}
		// lastPage 구하기
		if (count % 20 != 0)
			lastPage = (count / 20) + 1;
		else if (count % 20 == 0)
			lastPage = count / 20;
		// --------------------------페이징처리 end-------------------------------
		
		// --------------------------페이지에 따른 상품 불러오기 start-------------------------------
		List<ProductBean> productBeanPaging = new ArrayList<ProductBean>();
		if (page == lastPage || lastPage == 0) {
			productBeanPaging = productBean.subList(startIndex, productBean.size());

		} else {
			productBeanPaging = productBean.subList(startIndex, startIndex + 20);
		}
		// --------------------------페이지에 따른 상품 불러오기 end-------------------------------

		// --------------------------newItem 처리 start-----------------------------
				for(ProductBean pbp : productBeanPaging) {
					String itemTime = date.format(pbp.getProduct_regdate());
					int i =itemTime.compareTo(now);
					pbp.setIsNew(i);
				}
		// --------------------------newItem 처리 end-----------------------------
		
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("page", page);
		request.setAttribute("productBean", productBeanPaging);
		request.setAttribute("count", count);
		actionForward.setPath("/item/itemList.jsp");
		return actionForward;
	}

	// 검색 후 카테고리 선택시 선택한 카테고리에 해당하는 아이템만 불러오기 위한 변수명 변경작업 
	private List<ProductBean> listInject(List<ProductBean> productBean, List<ProductBean> DT, List<ProductBean> FA,
			List<ProductBean> FS, List<ProductBean> KB, List<ProductBean> LD, List<ProductBean> DI,
			List<ProductBean> TR, List<ProductBean> BE, String src) {

		if (src.equals(MajorCategory.디지털가전.getCode())) {
			productBean = DI;
		}
		if (src.equals(MajorCategory.리빙데코.getCode())) {
			productBean = LD;
		}
		if (src.equals(MajorCategory.문구.getCode())) {
			productBean = FA;
		}
		if (src.equals(MajorCategory.뷰티.getCode())) {
			productBean = BE;
		}
		if (src.equals(MajorCategory.여행.getCode())) {
			productBean = TR;
		}
		if (src.equals(MajorCategory.인형토이.getCode())) {
			productBean = DT;
		}
		if (src.equals(MajorCategory.주방욕실.getCode())) {
			productBean = KB;
		}
		if (src.equals(MajorCategory.패션.getCode())) {
			productBean = FS;
		}

		return productBean;
	}

	
	// 검색 후 productBean 에서 해당 카테고리별로 분류하여 각각의 ArrayList에 담는 작업 
	private void listRefactoring(List<ProductBean> productBean, List<ProductBean> DT, List<ProductBean> FA,
			List<ProductBean> FS, List<ProductBean> KB, List<ProductBean> LD, List<ProductBean> DI,
			List<ProductBean> TR, List<ProductBean> BE) {
		String result = null;
		for (ProductBean pb : productBean) {
			result = pb.getProduct_category_code().substring(0, 2);
			if (result.equals(MajorCategory.디지털가전.getCode())) {
				DI.add(pb);
			}
			if (result.equals(MajorCategory.리빙데코.getCode())) {
				LD.add(pb);
			}
			if (result.equals(MajorCategory.문구.getCode())) {
				FA.add(pb);
			}
			if (result.equals(MajorCategory.뷰티.getCode())) {
				BE.add(pb);
			}
			if (result.equals(MajorCategory.여행.getCode())) {
				TR.add(pb);
			}
			if (result.equals(MajorCategory.인형토이.getCode())) {
				DT.add(pb);
			}
			if (result.equals(MajorCategory.주방욕실.getCode())) {
				KB.add(pb);
			}
			if (result.equals(MajorCategory.패션.getCode())) {
				FS.add(pb);
			}
		}
	}

	public void setAttribute(String majorCategory, String name, String[] printCategory, HttpServletRequest request,
			HttpSession session) {

		session.setAttribute("code", majorCategory);
		session.setAttribute("cname", name);
		request.setAttribute("select", majorCategory);
		session.setAttribute("printCategory", printCategory);
	}

	public void findCategory(String majorCategory, HttpServletRequest request, HttpSession session) {
		// 카테고리 한글이름의 확장성을 위한 대분류 검증
		String[] printCategory = null;
		PrintCategory print = new PrintCategory();

		if (majorCategory.equals(MajorCategory.디지털가전.getCode())) {
			printCategory = print.디지털가전();
			setAttribute(majorCategory, "디지털/가전", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.리빙데코.getCode())) {
			printCategory = print.리빙데코();
			setAttribute(majorCategory, "리빙/데코", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.문구.getCode())) {
			printCategory = print.문구();
			setAttribute(majorCategory, "문구", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.여행.getCode())) {
			printCategory = print.여행();
			setAttribute(majorCategory, "여행", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.뷰티.getCode())) {
			printCategory = print.뷰티();
			setAttribute(majorCategory, "뷰티", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.인형토이.getCode())) {
			printCategory = print.인형토이();
			setAttribute(majorCategory, "인형/토이", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.주방욕실.getCode())) {
			printCategory = print.주방욕실();
			setAttribute(majorCategory, "주방/욕실", printCategory, request, session);
		}
		if (majorCategory.equals(MajorCategory.패션.getCode())) {
			printCategory = print.패션();
			setAttribute(majorCategory, "패션", printCategory, request, session);
		}
	}

	public List<ProductBean> selectBox(String doOrder, List<ProductBean> productBean) {
//		1 = 신상품순
//		2 = 인기상품순
//		3 = 낮은가격순
//		4 = 높은가격순
//		5 = 높은할인율순
//		6 = 상품평순  

		if (doOrder.equals("1")) {// 1 = 신상품순 asc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					return o1.getProduct_regdate().compareTo(o2.getProduct_regdate());
				}
			});
			Collections.reverse(productBean); // desc
		}
		if (doOrder.equals("2"))// 2 = 인기상품순 asc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					return o1.getProduct_cnt_order().compareTo(o2.getProduct_cnt_order());
				}
			});
		Collections.reverse(productBean);
		if (doOrder.equals("3"))// 3 = 낮은가격순 asc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					if (o1.getProduct_price() - o1.getProduct_sale_price() < o2.getProduct_price()
							- o2.getProduct_sale_price()) {
						return -1;
					} else if (o1.getProduct_price() - o1.getProduct_sale_price() > o2.getProduct_price()
							- o2.getProduct_sale_price()) {
						return 1;
					}
					return 0;
				}
			});
		if (doOrder.equals("4"))// 4 = 높은가격순 desc
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					if (o1.getProduct_price() - o1.getProduct_sale_price() > o2.getProduct_price()
							- o2.getProduct_sale_price()) {
						return -1;
					} else if (o1.getProduct_price() - o1.getProduct_sale_price() < o2.getProduct_price()
							- o2.getProduct_sale_price()) {
						return 1;
					}
					return 0;
				}
			});
		if (doOrder.equals("5"))// 5 = 높은할인율순 desc
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
		if (doOrder.equals("6")) {// 6 = 상품평순
			Collections.sort(productBean, new Comparator<ProductBean>() {
				@Override
				public int compare(ProductBean o1, ProductBean o2) {
					return o1.getProduct_cnt_review().compareTo(o2.getProduct_cnt_review());
				}
			});
			Collections.reverse(productBean); // desc
		}
		return productBean;
	}

}