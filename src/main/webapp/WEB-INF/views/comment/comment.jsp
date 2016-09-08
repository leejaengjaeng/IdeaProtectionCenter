<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>  
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
<script>
	$(document).ready(function()
	{
		if("${user}" == "pl")
		{
			var hideEl = document.getElementsByClassName('before_cmt')
			for(var i =0; i <hideEl.length ; i++)
				hideEl[i].style.display="none";
		}
		else if("${user}" == "inventor")
		{
			var hideEl = document.getElementsByClassName('box_comment1')
			for(var i =0; i <hideEl.length ; i++)
				hideEl[i].style.display="none";
		}
		else
		{
			//redirect 시키기?
		}	
	});
</script>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">       
        <section>            
           <nav>
                <div id="profile">
                    <img src="#" alt="profile">
                    <h4>${sessionScope.currentUser.getName()} 회원님</h4>
                    <span>ideaconcert</span>
                </div>
                <div id="profile_menu">
                    <ul>
                        <li>아이디어 진행내역</li>
                        <li>회원정보수정</li>                                                
                    </ul>
                </div>
                <div id="nav_benner">
                    <ul>
                        <li>
                            <img src="#" alt="benner1">
                        </li>
                        <li>
                            <img src="#" alt="benner2">
                        </li>
                        <li>
                            <img src="#" alt="benner3">
                        </li>
                        <li>
                            <img src="#" alt="benner4">
                        </li>
                    </ul>
                </div>
            </nav>            
            <article class="sub_head">                    
                <h1><b>아이디어</b> 초안</h1>                
                <img src="/resources/image/cmt.png" alt="cmt" style="width:100%; float:left;">
            </article>                
            <article class="modify_log">                    
                <h1>아이디어수정내역</h1>   
                <table>
                    <c:forEach items="${processList}" var="list" varStatus="status">
						<tr>
							<input type="hidden" value="${list.getRid()}"/>
							<c:if test="${status.index == 0}">
								<td class="title_td">아이디어 등록(초안)</td>
							</c:if>
							<c:if test="${status.index > 0}">
								<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
	                        </c:if>
	                        <td class="date_td">${list.getRegistration_date()}</td>
	                    </tr>                    
					</c:forEach>
                </table>                             
            </article>  
            <article>
                <div class="txt_box">
                    <h2>발명분야</h2>   
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>             
                    <div class="box_before1">                        
                        <span>${item.getTypeOfInvent() }</span>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                 <div class="txt_box">
                    <h2>제목</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div class="box_before1">                        
                        <span>${item.getTitle() }</span>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>요약</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>                    
                    <div class="box_before1_b">                        
                        <p>${item.getSummary() }</p>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="txt_box">
                    <h2>필요이유</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div class="box_before1_b">                        
                        <p>${item.getWhyInvent() }</p>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div class="box_before1_b">                        
                        <p>${item.getProblem() }</p>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>문제해결방법</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div class="box_before1_b">                        
                        <p>${item.getSolution() }</p>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>발명의 효과</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div class="box_before1_b">                        
                        <p>${item.getEffect() }</p>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                           <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>핵심구성요소</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div class="box_before1_b">                        
                        <p>${item.getCore_element() }</p>
                    </div>
                    <div class="box_comment1">                    
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2 style="width:100%">도면첨부</h2>
                    <button>작성 예시</button>
                    <div class="before_cmt">
                        <p>Before Comment...</p>
                    </div>
                    <div id="demo_box">
                        <div class="demo"></div>
                        <div class="demo"></div>
                        <div class="demo"></div>
                        <div class="demo"></div>
                        <div class="demo"></div>
                        <div class="demo"></div>                                            
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..."></textarea>
                        </div>
                    </div>
                </div>     
                <div class="hr"></div>           
                <div id="fin"> 
                    <button>임시저장</button>
                    <button id="agree">코멘트작성</button>                    
                </div>
            </article>
        </section>
    </div>
    <c:import url="/WEB-INF/views/import/footer.jsp"/>   
</body>
</html>