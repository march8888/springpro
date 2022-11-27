<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar","\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			if(${param.error != null}){
				$("#messageType").attr("class","modal-content panel-warning");
				$(".modal-body").text("아이디와 비밀번호를 확인해주세요");
				$(".modal-title").text("실패 메시지");
				$("#myMessage").modal("show");
			}
			
			if(${!empty msgType}){
				$("#messageType").attr("class","modal-content panel-warning");
				$("#myMessage").modal("show");
				
			}
		});
	</script>
</head>
<body>
<div class="container">
	<jsp:include page="../common/header.jsp"/>
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">로그인화면</div>
    <div class="panel-body">
    	<form name="frm" method="post" action="${contextPath }/memLogin.do">
    		<table class="table table-bordered" style="text-align:center; border:1px solid #dddddd;">
    			<tr>
    				<td style="width:110px;vertical-align:middle;">아이디</td>
    				<td colspan="2"><input id="username" name="username" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요"/></td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">비밀번호</td>
    				<td colspan="2"><input id="password" name="password" class="form-control" type="password" maxlength="20" placeholder="패스워드를 입력하세요"/></td>
    			</tr>
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<input type="submit" value="로그인" class="btn btn-primary btn-sm pull-right"/>
    				</td>
    			</tr>
    		</table>
    		<!-- 스프링 시큐리티 토큰 -->
    		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
    	</form>
    </div>
    <!-- 다이얼로그창(모달) - 실패 -->
    <div id="myMessage" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div id="messageType" class="modal-content">
		      <div class="modal-header panel-heading">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">${msgType }</h4>
		      </div>
		      <div class="modal-body">
		        <p id="checkMessage">
		        	${msg }
		        </p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		<!--// 다이얼로그창(모달) - 실패 -->
    <div class="panel-footer">스프1탄_인프런</div>
  </div>
</div>

</body>
</html>