<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}

.regist_wrap{
	flex-direction: column;
	width: 800px;
	heignt: 600px;
    magin-top: 80px;
}

.regist_form{
    display: flex;
	position: absolute;
	flex-direction: column;
    width: 800px;
    align-items: center;
    
}

.headline{
	margin-top: 200px;
}

.headline a{
	font-size: 22pt;
    font-weight: bold;
}

table{
    margin-top: 30px;
    align-items: center;
}

table tr td a{
	text-decoration: none;
	font-size: 0.7rem;
}

div span{
    text-decoration: none;
	font-size: 0.6rem;
    color: grey;
}

.login_regist_wrap{
	width: 100%;
	height: 850px;
	display: flex;
	justify-content: center;
}
     table tr th{
        text-align: left;
        width: 100px;
        height: 40px;
        font-size: 0.8rem;
   		font-weight: bold;
    }

    td input[type="text"], input[type="password"] {
    	width: 230px; height: 30px;
    	font-size: 0.7rem;
    	border: 1px solid #d1d1d1;
        padding-left: 7px;
	}

    td input[type="button"]{
        border: none;
        border-radius: 2px;
        background-color: #FAEED2;
        font-size: 0.5rem;
        color: rgb(95, 95, 95);
    }

    .user_id_chk, .user_addr_chk{
        width: 55px;
        height: 18px;
    }

    .user_email_chk{
        width: 75px;
        height: 18px;
    }
    
    .user_eamil{
    	margin-top: 5px;
    }
    
    .user_email_injeong{
    	width: 20px;
    	margin-top: 5px;
    	
    }
    
    #user_email_injeong_false{
    	background-color:#ebebe4;
	}
	 
	#user_email_injeong_true{
	    background-color:white;
	}

    .regist_btn{
        text-align: center;
        margin: 30px;
    }

    .user_addr_sub{
        margin-top: 5px;
    }

    .submit_btn{
        border: none;
        border-radius: 4px;
        width: 75px;
        height: 30px;
        background-color: #ffe084;
        color: white;
        font-weight: bold;
    }

    .back_btn{
        border: none;
        border-radius: 4px;
        width: 60px;
        height: 30px;
        background-color: rgb(134, 134, 132);
        color: white;
        font-weight: bold;
    }
    
    #id_chk_available, #pw_chk_available, #email_chk_available{
    	display: none;
    	color: blue;
    }
    
    #id_chk_unavailable, #id_chk_blank, #pw_chk_unavailable, #email_chk_blank, #email_chk_unavailable{
   		display: none;
    	color: red;
    }

