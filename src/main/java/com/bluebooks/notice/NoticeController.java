package com.bluebooks.notice;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bluebooks.notice.bo.NoticeBO;
import com.bluebooks.notice.entity.NoticeEntity;

@RequestMapping("/notice")
@Controller
public class NoticeController {

	@Autowired
	private NoticeBO noticeBO;

	@GetMapping("/notice_list_view")
	public String onetooneListView(HttpSession session, Model model,
			@RequestParam(required=false) String searchKeyword,
			@PageableDefault(page = 0, size = 5, sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {

		// nowPage 현재 페이지
		// startPage 블럭에서 보여줄 시작 페이지
		// endPage 블럭에서 보여줄 마지막 페이지
		Page<NoticeEntity> noticeList = null;
		if (searchKeyword == null) {			
			noticeList = noticeBO.getNoticeList(pageable);			
		} else {
			noticeList = noticeBO.getNoticeListBySearchKeyword(searchKeyword, pageable);
			model.addAttribute("searchKeyword", "&searchKeyword=" + searchKeyword);
		}
		
		int nowPage = noticeList.getPageable().getPageNumber();
		if (nowPage > noticeList.getTotalPages() - 1) {
			nowPage =  noticeList.getTotalPages() - 1;
		}
		
		int startPage = Math.max(0, noticeList.getPageable().getPageNumber() - 4);
		
		int endPage;
		if (noticeList.getTotalPages() != 0) {
			endPage = Math.min(noticeList.getTotalPages() - 1, nowPage + 4);
		} else {
			endPage = 0;
		}
		
		model.addAttribute("noticeList", noticeList);

		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		model.addAttribute("nowPage", nowPage);

		model.addAttribute("view", "notice/noticeList");
		
		return "template/layout";

	}

	@GetMapping("/notice_create_view")
	public String noticeCreateView(Model model) {
		model.addAttribute("view", "notice/noticeCreate");
		return "template/layout";
	}

	@GetMapping("/notice_detail_view")
	public String onetooneDetailView(@RequestParam("id") int id, Model model) {

		NoticeEntity noticeEntity = noticeBO.getNoticeEntityById(id);

		model.addAttribute("noticeEntity", noticeEntity);

		model.addAttribute("view", "notice/noticeDetail");
		return "template/layout";
	}

}
