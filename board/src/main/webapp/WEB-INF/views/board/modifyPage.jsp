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
						<h3 class="card-title">MODIFY BOARD</h3>
					</div>
					<!-- /.card-header -->
					<!-- form start -->
					<form role="form" action="modifyPage" method="post">
						<input type='hidden' name='page' value="${cri.page }"> <input
							type='hidden' name='perPageNum' value="${cri.perPageNum }">

						<div class="card-body">
							<div class="form-group">
								<label for="exampleInputEmail1">BNO</label> <input type="text"
									name="bno" class="form-control" value="${boardVO.bno}"
									readonly="readonly">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> <input type="text"
									name="title" class="form-control" value="${boardVO.title}">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="content" rows="3">${boardVO.content}</textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label> <input
									type="text" name="writer" class="form-control"
									value="${boardVO.writer}" readonly="readonly">
							</div>
						</div>

					</form>
					<!-- /.card-body -->

					<div class="card-footer">
						<button type="submit" class="btn btn-primary">SAVE</button>
						<button type="submit" class="btn btn-warning">CANCEL</button>
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
	$(document)
			.ready(
					function() {

						var formObj = $("form[role='form']");

						console.log(formObj);

						$(".btn-warning")
								.on(
										"click",
										function() {
											self.location = "/board/listPage?page=${cri.page}&perPageNum=${cri.perPageNum}";
										});

						$(".btn-primary").on("click", function() {
							formObj.submit();
						});

					});
</script>

<%@include file="../include/footer.jsp"%>

