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
		
		<div class="row">
			<div class="col-md-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">ADD NEW REPLY</h3>
					</div>
					<div class="card-body">
						<label for="newReplyWriter">Writer</label>
							<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter"><br>
							
						<label for="newReplyText">ReplyText</label>
							<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
					</div>
					<!-- /.box-body -->
					<div class="card-footer">
						<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- The time line -->
		<ul class="timeline">
			<!-- timeline time label -->
			<li class="time-label" id="repliesDiv"><span class="bg-green">
				Replies List </span></li>
		</ul>
		
		<div class="text-center">
			<ul id="pagination" class="pagination pagination-sm no-margin">
			</ul>
		</div>
		
		<script id="template" type="text/x-handlebars-template">
		{{#each .}}
		<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comments bg-blue"></i>
			<div class="timeline-item">
				<span class="time>
					<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
				</span>
				<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
				<div class="timeline-body">{{replytext}}</div>
					<div class="timeline-footer">
					<a class="btn btn-primary btn-xs"
					data-toggle="modal" data-target="#modifyModal">Modify</a>
				</div>
			</div>
		</li>
		{{/each}}
		</script>
		
	</div>
	<!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>

<script>
	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year+"/"+month+"/"+date;
	});
	var printData = function(replyArr, target, templateObject){
		var template = Handlebars.compile(templateObj.html());
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	}
	
	var bno = ${boardVo.bno};
	var replyPage = 1;
	
	function getPage(pageInfo) {
		$.getJSON(pageInfo, function(data){
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));
			
			$("#modifyModal").modal('hide');
		});
	}
	
	var printPaging = function(pageMaker, target) {
		var str = "";
		
		if (pageMaker.prev) {
			str += "<li><a href = '"+(pageMaker.startPage-1)+"'> << </a></li>";
		}
		
		for (var i=pageMaker.startPage, len=pageMaker.endPage; i<=len; i++) {
			var strClass=pageMaker.cri.page == i?'class=active':'';
			str += "<li "+strClass+ "><a href='"+i+"'</a></li>";
		}
		
		if (pageMaker.next){
			str += "<li><a href='"+(pageMAker.endPage+1)+"'> >> </a><li>";
		}
		
		target.html(str);
	};
	
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
		$("#repliesDiv").on("click", function() {
			if ($(".timeline li").size() > 1) {
				return;
			}
			getPage("/replies/"+bno+"/1");
		});
		$(".pagination").on("click", "li a", function(event){
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPage("/replies/"+bno+"/"+replyPage);
		});
		$("#replyAddBtn").on("click", function(){
			var replyerObj = $("#newReplyWriter");
			var replytextObj = $("#newReplyText");
			var replyer = replyerObj.val();
			var replytext = replytextObj.val();
			
			$.ajax({
				type:'post',
				url:'/replies/',
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType:'text',
				data : JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),
				success:function(result){
					console.log("result: "+result);
					if (result == 'SUCCESS') {
						alert("등록 되었습니다.");
						replyPage=1;
						getPage("/replies/"+bno+"/"+replyPage);
						replyerObj.val("");
						replytextObj.val("");
					}
				}
			});
		});

	});
</script>

<%@include file="../include/footer.jsp"%>

