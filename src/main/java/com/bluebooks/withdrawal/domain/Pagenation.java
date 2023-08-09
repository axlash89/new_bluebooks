package com.bluebooks.withdrawal.domain;

public class Pagenation {
	
	private Criteria criteria;
    private int totalCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;
    private int displayPageNum = 2;
    
    public Criteria getCriteria() {
        return criteria;
    }
    public void setCriteria(Criteria criteria) {
        this.criteria = criteria;
    }
    
    public int getTotalCount () {
        return this.totalCount;
    }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }
    
    private void calcData() {
        //끝 페이지 번호 = (현재 페이지 번호 / 화면에 보여질 페이지 번호의 갯수) * 화면에 보여질 페이지 번호의 갯수
        endPage = (int) (Math.ceil(criteria.getPage() / (double) displayPageNum) * displayPageNum);
 
        
        //시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여질 페이지 번호의 갯수) + 1
        startPage = (endPage - displayPageNum) + 1;
        if(startPage <= 0) startPage = 1;
        
        //마지막 페이지 번호 = 총 게시글 수 / 한 페이지당 보여줄 게시글의 갯수
        int tempEndPage = (int) (Math.ceil(totalCount / (double) criteria.getPerPageNum()));
        if(endPage > tempEndPage) endPage = tempEndPage;
        
        prev = startPage == 1 ? false:true;
        next = endPage * criteria.getPerPageNum() < totalCount ? true:false;
    }
    
    public int getStartPage() {
        return this.startPage;
    }
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
    
    public int getEndPage() {
        return this.endPage;
    }
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
    
    public boolean isPrev() {
        return this.prev;
    }
    public void setPrev(boolean prev) {
        this.prev = prev;
    }
    public boolean isNext() {
        return this.next;
    }
    public void setNext(boolean next) {
        this.next = next;
    }
    public int getDisplayPageNum() {
        return this.displayPageNum;
    }
    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }

}
