<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../include/header.jsp"%>



<!-- Main content -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">

				<!-- 검색  -->
				<div class="card">
					<div class="card-body">
						<h3>Search Board</h3>
						<hr>
						<select name="searchType">
							<option value="n"
								<c:out value="${cri.searchType == null?'selected':'' }"/>>
								---</option>
							<option value="t"
								<c:out value="${cri.searchType eq 't'?'selected':'' }"/>>
								Title</option>
							<option value="c"
								<c:out value="${cri.searchType eq 'c'?'selected':'' }"/>>
								Content</option>
							<option value="w"
								<c:out value="${cri.searchType eq 'w'?'selected':'' }"/>>
								Writer</option>
							<option value="tc"
								<c:out value="${cri.searchType eq 'tc'?'selected':'' }"/>>
								Title OR Content</option>
							<option value="cw"
								<c:out value="${cri.searchType eq 'cw'?'selected':'' }"/>>
								Content OR Writer</option>
							<option value="tcw"
								<c:out value="${cri.searchType eq 'tcw'?'selected':'' }"/>>
								Title OR Content OR Writer</option>
						</select> 
						<input type="text" name='keyword' id="keywordInput"
							value='${cri.keyword }'>
							
						<button class="btn btn-primary" id='searchBtn'>Search</button>
						<button class="btn btn-warning" id='newBtn'>New Board</button>
					</div>
				</div>

				<div class="card">
					<div class="card-body">
						<div id="example2_wrapper"
							class="dataTables_wrapper dt-bootstrap4">
							<h3>List Paging</h3>
							<hr>
							<table class="table table-bordered">
								<tr>
									<th style="width: 10px">BNO</th>
									<th>TITLE</th>
									<th>WRITER</th>
									<th>REGDATE</th>
									<th style="width: 40px">VIEWCNT</th>
								</tr>

								<c:forEach items="${list}" var="boardVO">

									<tr>
										<td>${boardVO.bno}</td>
										<td><a
											href='/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${boardVO.bno}'>${boardVO.title}<strong>   [ ${boardVO.replycnt} ]</strong></a></td>
										<td>${boardVO.writer}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${boardVO.regdate}" /></td>
										<td><span class="badge bg-red">${boardVO.viewcnt}</span></td>
									</tr>

								</c:forEach>
							</table>



							<div class="row justify-content-center">
								<div class="dataTables_paginate paging_simple_numbers"
									id="example2_paginate">
									<ul class="pagination">
										<c:if test="${pageMaker.prev}">
											<li class="paginate_button page-item"><a
												href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}"
												class="page-link">&laquo;</a></li>
										</c:if>

										<c:forEach begin="${pageMaker.startPage }"
											end="${pageMaker.endPage }" var="idx">
											<c:choose>
												<c:when test="${pageMaker.cri.page == idx }">
													<li class="paginate_button page-item active"><a
														href="${pageMaker.makeSearch(idx)}" class="page-link">${idx }</a></li>
												</c:when>
												<c:otherwise>
													<li class="paginate_button page-item"><a
														href="${pageMaker.makeSearch(idx)}" class="page-link">${idx }</a>
													</li>
												</c:otherwise>
											</c:choose>
										</c:forEach>

										<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
											<li class="paginate_button page-item"><a
												href="list${pageMaker.makeSearch(pageMaker.endPage + 1) }"
												class="page-link">&raquo;</a></li>
										</c:if>
									</ul>
								</div>
							</div>
							<form id="jobForm">
								<input type='hidden' name="page" value=${pageMaker.cri.page }>
								<input type='hidden' name="perPageNum"
									value=${pageMaker.cri.perPageNum }>
							</form>

						</div>

					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- /.row -->
</div>
<!-- /.container-fluid -->
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
		
		$('#searchBtn').on("click", function(event) {
			
			self.location = "list"
				+ '${pageMaker.makeQuery(1)}'
				+ "&searchType="
				+ $("select option:selected").val()
				+ "&keyword=" + encodeURIComponent($('#keywordInput').val());
				
		});
		
		$('#newBtn').on("click", function(evt) {
			
			self.location = "register";
			
		});
		
	});
</script>

<%@include file="../include/footer.jsp"%>

