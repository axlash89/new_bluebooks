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
		
	@GetMapping("/advanced_searched_result_view")
	public String searchedResult(Model model, Criteria criteria,
			@RequestParam(required = false) String title,
			@RequestParam(required = false) String author,
			@RequestParam(required = false) String publisher,
			@RequestParam("pubPeriod") String pubPeriod) {
		
		List<Book> advancedSearchedBookList = bookBO.getAdvancedSearchedBookList(title, author, publisher, pubPeriod, criteria);
				
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(bookBO.getAdvancedSearchedBookListTotalCount(title, author, publisher));
		
		model.addAttribute("title", title);
		model.addAttribute("author", author);
		model.addAttribute("publisher", publisher);
		model.addAttribute("pubPeriod", pubPeriod);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("advancedSearchedBookList", advancedSearchedBookList);
		model.addAttribute("view", "book/advancedSearchedResult");
		
		return "template/layout";
		
	}
	

	@GetMapping("/advanced_search_view")
	public String mainView(Model model) {
		model.addAttribute("view", "book/advancedSearch");		
		return "template/layout";
	}

	@GetMapping("/all_book_view")
	public String allBookView(Model model, Criteria criteria,
			@RequestParam(required = false) Integer cid) {
		List<Book> bookListByCategory = bookBO.getBookListByCategory(cid, criteria);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(bookBO.getBookListByCategoryTotalCount(cid));
		
		model.addAttribute("bookListByCategory", bookListByCategory);
		model.addAttribute("cid", cid);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("view", "category/categoryLayout");
		model.addAttribute("secondView", "book/allBook");		
		return "template/layout";
	}
	

	@GetMapping("/best_book_view")
	public String bestBookView(Model model, Criteria criteria,
			@RequestParam(required = false) Integer cid) {
		List<Book> bestBookListByCategory = bookBO.getBestBookListByCategory(cid, criteria);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(bookBO.getBestBookListByCategoryTotalCount(cid));
		
		model.addAttribute("bestBookListByCategory", bestBookListByCategory);
		model.addAttribute("cid", cid);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("view", "category/categoryLayout");
		model.addAttribute("secondView", "book/bestBook");		
		return "template/layout";
	}
	
	@GetMapping("/new_book_view")
	public String newBookView(Model model, Criteria criteria,
			@RequestParam(required = false) Integer cid) {
		List<Book> newBookListByCategory = bookBO.getNewBookListByCategory(cid, criteria);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(bookBO.getNewBookListByCategoryTotalCount(cid));
		
		model.addAttribute("newBookListByCategory", newBookListByCategory);
		model.addAttribute("cid", cid);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("view", "category/categoryLayout");
		model.addAttribute("secondView", "book/newBook");		
		return "template/layout";
	}
	
	

	@GetMapping("/book_detail_view")
	public String bestBookView(Model model,
			@RequestParam("bookId") int bookId) {
		Book book = bookBO.getBookById(bookId);
		
		model.addAttribute("book", book);
		model.addAttribute("view", "book/bookDetail");
		
		return "template/layout";
	}
	
}
