package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.QuestionBean;
import vo.QuestionPageInfo;

public class QuestionListSVC {

	public ArrayList<QuestionBean> getQuestionList(int product_num, int q_pageNum, int q_pageSize) {
		System.out.println("getQuestionList");
		ArrayList<QuestionBean> questionList = null;
		
		// 공통작업
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);

		int q_startRow = (q_pageNum - 1) * q_pageSize;
		questionList = itemDAO.selectQuestionList(product_num, q_startRow, q_pageSize);
		
		close(con);
		
		return questionList;
	}

	
	public QuestionPageInfo getPageInfo(int product_num, int q_pageNum, int q_pageSize, int q_pageBlock) {
		QuestionPageInfo questionPageInfo = new QuestionPageInfo();

		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		int boardCount = itemDAO.getQuestionCount(product_num);
		int pageCount = boardCount / q_pageSize + (boardCount % q_pageSize==0 ? 0 : 1);	// 전체 페이지 수
		int startPage = (q_pageNum-1) / q_pageBlock * q_pageBlock + 1;	// 한 화면에 보여줄 시작페이지 번호
		int endPage = startPage + q_pageBlock - 1;						// 한 화면에 보여줄 끝 페이지 번호
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		questionPageInfo.setPageNum(q_pageNum);
		questionPageInfo.setPageSize(q_pageSize);
		questionPageInfo.setPageBlock(q_pageBlock);
		questionPageInfo.setBoardCount(boardCount);
		questionPageInfo.setPageCount(pageCount);
		questionPageInfo.setStartPage(startPage);
		questionPageInfo.setEndPage(endPage);

		close(con);
		
		return questionPageInfo;
	}

}