</style>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	//?????? ????????
	function idCheck(){
		$("#id_chk_unavailable").hide();
		$("#id_chk_available").hide();
		$("#id_chk_blank").hide();
		
		$.ajax({
			url:"idCheck.do",
			type:"post",
			dataType:"json",
			data:{"user_id" : $('#id').val()},
			success: function(data){
				if($("#id").val() != ''){
					if(data == 1){					
						$("#id_chk_unavailable").show();
					}else if(data == 0){
						$("#id").attr("title", "y");
						$("#id_chk_available").show();
						$("#user_name").focus();
					}
				}else{
					$("#id_chk_blank").show();
				}
			}
		})
	}
	
	//?????? ???????? ????
	function idChkConfirm(){
		var chk = document.getElementById("id").title;
		if(chk=="n"){
			alert("?????? ?????????? ????????.");
			document.getElementById("id").focus();
		}
	}
	
	//???????? ????
	$(function(){
		$("#pw_chk_available").hide();
		$("#pw_chk_unavailable").hide();
		
		$("#pw_chk").keyup(function(){
			var pw = $("#pw").val();
			var pw_chk = $("#pw_chk").val();
			
			if(pw != "" || pw_chk != ""){
				if(pw == pw_chk){
					$("#pw_chk_available").show();
					$("#pw_chk_unavailable").hide();
					$("#pw").attr("title", "y");
				}else{
					$("#pw_chk_available").hide();
					$("#pw_chk_unavailable").show();
				}
			}
		});
	});
	
	//???????? ???? ????
	function pwChkConfirm(){
		var chk = document.getElementById("pw").title;
		if(chk=="n"){
			alert("?????????? ????????????.");
			document.getElementById("pw").focus();
		}
	}
	
	var code = "";	//?????????? ???????? ???????? ???? ????
	
	//?????? ????
	function emailCheck(){
		
		 var user_email = $(".user_email").val();        // ?????? ??????
		 var checkBox = $(".user_email_injeong");		 // ???????? ??????

		 $.ajax({
		 	type:"GET",
		 	url:"emailCheck.do?user_email=" + user_email,
		 	success:function(data){
		 		//console.log("data: " + data);
		 		
		 		if(user_email != ''){
		 			$("#email_chk_blank").hide();
			 		checkBox.attr("disabled", false);
			 		checkBox.attr("id","user_email_injeong_true");
			 		$(".user_email_injeong").focus();
			 		code = data;
		 		}else{
		 			$("#email_chk_blank").show();
		 		}
		 	}
		                
		 });
	}
	
	//???????? ????
	$(function(){
		
		$(".user_email_injeong").keyup(function(){
			var inputCode = $(".user_email_injeong").val();		//????????
			
			$("#email_chk_available").hide();
			$("#email_chk_unavailable").hide();
			
			if(inputCode == code){
				$("#email_chk_available").show();
				$("#email_chk_unavailable").hide();
				$("#user_email").attr("title", "y");
			}else{
				$("#email_chk_unavailable").show();
				$("#email_chk_available").hide();
			}
		});
	});
	
	//???????? ???? ????
	function emailChkConfirm(){
		var chk = document.getElementById("user_email").title;
		if(chk=="n"){
			alert("?????? ?????? ????????.");
			document.getElementById("user_email").focus();
		}
	}
	
	
	//null?? ????
	$(document).ready(function(){
	
		$("#submit").on("click", function(){
			if($("#id").val()==""){
				alert("???????? ????????????.");
				$("#id").focus();
				return false;
			}
			if($("#user_name").val()==""){
				alert("?????? ????????????.");
				$("#user_name").focus();
				return false;
			}
			if($("#pw").val()==""){
				alert("?????????? ????????????.");
				$("#pw").focus();
				return false;
			}
			if($("#user_email").val()==""){
				alert("???????? ????????????.");
				$("#user_email").focus();
				return false;
			}
			if($("#user_addr").val()==""){
				alert("???? ????????????.");
				$("#user_addr").focus();
				return false;
			}
			if($("#user_phone").val()==""){
				alert("?????? ?????? ????????????.");
				$("#user_phone").focus();
				return false;
			}

		});
	
	})
	
</script>

