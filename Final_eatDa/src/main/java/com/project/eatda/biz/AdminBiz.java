package com.project.eatda.biz;

import java.util.List;

import com.project.eatda.dto.BlogReplyDto;
import com.project.eatda.dto.OrderAdminDto;
import com.project.eatda.dto.OrderDto;
import com.project.eatda.dto.ProductDto;
import com.project.eatda.dto.ReportDto;
import com.project.eatda.dto.UserDto;

public interface AdminBiz {

	/* 댓글 리스트 */
	public List<BlogReplyDto> adminReplyList();
	public int adminReplyDelete(int reply_no);
	
	/* 상품 리스트 */
	public List<ProductDto> adminProductList();

	public int adminProductInsert(ProductDto dto);
	public int adminProductUpdate(ProductDto dto);
	public int adminProductDelete(String p_id);
	
	/* 주문 리스트 */
	public List<OrderAdminDto> adminOrderList();
	public OrderDto orderSelectOne(String order_id);

	public int adminOrderInsert(OrderDto order);
	public int adminOrderInsert2(OrderDto order);
	public int adminOrderUpdate(OrderAdminDto dto);
	public int adminOrderDelete(String order_id);

	/* 회원 리스트 */
	public List<UserDto> adminUserList();
	public List<UserDto> adminUserModal(int user_no);
	public int adminUserDelete(String user_id);
	
	/* 신고 리스트 */
	public List<ReportDto> adminReportList();
	public int adminReportDelete(int report_no);

	


}
