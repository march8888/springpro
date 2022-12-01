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
				if(btn == "modify"){
					formData.attr("action","${contextPath}/board/modify")
				}else if(btn == "reply"){
					formData.attr("action","${contextPath}/board/reply")
				}else if(btn == "list"){
					formData.find("#idx").remove();
					formData.attr("action","${contextPath}/board/list")
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
			<table class="table table-bordered">
				<tr>
					<td>번호</td>
					<td><input type="text" class="form-control" name="idx" value="${vo.idx }" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" class="form-control" name="title" value="<c:out value='${vo.title }'/>" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="10" class="form-control" name="content" readonly="readonly"><c:out value='${vo.content }'/></textarea></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" class="form-control" name="writer" value="${vo.writer}" readonly="readonly"/></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<c:if test="${!empty mvo }">
							<%-- <button class="btn btn-sm btn-primary" onclick="location.href='${contextPath}/board/reply?idx=${vo.idx}'">답글</button> --%>
							<button data-btn="reply" class="btn btn-sm btn-primary">답글</button>
							<c:if test="${vo.memID eq mvo.memID }">
								<%-- <button class="btn btn-sm btn-success" onclick="location.href='${contextPath}/board/modify?idx=${vo.idx}'">수정</button> --%>
								<button data-btn="modify" class="btn btn-sm btn-success">수정</button>
							</c:if>
							<c:if test="${vo.memID ne mvo.memID }">
								<button disabled="disabled" class="btn btn-sm btn-success" onclick="location.href='${contextPath}/board/modify?idx=${vo.idx}'">수정</button>
							</c:if>
						</c:if>
						<c:if test="${empty mvo }">
							<button disabled="disabled" class="btn btn-sm btn-primary" onclick="location.href='${contextPath}/board/reply?idx=${vo.idx}'">답글</button>
							<button disabled="disabled" class="btn btn-sm btn-success" onclick="location.href='${contextPath}/board/modify?idx=${vo.idx}'">수정</button>
						</c:if>
						<%-- <button class="btn btn-sm btn-info" onclick="location.href='${contextPath}/board/list'">목록</button> --%>
						<button data-btn="list" class="btn btn-sm btn-info">목록</button>
					</td>
				</tr>
			</table>
			
			<form id="frm" method="get">
				<input type="hidden" id="idx" name="idx" value="${vo.idx }"/>
			</form>
			
		</div>
    <div class="panel-footer">스프2탄(답변형 게시판 만들기)</div>
  </div>
</div>

</body>
</html>