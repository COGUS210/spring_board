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
					
					<ul class="mailbox-attachments clearfix uploadedList">
					</ul>
					
					<div class="card-footer">
					<c:if test="${login.uid == boardVO.writer }">
						<button type="submit" id="modifyBtn" class="btn btn-warning">MODIFY</button>
						<button type="submit" id="removeBtn" class="btn btn-danger">REMOVE</button>
					</c:if>
						<button type="submit" id="goListBtn" class="btn btn-primary">GO
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
					<c:if test="${not empty login }">
					<div class="card-body">
						<label for="newReplyWriter">Writer</label>
							<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter"
							value="${login.uid }" readonly="readonly"><br>
							
						<label for="newReplyText">ReplyText</label>
							<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
					</div>
					<!-- /.box-body -->
					<div class="card-footer">
						<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
					</div>
					</c:if>
					
					<c:if test="${empty login }">
						<div class="card-body">
							<div><a href="../user/login">Login Please</a></div>
						</div>
					</c:if>
					
				</div>
			</div>
		</div>
		
		<!-- The time line -->
		<div class="row">
		<div class="col-md-12">
		<div class="timeline">
			<!-- timeline time label -->
			<div class="time-label" id="repliesDiv"><span class="bg-green">
				Replies List  <small id='replycntSmall'>  [${boardVO.replycnt}]  </small></span></div>
				
			<div id="reply">
		
			<script id="template" type="text/x-handlebars-template">
				{{#each .}}
					<div class="replyLi" data-rno={{rno}}>
						<i class="fas fa-comments bg-yellow"></i>
							<div class="timeline-item">
								<span class="time">
									<i class="fas fa-clock"></i>{{prettifyDate regdate}}
								</span>
								<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
								<div class="timeline-body">{{replytext}}</div>
									<div class="timeline-footer">
									{{#eqReplyer replyer }}
									<a class="btn btn-primary btn-xs"
									data-toggle="modal" data-target="#modifyModal">Modify</a>
									{{/eqReplyer}}			
							</div>
						</div>
					</div>
				{{/each}}
			</script>
			</div>
			
			<div>
				<i class="fas fa-clock bg-gray"></i>
			</div>
			
		</div>
		</div>
		</div>
		
		<!-- Modal -->
		<div id="modifyModal" class="modal modal-primary fade" role="dialog">
			 <div class="modal-dialog">
			 	<!-- Modal content -->
			 	<div class="modal-content">
			 		<div class="modal-header">
			 			<h4 class="modal-title"></h4>
			 			<button type="button" class="close" data-dismiss="modal">&times;</button>
			 		</div>
			 		<div class="modal-body" data-rno>
			 			<p><input type="text" id="replytext" class="form-control"></p>
			 		</div>
			 		<div class="modal-footer">
			 			<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
			 			<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
			 			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			 		</div>
			 	</div>
			 </div>
		</div>
		

		
	</div>
	<!-- /.container-fluid -->
</div>
<!-- /.content -->
</div>



<script>
	Handlebars.registerHelper("eqReplyer", function(replyer, block) {
		var accum = '';
		if (replyer == '${login.uid}') {
			accum += block.fn();
		}
		return accum;
	});

	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year+"/"+month+"/"+date;
	});
	
	var printData = function(replyArr, target, templateObject){
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	}
	
	var bno = ${boardVO.bno};
	var replyPage = 1;
	getPage("/replies/"+bno+"/"+replyPage);
	
	function getPage(pageInfo) {
		$.getJSON(pageInfo, function(data){
			printData(data.list, $("#reply") ,$('#template'));
			//printPaging(data.pageMaker, $(".pagination"));
			
			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");
		});
	}
	
	var printPaging = function(pageMaker, target) {
		var str = "";
		
		if (pageMaker.prev) {
			str += "<li><a href = '"+(pageMaker.startPage-1)+"'> << </a></li>";
		}
		
		for (var i=pageMaker.startPage, len=pageMaker.endPage; i<=len; i++) {
			var strClass=pageMaker.cri.page == i?'class=active':'';
			str += "<li "+strClass+ "><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if (pageMaker.next){
			str += "<li><a href='"+(pageMaker.endPage+1)+"'> >> </a><li>";
		}
		
		target.html(str);
	};

	/*
	var source = $("#template").html();
	var template = Handlebars.compile(source);
	var data = [
		{rno: 1, replytext: '111111', regdate: new Date(), replyer: 'aaa'}
	];
	$("#pagination").html(template(data));
	*/
	
	
	
	$(document).ready(function() {

		var formObj = $("form[role='form']");

		console.log(formObj);

		$("#modifyBtn").on("click", function() {
			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$("#goListBtn").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/sboard/list");
			formObj.submit();
		});
		$("#removeBtn").on("click", function() {
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
		
		$(".timeline").on("click", ".replyLi", function(event) {
			var reply = $(this);
			$("#replytext").val(reply.find('.timeline-body').text());
			$(".modal-title").html(reply.attr("data-rno"));
		});
		
		$("#replyModBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			$.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				data:JSON.stringify({replytext:replytext}),
				dataType:'text',
				success:function(result){
					console.log("result: " + result);
					if (result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage);
					}
				}
			});
		});
		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override": "DELETE"
				},
				dataType:'text',
				success:function(result){
					console.log("result: " + result);
					if (result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage);
					}
				}
			});
		});
		

	});
</script>

<%@include file="../include/footer.jsp"%>