<!-- ?????? ???? api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function addr_search() {
        new daum.Postcode({
            oncomplete: function(data) {
                // ???????? ???????? ?????? ?????????? ?????? ?????? ???????? ????.

                // ?? ?????? ???? ?????? ???? ?????? ????????.
                // ???????? ?????? ???? ???? ?????? ????('')???? ????????, ???? ???????? ???? ????.
                var addr = ''; // ???? ????
                var extraAddr = ''; // ???????? ????

                //???????? ?????? ???? ?????? ???? ???? ???? ???? ????????.
                if (data.userSelectedType === 'R') { // ???????? ?????? ?????? ???????? ????
                    addr = data.roadAddress;
                } else { // ???????? ???? ?????? ???????? ????(J)
                    addr = data.jibunAddress;
                }

                // ???????? ?????? ?????? ?????? ???????? ?????????? ????????.
                if(data.userSelectedType === 'R'){
                    // ?????????? ???? ???? ????????. (???????? ????)
                    // ???????? ???? ?????? ?????? "??/??/??"?? ??????.
                    if(data.bname !== '' && /[??|??|??]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // ???????? ????, ?????????? ???? ????????.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // ?????? ?????????? ???? ????, ???????? ?????? ???? ???????? ??????.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // ?????? ?????????? ???? ?????? ??????.
                    document.getElementById("user_addr").value = extraAddr;
                
                } else {
                    document.getElementById("user_addr").value = '';
                }

                // ?????????? ???? ?????? ???? ?????? ??????.
                document.getElementById("user_addr").value = addr;
                // ?????? ???????? ?????? ????????.
                document.getElementById("user_addr_sub").focus();
            }
        }).open();
    }
</script>
<body>
	<div id="header">
		<%@ include file="../common/header.jsp"%>
	</div>
	
    <div class="login_regist_wrap">
        <div class="regist_wrap">
            <div class="headline">
                <a>????????</a>
                <hr>
            </div>
            <div class="regist_form">
            <form action="memberRegist.do" method="post">
                <table width="550px">
                    <tr>
                        <col width="150px"> <col width="300px">
                    </tr>
                    <tr>
                        <th>??????</th>
                        <td>
                            <input type="text" class="user_id" name="user_id" id="id" title="n" required="required" placeholder="???????? ??????????." autofocus>
                            <input type="button" class="user_id_chk" value="???? ????" onclick="idCheck();"><br>
                            <span id="id_chk_available">?????????? ????????????.</span>
                            <span id="id_chk_unavailable">?????? ????????????.</span>
                            <span id="id_chk_blank">???????? ??????????.</span>
                        </td>
                    </tr>
                    <tr>
                        <th>????</th>
                        <td><input type="text" class="user_name" name="user_name" id="user_name" required="required" placeholder="?????? ??????????." onclick="idChkConfirm();"></td>
                    </tr>
                    <tr>
                        <th>????????</th>
                        <td><input type="password" class="user_pw" name="user_pw" id="pw" title="n" required="required" placeholder="?????????? ??????????." onclick="idChkConfirm();"></td>
                    </tr>
                    <tr>
                        <th>???????? ????</th>
                        <td>
                        	<input type="password" class="user_pw_chk" name="pw_chk" id="pw_chk" required="required" onclick="idChkConfirm();"><br>
                        	<span id="pw_chk_available">?????????? ??????????.</span>
                            <span id="pw_chk_unavailable">?????????? ???????? ????????.</span>
                        </td>
                    </tr>
                    <tr>
                        <th>??????</th>
                        <td>
                        	<input type="text" class="user_email" name="user_email" id="user_email" title="n" required="required" placeholder="???????? ??????????." onclick="pwChkConfirm();">
                        	<input type="button" class="user_email_chk" value="???????? ????" onclick="emailCheck();">
                        	<input type="text" class="user_email_injeong" name="user_email_injeong" id="user_email_injeong_false" required="required" disabled="disabled"><br>
                        	<span id="email_chk_blank">???????? ??????????.</span>
                        	<span id="email_chk_available">?????????? ??????????.</span>
                            <span id="email_chk_unavailable">?????????? ???????? ????????.</span>
                        </td>
                    </tr>
                    <tr>
                        <th>???? ????</th>
                        <td>
                            <input type="radio" name="user_mailing" class="user_mailing" value="Y" checked="checked"><a> ??????</a>&nbsp;&nbsp;
                            <input type="radio" name="user_mailing" class="user_mailing" value="N"><a> ???????? ????</a>
                        </td>
                    </tr>
                    <tr>
                        <th>????</th>
                        <td>
                            <input type="text" class="user_addr" name="user_addr" id="user_addr" required="required" placeholder="?????????? ??????????." readonly="readonly">
                            <input type="button" class="user_addr_chk" value="???? ????" onclick="addr_search();"><br>
                            <input type="text" class="user_addr_sub" name="user_addr_sub" id="user_addr_sub" required="required" placeholder="?????????? ??????????." onclick="emailChkConfirm();">
                        </td>
                    </tr>
                    <tr>
                        <th>?????? ????</th>
                        <td>
                            <input type="text" class="user_phone" name="user_phone" id="user_phone" required="required" placeholder="'-' ???? ???? ?????? ??????????.">
                        </td>
                    </tr>
                    <tr>
                        <th>???????? ????</th>
                        <td>
                            <input type="checkbox" class="prefer" name="prefer" value="k_food"><a> ????</a> &nbsp;
                            <input type="checkbox" class="prefer" name="prefer" value="j_food"><a> ????</a> &nbsp;
                            <input type="checkbox" class="prefer" name="prefer" value="c_food"><a> ????</a> &nbsp;
                            <input type="checkbox" class="prefer" name="prefer" value="w_food"><a> ????</a> &nbsp;
                            <input type="checkbox" class="prefer" name="prefer" value="v_food"><a> ????</a><br>
                            <div class="prefer_txt"><span>???????? ????</span></div>
                        </td>
                    </tr>         
                </table>
                    <div class="regist_btn">
                        <input type="submit" class="submit_btn" id="submit" value="????????">
                        <input type="button" class="back_btn" value="?? ??" onclick="location.href='index.do'">
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