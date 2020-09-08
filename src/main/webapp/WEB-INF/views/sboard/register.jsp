<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<!-- Main content -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">REGISTER BOARD</h3>
					</div>
					<!-- /.card-header -->
					<!-- form start -->
					<form role="form" method="post">
						<div class="card-body">
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> <input type="text"
									name="title" class="form-control" placeholder="Enter title">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="content" rows="3"
									placeholder="Enter ..."></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label> <input
									type="text" name="writer" class="form-control"
									placeholder="Enter Writer">
							</div>
						</div>
						<!-- /.card-body -->

						<div class="card-footer">
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
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

<%@include file="../include/footer.jsp"%>

