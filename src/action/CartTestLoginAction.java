package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartTestMemberDAO;
import vo.ActionForward;

public class CartTestLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("LoginAction");
		request.setCharacterEncoding("UTF-8");

		ActionForward forward = null;

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		CartTestMemberDAO mdao = new CartTestMemberDAO();
		int check = mdao.idcheck(id, pw);

		if (check == 1) { // 로그인 성공
			// 세션값 생성
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			
			forward = new ActionForward();
			forward.setPath("/productDetail.cart");
			return forward;
		} else if (check == 0) {
			// check == 0 비밀번호 틀림. 뒤로 이동.
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 틀림');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		} else {
			// check == -1 아이디없음. 뒤로 이동.
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디 없음');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;

		}
	}

}