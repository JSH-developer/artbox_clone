package action.Basket;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.Basket.BasketListService;
import vo.ActionForward;

// 장바구니 목록을 보여주는 BasketListAction 클래스 정의
public class BasketListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BasketListAction");
		ActionForward forward = null;
		
		// 세션값 가져오기
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		request.setCharacterEncoding("UTF-8");
		
		// 세션값 없으면 로그인페이지로 돌아가기
		if(id == null){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/artbox_clone/memberLoginForm.member");
			return forward;
		}
		
		// basketListService 인스턴스 생성 후 getBasketList() 메서드 호출하여 장바구니 목록 가져오기
		BasketListService basketListService = new BasketListService();
		// 파라미터 : id , 리턴타입 : List
		List list = basketListService.getBasketList(id);
		if(list == null) {
			forward = new ActionForward();
			forward.setPath("/basket/Basket.jsp");
		} else {
			// 첫번째 list 칸의 값인 basketList 저장
			List basketList = (List)list.get(0);
			// 두번째 list 칸의 값인 itemsList 저장
			List itemsList = (List)list.get(1);
			
			forward = new ActionForward();
			// request 에 basketList / itemsList 담기
			request.setAttribute("basketList", basketList);
			request.setAttribute("itemsList", itemsList);
			forward.setPath("/basket/Basket.jsp");
		}
		
		return forward;
	}

}
