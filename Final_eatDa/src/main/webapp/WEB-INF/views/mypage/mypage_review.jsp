<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}

.review{
	flex-direction: column;
	width: 800px;
    margin-top: 180px;  
}

.headline{
	margin-top: 0px;
}

.headline a{
	font-size: 22pt;
    font-weight: bold;
}



.mypage_wrap{
	width: 100%;
	height: 850px;
	display: flex;
	justify-content: center;
}

.review_form th{
        text-align: left;
        vertical-align: top;
        width: 100px;
        height: 40px;
        font-size: 0.8rem;
   		font-weight: 600;
    }
    
    .review_form td{
        vertical-align: top;
    }
</style>
<body>
	<div id="header">
		<%@ include file="../common/header.jsp"%>
	</div>
	<div class="mypage_wrap">     
        <div class="review">
            <div class="headline">
                <a>REVIEW</a>
                <hr>
            </div>
            
            <div class="review_form">
            <form action="registReview.do" method="post">
            <input type="hidden" name="order_id" value="${dto.order_id }">
            <input type="hidden" name="p_id" value="${dto.p_id }">
                <table width="550px">
                    <tr>
                        <col width="150px"> <col width="300px">
                    </tr>
                    <tr>
                        <th>상품</th>
                        <td>
                        	<img src="${dto.img_path }" width="150" height="150"><br>
                        	<a>${dto.p_name }</a>
                        </td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
							<textarea rows="10" cols="60" name="review_content"></textarea>
						</td>
                    </tr>         
                </table>
                    <div class="regist_btn">
                        <input type="submit" class="submit_btn" value="작 성">
                        <input type="button" class="delete_btn" value="취 소" onclick="#">
                    </div>
            </form>
          </div>
        </div>
    </div>
	<div id="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>
</body>
</html>