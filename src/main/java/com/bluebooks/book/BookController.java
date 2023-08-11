package com.bluebooks.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.book.domain.Book;
import com.bluebooks.common.Criteria;
import com.bluebooks.common.PageMaker;

@RequestMapping("/book")
@Controller
public class BookController {
	
	@Autowired
	private BookBO bookBO;
	
	
	@GetMapping("/searched_result_view")
	public String searchedResult(Model model, Criteria criteria,
			@RequestParam("searchKeyword") String searchKeyword) {
		
		List<Book> searchedBookList = bookBO.getSearchedBookList(searchKeyword, criteria);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(bookBO.getSearchedBookListTotalCount(searchKeyword));
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("searchedBookList", searchedBookList);
		model.addAttribute("view", "book/searchedResult");
		
		return "template/layout";
		
	}
	

	@GetMapping("/advanced_search_view")
	public String mainView(Model model) {
		model.addAttribute("view", "book/advancedSearch");		
		return "template/layout";
	}


}
