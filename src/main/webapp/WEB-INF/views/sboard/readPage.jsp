<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../include/header.jsp"%>



<!-- Main content -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">READ BOARD</h3>
					</div>
					<!-- /.card-header -->
					<!-- form start -->
					<form role="form" method="post">
						<input type='hidden' name='bno' value="${boardVO.bno}">
					</form>
					<div class="card-body">
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name="title" class="form-control" value="${boardVO.title}"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" rows="3"
								readonly="readonly">${boardVO.content}</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${boardVO.writer}"
								readonly="readonly">
						</div>
					</div>
					<!-- /.card-body -->

					<div class="card-footer">
						<button type="submit" class="btn btn-warning modifyBtn">MODIFY</button>
						<button type="submit" class="btn btn-danger removeBtn">REMOVE</button>
						<button type="submit" class="btn btn-primary goListBtn">GO
							LIST</button>
					</div>

					<form role="form" action="modifyPage" method="post">
						<input type='hidden' name='bno' value="${boardVO.bno }"> <input
							type='hidden' name='page' value="${cri.page }"> <input
							type='hidden' name='perPageNum' value="${cri.perPageNum }">
						<input type='hidden' name='searchType' value="${cri.searchType }">
						<input type='hidden' name='keyword' value="${cri.keyword }">
					</form>

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
	$(document).ready(function() {

		var formObj = $("form[role='form']");

		console.log(formObj);

		$(".btn-warning").on("click", function() {
			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$(".btn-primary").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/sboard/list");
			formObj.submit();
		});
		$(".btn-danger").on("click", function() {
			formObj.attr("action", "/sboard/removePage");
			formObj.submit();
		});

	});
</script>

<%@include file="../include/footer.jsp"%>

