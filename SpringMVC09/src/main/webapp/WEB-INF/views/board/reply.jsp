<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLineChar","\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("button").on("click",function(e){
				var formData = $("#frm");
				var btn = $(this).data("btn");
				if(btn == "list"){
					formData.find("#idx").remove();
					formData.attr("action","${contextPath}/board/list")
					formData.attr("method","get");
				}
				formData.submit();
			});
		});
	</script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body">
			<form id="frm" action="${contextPath }/board/reply" method="post">
				<input type="hidden" id="page" name="page" value="${cri.page }"/>
				<input type="hidden" id="perPageNum" name="perPageNum" value="${cri.perPageNum }"/>
				<input type="hidden" id="keyword" name="keyword" value="${cri.keyword }"/>
				<input type="hidden" id="type" name="type" value="${cri.type }"/>
				<!-- 원글(부모글) -->
				<input type="hidden" name="idx" value="${vo.idx }"/>
				<input type="hidden" name="memID" value="${mvo.memID }" />
				<div class="form-group">
					<label>제목</label>
					<input type="text" name="title" class="form-control" value="<c:out value='${vo.title }'/>"/>
				</div>
				<div class="form-group">
					<label>답변</label>
					<textarea rows="10" name="content" class="form-control"></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input type="text" name="writer" class="form-control" readonly="readonly" value="${mvo.memName }"/>
				</div>
				<button type="submit" class="btn tbn-default btn-sm">답변</button>
				<button type="reset" class="btn tbn-default btn-sm">취소</button>
				<button data-btn="list" type="button" class="btn btn-sm btn-info">목록</button>
			</form>
		</div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>