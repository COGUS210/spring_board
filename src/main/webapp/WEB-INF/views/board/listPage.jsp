<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/header.jsp"%>



    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
         <div class="col-lg-12">
          <div class="card">
          	<div class="card-body">
          		<div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                <table class="table table-bordered">
                	<tr>
                		<th style="width:10px">BNO</th>
                		<th>TITLE</th>
                		<th>WRITER</th>
                		<th>REGDATE</th>
                		<th style="width:40px">VIEWCNT</th>
                	</tr>
                	
                <c:forEach items="${list}" var="boardVO">
                	
                	<tr>
                		<td>${boardVO.bno}</td>
                		<td><a href='/board/readPage${pageMaker.makeQuery(pageMaker.cri.page) }&bno=${boardVO.bno}'>${boardVO.title}</a></td>
                		<td>${boardVO.writer}</td>
                		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
                		value="${boardVO.regdate}" /></td>
                		<td><span class="badge bg-red">${boardVO.viewcnt}</span></td>
                	</tr>
                	
                </c:forEach>
                </table>
                
                
				
				<div class="row justify-content-center">
                <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                	<ul class="pagination">
                		<c:if test="${pageMaker.prev}">
                			<li class="paginate_button page-item"><a href="listPage?${pageMaker.makeQuery(pageMaker.startPage - 1)}" class="page-link">&laquo;</a></li>
                		</c:if>
                		
                		<c:forEach begin="${pageMaker.startPage }"
                			end="${pageMaker.endPage }" var="idx">
                			<c:choose>
	                			<c:when test="${pageMaker.cri.page == idx }">
	                				<li class="paginate_button page-item active">
	                				<a href="${idx}" class="page-link">${idx }</a></li>
	                			</c:when>
	                			<c:otherwise>
	                				<li class="paginate_button page-item">
	                				<a href="${idx}" class="page-link">${idx }</a></li>
	                			</c:otherwise>
                			</c:choose>
                		</c:forEach>
                		
                		<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
                			<li class="paginate_button page-item"><a href="listPage?${pageMaker.makeQuery(pageMaker.endPage + 1) }" class="page-link">&raquo;</a></li>
                		</c:if>
                	</ul>
                </div>
                </div>
                <form id="jobForm">
				  	<input type='hidden' name="page" value=${pageMaker.cri.page }>
					<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum }>
				</form>
                
                </div>

                </div>
              </div>
            </div>
          </div>
          
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <script>
	var result = '${msg}';
	
	if (result == 'success') {
		alert("처리가 완료되었습니다.");
	}

	$(document).ready(function() {
	
		$(".pagination li a").on("click", function(event) {
			
			event.preventDefault();
			
			var targetPage = $(this).attr("href");
			
			var jobForm = $("#jobForm");
			jobForm.find("[name='page']").val(targetPage);
			jobForm.attr("action", "/board/listPage").attr("method", "get");
			jobForm.submit();
			
		});
		
	});
	
  </script>

<%@include file="../include/footer.jsp" %>

