package com.bluebooks.order.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.book.domain.Book;
import com.bluebooks.cart.bo.CartBO;
import com.bluebooks.cart.domain.Cart;
import com.bluebooks.cart.domain.CartView;
import com.bluebooks.common.Criteria;
import com.bluebooks.order.dao.OrderMapper;
import com.bluebooks.order.domain.Order;
import com.bluebooks.order.domain.OrderView;
import com.bluebooks.orderedbooks.bo.OrderedBooksBO;
import com.bluebooks.orderedbooks.domain.OrderedBooks;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@Service
public class OrderBO {
	
	@Autowired
	private CartBO cartBO;
	
	@Autowired
	private BookBO bookBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private OrderedBooksBO orderedBooksBO;
	
	@Autowired
	private OrderMapper orderMapper;
	
	public List<CartView> getOrderedCartViewList(int userId, String bookIdString) {
		
		String[] bookIdStringArr = bookIdString.split("@");
		
		int[] bookIdArr = new int[bookIdStringArr.length];
		for (int i = 0; i < bookIdStringArr.length; i++) {
			bookIdArr[i] = Integer.parseInt(bookIdStringArr[i]);
		}
		
		List<Cart> cartList = new ArrayList<>();
		for (int i = 0; i < bookIdArr.length; i++) {
			cartList.add(cartBO.selectOrderedCartListByUserIdAndBookId(userId, bookIdArr[i]));		
		}
		
		List<CartView> orderedCartViewList = new ArrayList<>();
		for (int i = 0; i < cartList.size(); i++) {
			CartView orderedCartView = new CartView();
			orderedCartView.setCart(cartList.get(i));			
			orderedCartView.setBook(bookBO.getBookById(cartList.get(i).getBookId()));
			orderedCartViewList.add(orderedCartView);
		}
		
		return orderedCartViewList;		
	}
	
	
	public Book getOrderedBook(int bookId) {
		return bookBO.getBookById(bookId);
	}
	
	public UserEntity getUserEntityByUserId(int userId) {
		return userBO.getUserEntityById(userId);
	}
	
	public void createOrder(int userId, int usedPoint, int finalPrice, String payBy, 
			String recipientName, String recipientZipCode, String recipientAddress, 
			String recipientPhoneNumber, int totalPoint, String bookIdString, String bookCount, Integer bookId, Integer bookCountFromDetail) {
		
		Order order= new Order();
		order.setUserId(userId);
		order.setUsedPoint(usedPoint);
		order.setFinalPrice(finalPrice);
		order.setPayBy(payBy);
		order.setRecipientName(recipientName);
		order.setRecipientZipCode(recipientZipCode);
		order.setRecipientAddress(recipientAddress);
		order.setRecipientPhoneNumber(recipientPhoneNumber);		
		orderMapper.insertOrder(order);
		
		userBO.updateUserEntityPointById(userId, usedPoint, totalPoint);
		
		if (bookIdString != null) {
			String[] bookIdStringArr = bookIdString.split("@");
			int[] bookIdArr = new int[bookIdStringArr.length];
			for (int i = 0; i < bookIdStringArr.length; i++) {
				bookIdArr[i] = Integer.parseInt(bookIdStringArr[i]);
			}
			cartBO.deleteFromCart(userId, bookIdArr);
			
			String[] bookCountStringArr = bookCount.split("");
			int[] bookCountArr = new int[bookCountStringArr.length];
			for (int i = 0; i < bookCountStringArr.length; i++) {
				bookCountArr[i] = Integer.parseInt(bookCountStringArr[i]);
			}			
			orderedBooksBO.insertOrderedBooksByOrderId(order.getId(), bookIdArr, bookCountArr);
		} else if (bookCountFromDetail != null) {
			orderedBooksBO.insertOrderedSingleBookByOrderIdFromDetail(order.getId(), bookId , bookCountFromDetail);
		} else {
			orderedBooksBO.insertOrderedSingleBookByOrderId(order.getId(), bookId);
			
		}
		
	}
	 
	
	
