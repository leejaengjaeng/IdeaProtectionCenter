<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="/resources/common/css/copyRight.css" rel="stylesheet">
<link href="/resources/common/css/index.css" rel="stylesheet">
<link href="/resources/common/css/style.css" rel="stylesheet">
<script src="/resources/common/js/copyrightComment.js"></script>
<c:import url="/WEB-INF/views/import/header.jsp" />

<script>
$(document).ready(function()
{
	disableAllInput();
	if("${role}" == "inventor")
	{
		if(${copyrightVo.getFlag()} == 0);		  					//개발자 작성 후
		else if(${copyrightVo.getFlag()} == 1) enableReComment();	//코멘트 달림 
		else alert("Flag가 뭘까? ->"+${copyrightVo.getFlag()});
	}
	else if("${role}" == "pl")
	{
		if(${copyrightVo.getFlag()} == 0) enableReComment(); //개발자 작성 후
		else if(${copyrightVo.getFlag()} == 1);				 //코멘트 달림 
		else alert("Flag가 뭘까? ->"+${copyrightVo.getFlag()});
	}
	else alert('역할이 뭐니'+${role})
		
	$('#IdeaModifyList').on('click','li',function()
	{
		var cid = $(this).children('input').val();
		$("#drop_sp").text($(this).data("val"));
		showClickedList(cid)
	});
});

});
</script>
</head>
<body>	
	<div class="wrap_comment">
		<section> <article class="sub_head">
		<h1>
			<b style="color: #45d7c2">저작권</b>출원
		</h1>
		</article> 
		<article>
			<div class="dropdown">
				<div class="arrow-up ee"></div>					
				<ul id="IdeaModifyList">
					<c:forEach items="${chasuList}" var="chasu" varStatus="status">
							<c:choose>
								<c:when test="${status.first and status.last }">
									<li class ="clickedIdea" data-val="저작권 등록 (초안) ${chasu.getRegistration_date()}">
										<input type="hidden" value="${chasu.getCid()}"/>
										저작권 등록 (초안)
										${chasu.getRegistration_date()}
									</li>
								</c:when>
								<c:when test="${status.first }">
									<li data-val="저작권  등록 (초안) ${chasu.getRegistration_date()}">
										<input type="hidden" value="${chasu.getCid()}"/>
										저작권 등록 (초안)
										${chasu.getRegistration_date()}
									</li>
								</c:when>
								<c:when test="${status.last }">
									<li class="clickedIdea" data-val="${status.index}차 전문가 검토 및 수정안 ${chasu.getRegistration_date()}">
										<input type="hidden" value="${chasu.getCid()}"/>
										${status.index}차 전문가 검토 및 수정안
										${chasu.getRegistration_date()}
									</li>
								</c:when>
								<c:otherwise>
									<li data-val="${status.index}차 전문가 검토 및 수정안 ${chasu.getRegistration_date()}">
										<input type="hidden" value="${chasu.getCid()}"/>
										${status.index}차 전문가 검토 및 수정안
										${chasu.getRegistration_date()}
									</li>
								</c:otherwise>
				         	</c:choose>
					</c:forEach>
				</ul>					
			</div>
		<form action="/copyRight/regCopyright_pl" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="hidden" name="uid" id="uid" value="${sessionScope.currentUser.getUid()}" />				
			<input type="hidden" name="cid" id="cid" value="${copyrightVo.getCid()}" />
			
<!-- 명칭 -->
			<div class="txt_box">
				<h2>저작물 명칭</h2>
				<button style="margin-bottom:20px;">작성예시 보기</button>
				<input type="text" id="idea_kind" name="idea_kind" placeholder="본인이 창작한 저작물의 이름을 정해 주세요 / 물품명 + 사용용도 or 사용용도 + 적용물품"
				value="${copyrightVo.getTitle() }">

				<textarea placeholder="이전답변" id="comment_idea_kind">${beforeCv.getRe_title() }</textarea>		
				<textarea placeholder="코멘트" id="re_idea_kind" name="re_idea_kind"></textarea>					
			</div>
<!-- 분야 -->
			<div class="txt_box">
				<h2>저작물 분야</h2>
				<button>작성예시 보기</button>
				<br>
				<div class="field">
					<span>분야</span> 
					<select id="field_selected" name="field_selected" style="float:none;margin-left:20px;">
					<!-- 	<option>-선택-</option> -->
						<c:forEach items="${typeList}" var="type">
						<option>${type.getType()}</option>
						</c:forEach>
					</select>
<!-- 종류 -->
					<span style="display: inline-block; margin-left: 140px;">종류</span>
					<input type="text" id="kind" name="kind" value=${copyrightVo.getType() } style="float:none;">
					<textarea disabled="disabled" class="disabled">
-이전 답변-
분야:${beforeCv.getRe_field()}
종류:${beforeCv.getRe_type()}
					</textarea>	
					<br><span id="re_field_txt" style="display: inline-block; margin-top:20px;">분야</span> 
					<select id="re_field_selected" name="re_field_selected" style="float:none">
						<option></option>
						<c:forEach items="${typeList}" var="type">
						<option>${type.getType()}</option>
						</c:forEach>
					</select>
					<span style="display: inline-block; margin-left: 140px;">종류</span>
					<input type="text" id="re_kind" name="re_kind">		
				</div>
				<span style="font-size: 0.8rem; color: #45d7c2; display: inline-block; float: left; margin-top: 10px;">
					본인이 창작한 저작물의 분야를 선택해주세요. 
				</span>				
			</div>
<!-- 의미 -->
			<div class="txt_box" style="margin-top: 100px;">
				<h2>저작물의 의미</h2>
				<button>작성예시 보기</button>
				<textarea id="meaning" name="meaning">${copyrightVo.getMeaning() }</textarea>

				<textarea placeholder="이전답변" disabled="disabled" class="disabled"> ${beforeCv.getRe_meaning() }</textarea>			
				<textarea id="re_meaning" name="re_meaning" placeholder="코멘트"></textarea>		

			</div>
<!-- 첨부 -->
			<div class="txt_box">
				<h2>저작물 첨부</h2>
				<button>작성예시 보기</button>
				<input type="file" style="float: left; margin: 10px; opacity: 1; padding-top: 5px;">				
				<div id="add_btn" onclick="addfile2()">추가하기</div>
				<div class="hiding_box">
					<div class="hiding_box_header">
						<h3>저작물 명칭</h3>
						<img src="image/close.png" alt="close" class="close_btn">
					</div>
					<div class="hiding_box_content">
						<span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
					</div>
				</div>
			</div>
			<div class="txt_box">
				<img src="#" alt="등록된 디자인 시안이 없습니다.">
			</div>
			<div class="txt_box">
				<textarea disabled="disabled" class="disabled" placeholder="이전답변"></textarea>			
				<textarea placeholder="코멘트"></textarea>
			</div>
			<div id="fin">
				<!-- <button>임시저장</button>	 -->
				<button id="agree" onclick="submitFunc()">등록하기</button>
			</div>
		</form>
		</article>
		</section>
	</div>
	
	<c:import url="/WEB-INF/views/import/footer.jsp" />

<script type="text/javascript">
	$(function(){
		$(".txt_box>button").attr("type","button");
	});
	  
	$(".dropdown").click(function(){		
		if($(this).height() < 100){
		    $(this).css('max-height', '500px'); //set max height
		}else{
		    $(this).css('max-height', '50px'); //delete attribute
		}
	});
</script>
</body>
</html>