	public List<OrderView> getOrderViewListByUserId(int userId, Criteria criteria, String period) {
		
		List<OrderView> orderViewList = new ArrayList<>();	
		
		if (period == null) {
		
			List<Order> orderList = orderMapper.selectOrderListByUserId(userId, criteria);
						
			for (int i = 0; i < orderList.size(); i++) {
				OrderView orderView = new OrderView();
								
				orderView.setOrder(orderList.get(i));
				
				List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderList.get(i).getId());
				orderView.setOrderedBooksList(orderedBooksList);
				
				List<Book> bookList = new ArrayList<>();
				for (int j = 0; j < orderedBooksList.size(); j++) {
					
					bookList.add(bookBO.getBookById(orderedBooksList.get(j).getBookId())); 
				}
				orderView.setBookList(bookList);
				
				
				orderViewList.add(orderView);
				
			}
		
		} else {
			
			List<Order> orderList = new ArrayList<>();
			
			
			
			orderList = orderMapper.selectOrderListByUserIdAndByPeriod(userId, period, criteria);
			
			
			for (int i = 0; i < orderList.size(); i++) {
				OrderView orderView = new OrderView();
				
				orderView.setOrder(orderList.get(i));
				
				List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderList.get(i).getId());
				orderView.setOrderedBooksList(orderedBooksList);
				
				List<Book> bookList = new ArrayList<>();
				for (int j = 0; j < orderedBooksList.size(); j++) {
					
					bookList.add(bookBO.getBookById(orderedBooksList.get(j).getBookId())); 
				}
				orderView.setBookList(bookList);
				
				
				orderViewList.add(orderView);
			
			}
		
		}
		
		return orderViewList;
		
		
	}
	

	public int getTotalOrderViewCountByUserId(int userId, String period) {
		
		Integer totalCount = null;
		
		if (period == null) {		
			
			totalCount = orderMapper.getTotalOrderViewCountByUserId(userId);	
			
		} else {

			totalCount = orderMapper.getTotalOrderViewCountByUserIdAndByPeriod(userId, period);
			
		}
		
		return totalCount;
				
	}	
	
	
	public List<OrderView> getOrderViewList (Criteria criteria, String type, String searchKeyword, String period) {
	
		List<OrderView> orderViewList = new ArrayList<>();	
		
		if (period == null) {
			
			if (searchKeyword == null) {
		
				List<Order> orderList = orderMapper.selectOrderList(criteria);
							
				for (int i = 0; i < orderList.size(); i++) {
					OrderView orderView = new OrderView();
					
					orderView.setOrder(orderList.get(i));
					
					UserEntity user = userBO.getUserEntityById(orderList.get(i).getUserId());
					orderView.setUser(user);
					
					
					List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderList.get(i).getId());
					orderView.setOrderedBooksList(orderedBooksList);
					
					List<Book> bookList = new ArrayList<>();
					for (int j = 0; j < orderedBooksList.size(); j++) {
						
						bookList.add(bookBO.getBookById(orderedBooksList.get(j).getBookId())); 
					}
					orderView.setBookList(bookList);
					
					
					orderViewList.add(orderView);
					
				}
			
			} else {
					
				if (type.equals("byLoginId")) {
					
					List<UserEntity> searchedUserList = userBO.getUserEntityByLoginIdContaining(searchKeyword);
					List<Order> orderListByLoginId = new ArrayList<>();
					
					if (searchedUserList.size() == 0) {
						return orderViewList;
					} 

					int[] userIdArr = new int[searchedUserList.size()];
					for (int i = 0; i < searchedUserList.size(); i++) {
						userIdArr[i] = searchedUserList.get(i).getId();
					}
					
					orderListByLoginId = orderMapper.selectOrderListByUserIdList(userIdArr, criteria);
					
								
					for (int i = 0; i < orderListByLoginId.size(); i++) {
						OrderView orderView = new OrderView();
						
						orderView.setOrder(orderListByLoginId.get(i));				
						orderView.setUser(userBO.getUserEntityById(orderListByLoginId.get(i).getUserId()));				
						
						List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderListByLoginId.get(i).getId());
						orderView.setOrderedBooksList(orderedBooksList);
						
						List<Book> bookList = new ArrayList<>();
						for (int j = 0; j < orderedBooksList.size(); j++) {
							
							bookList.add(bookBO.getBookById(orderedBooksList.get(j).getBookId())); 
						}
						orderView.setBookList(bookList);
						
						orderViewList.add(orderView);
					}
					
				} else {
					
					List<OrderedBooks> orderedBooksList = orderedBooksBO.getAllOfOrderedBooks();
					List<Book> bookList = new ArrayList<>();
					
					for (int i = 0; i < orderedBooksList.size(); i++) {
						bookList.add(bookBO.getBookById(orderedBooksList.get(i).getBookId()));
					}
					
					for (int i = 0; i < bookList.size(); i++) {
						if (bookList.get(i).getTitle().contains(searchKeyword) == false) {
							bookList.remove(i);
							i--;
						}
					}
					
					if (bookList.size() == 0) {
						return orderViewList;
					}
					
					List<Integer> bookIdList = new ArrayList<>();
					for (int i = 0; i < bookList.size(); i++) {
						bookIdList.add(bookList.get(i).getId());
					}
					
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						if (bookIdList.contains(orderedBooksList.get(i).getBookId()) == false) {
							orderedBooksList.remove(i);
							i--;
						}						
					}
					
					int[] orderIdArr = new int[orderedBooksList.size()];
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						orderIdArr[i] = orderedBooksList.get(i).getOrderId();					
					}
					
					List<Order> orderListByBookTitle = orderMapper.selectOrderByIdList(orderIdArr, criteria);
					
					for (int i = 0; i < orderListByBookTitle.size(); i++) {
						OrderView orderView = new OrderView();
						
						orderView.setOrder(orderListByBookTitle.get(i));				
						orderView.setUser(userBO.getUserEntityById(orderListByBookTitle.get(i).getUserId()));				
						
						List<OrderedBooks> finalOrderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderListByBookTitle.get(i).getId());
						orderView.setOrderedBooksList(finalOrderedBooksList);
						
						List<Book> finalBookList = new ArrayList<>();
						for (int j = 0; j < finalOrderedBooksList.size(); j++) {
							
							finalBookList.add(bookBO.getBookById(finalOrderedBooksList.get(j).getBookId())); 
						}
						orderView.setBookList(finalBookList);
						
						orderViewList.add(orderView);
					}					
					
				}	
				
			}
		
		} else {
			
			if (searchKeyword == null) {
			
				List<Order> orderList = new ArrayList<>();
				
				
				orderList = orderMapper.selectOrderListByPeriod(period, criteria);
				
				
				for (int i = 0; i < orderList.size(); i++) {
					OrderView orderView = new OrderView();
					
					orderView.setOrder(orderList.get(i));
					
					UserEntity user = userBO.getUserEntityById(orderList.get(i).getUserId());
					orderView.setUser(user);
					
					
					List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderList.get(i).getId());
					orderView.setOrderedBooksList(orderedBooksList);
					
					List<Book> bookList = new ArrayList<>();
					for (int j = 0; j < orderedBooksList.size(); j++) {
						
						bookList.add(bookBO.getBookById(orderedBooksList.get(j).getBookId())); 
					}
					orderView.setBookList(bookList);
					
					
					orderViewList.add(orderView);
				
				}
				
			
			} else {
				
				if (type.equals("byLoginId")) {
					
					List<UserEntity> searchedUserList = userBO.getUserEntityByLoginIdContaining(searchKeyword);
					List<Order> orderListByLoginId = new ArrayList<>();
					
					if (searchedUserList.size() == 0) {
						return orderViewList;
					} 

					int[] userIdArr = new int[searchedUserList.size()];
					for (int i = 0; i < searchedUserList.size(); i++) {
						userIdArr[i] = searchedUserList.get(i).getId();
					}
										
					orderListByLoginId = orderMapper.selectOrderListByUserIdListAndByPeriod(userIdArr, period, criteria);
													
					for (int i = 0; i < orderListByLoginId.size(); i++) {
						OrderView orderView = new OrderView();
						
						orderView.setOrder(orderListByLoginId.get(i));				
						orderView.setUser(userBO.getUserEntityById(orderListByLoginId.get(i).getUserId()));				
						
						List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderListByLoginId.get(i).getId());
						orderView.setOrderedBooksList(orderedBooksList);
						
						List<Book> bookList = new ArrayList<>();
						for (int j = 0; j < orderedBooksList.size(); j++) {
							
							bookList.add(bookBO.getBookById(orderedBooksList.get(j).getBookId())); 
						}
						orderView.setBookList(bookList);
						
						orderViewList.add(orderView);
					}
					
				
				} else {
					
					List<OrderedBooks> orderedBooksList = orderedBooksBO.getAllOfOrderedBooks();
					List<Book> bookList = new ArrayList<>();
					
					for (int i = 0; i < orderedBooksList.size(); i++) {
						bookList.add(bookBO.getBookById(orderedBooksList.get(i).getBookId()));
					}
					
					for (int i = 0; i < bookList.size(); i++) {
						if (bookList.get(i).getTitle().contains(searchKeyword) == false) {
							bookList.remove(i);
							i--;
						}
					}
					
					if (bookList.size() == 0) {
						return orderViewList;
					}
					
					List<Integer> bookIdList = new ArrayList<>();
					for (int i = 0; i < bookList.size(); i++) {
						bookIdList.add(bookList.get(i).getId());
					}
					
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						if (bookIdList.contains(orderedBooksList.get(i).getBookId()) == false) {
							orderedBooksList.remove(i);
							i--;
						}						
					}
					
					int[] orderIdArr = new int[orderedBooksList.size()];
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						orderIdArr[i] = orderedBooksList.get(i).getOrderId();					
					}
					
					List<Order> orderListByBookTitle = orderMapper.selectOrderByIdListAndByPeriod(orderIdArr, period, criteria);
					
					for (int i = 0; i < orderListByBookTitle.size(); i++) {
						OrderView orderView = new OrderView();
						
						orderView.setOrder(orderListByBookTitle.get(i));				
						orderView.setUser(userBO.getUserEntityById(orderListByBookTitle.get(i).getUserId()));				
						
						List<OrderedBooks> finalOrderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderListByBookTitle.get(i).getId());
						orderView.setOrderedBooksList(finalOrderedBooksList);
						
						List<Book> finalBookList = new ArrayList<>();
						for (int j = 0; j < finalOrderedBooksList.size(); j++) {
							
							finalBookList.add(bookBO.getBookById(finalOrderedBooksList.get(j).getBookId())); 
						}
						orderView.setBookList(finalBookList);
						
						orderViewList.add(orderView);
					}
					
					
				}
				
				
			}
		
		}
		
		return orderViewList;
		
	}
	
	
	public int getTotalOrderViewCount(String type, String searchKeyword, String period) {
		
		Integer totalCount = null;
		
		if (period == null) {		
			
			
			if (searchKeyword == null) {
				totalCount = orderMapper.getTotalOrderViewCount();	
			} else {
				
				if (type.equals("byLoginId")) {
					List<UserEntity> searchedUserList = userBO.getUserEntityByLoginIdContaining(searchKeyword);
					
					if(searchedUserList.size() == 0) {
						return 0;
					}
					
					int[] userIdArr = new int[searchedUserList.size()];
					for (int i = 0; i < searchedUserList.size(); i++) {
						userIdArr[i] = searchedUserList.get(i).getId();
					}
					
					totalCount = orderMapper.getTotalOrderViewCountByUserIdList(userIdArr);
				} else {
					
					List<OrderedBooks> orderedBooksList = orderedBooksBO.getAllOfOrderedBooks();
					List<Book> bookList = new ArrayList<>();
					
					for (int i = 0; i < orderedBooksList.size(); i++) {
						bookList.add(bookBO.getBookById(orderedBooksList.get(i).getBookId()));
					}
					
					for (int i = 0; i < bookList.size(); i++) {
						if (bookList.get(i).getTitle().contains(searchKeyword) == false) {
							bookList.remove(i);
							i--;
						}
					}
					
					List<Integer> bookIdList = new ArrayList<>();
					for (int i = 0; i < bookList.size(); i++) {
						bookIdList.add(bookList.get(i).getId());
					}
					
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						if (bookIdList.contains(orderedBooksList.get(i).getBookId()) == false) {
							orderedBooksList.remove(i);
							i--;
						}						
					}
					
					if (orderedBooksList.size() == 0) {
						return 0;
					}
					
					int[] orderIdArr = new int[orderedBooksList.size()];
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						orderIdArr[i] = orderedBooksList.get(i).getOrderId();					
					}
					
					return orderIdArr.length; 
					
				}
				
			}
			
		} else {
			
			if (searchKeyword == null) {
				totalCount = orderMapper.getTotalOrderViewCountByPeriod(period);
			} else {
				
				if (type.equals("byLoginId")) {
					List<UserEntity> searchedUserList = userBO.getUserEntityByLoginIdContaining(searchKeyword);
					
					if(searchedUserList.size() == 0) {
						return 0;
					}
					
					int[] userIdArr = new int[searchedUserList.size()];
					for (int i = 0; i < searchedUserList.size(); i++) {
						userIdArr[i] = searchedUserList.get(i).getId();
					}
					
					totalCount = orderMapper.getTotalOrderViewCountByUserIdListAndByPeriod(userIdArr, period);
					
				} else {
					
					List<OrderedBooks> orderedBooksList = orderedBooksBO.getAllOfOrderedBooks();
					List<Book> bookList = new ArrayList<>();
					
					for (int i = 0; i < orderedBooksList.size(); i++) {
						bookList.add(bookBO.getBookById(orderedBooksList.get(i).getBookId()));
					}
					
					for (int i = 0; i < bookList.size(); i++) {
						if (bookList.get(i).getTitle().contains(searchKeyword) == false) {
							bookList.remove(i);
							i--;
						}
					}
					
					List<Integer> bookIdList = new ArrayList<>();
					for (int i = 0; i < bookList.size(); i++) {
						bookIdList.add(bookList.get(i).getId());
					}
					
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						if (bookIdList.contains(orderedBooksList.get(i).getBookId()) == false) {
							orderedBooksList.remove(i);
							i--;
						}						
					}
					
					if (orderedBooksList.size() == 0) {
						return 0;
					}
					
					int[] orderIdArr = new int[orderedBooksList.size()];
					for (int i = 0; i < orderedBooksList.size(); i++) {						
						orderIdArr[i] = orderedBooksList.get(i).getOrderId();					
					}
					
					totalCount = orderMapper.getTotalOrderViewCountByBookTitleAndByPeriod(orderIdArr, period);
										
				}
				
			}				
				
		}

		return totalCount;
			
	}
		
	
	public void updateStatusByOrderId(Integer[] orderIdArr) {
		
		for (int i = 0; i < orderIdArr.length; i++) {
			orderMapper.updateStatusByOrderId(orderIdArr[i]);
		}
		
	}
	
	
	public OrderView getOrderView(int orderId) {
		
		Order order = orderMapper.getOrderById(orderId);
		
		OrderView orderView = new OrderView(); 
		orderView.setOrder(order);
		List<OrderedBooks> orderedBooksList = orderedBooksBO.getOrderedBooksListByOrderId(orderId);
		orderView.setOrderedBooksList(orderedBooksList);
		
		List<Book> bookList = new ArrayList<>();
		for (int i = 0; i < orderedBooksList.size(); i++) {
			bookList.add(bookBO.getBookById(orderedBooksList.get(i).getBookId()));
		}
		orderView.setBookList(bookList);
		UserEntity user = userBO.getUserEntityById(order.getUserId());
		orderView.setUser(user);
		
		return orderView;
		
	}
	
	
}
