<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/market/marketMainnew.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=IBM+Plex+Sans+KR:wght@200&display=swap" rel="stylesheet">
<title>Insert title here</title>

<style type="text/css">
.banner {
	background-image: url(resources/images/market/market-banner3.png);
	background-size: cover;
	width: 100%;
	margin: 0 auto;
	height: 300px;
	margin-bottom: 30px;
	padding-top: 140px;
	border-radius: 4px;
}
.product-img {
	width:100%;
	height:60%;
	overflow: hidden;
}

.p-img {
	width: 95%;
	height: 95%;
	border-radius:4px;
	transition: all 0.2s linear;
}
.product-card {
	box-shadow: 0px 4px 4px -4px gray;
	width: 26%;
	height:100%;
	float: left;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
let productList;
let tagList;

$(document).ready(function() {
	productList = takeProduct();
	pagination();
	likeProduct();
	
    //검색바 사이즈 조절
    $('#search-bar').click(function() {
        $('.search-box-narrow').css({"padding-left":"31%"});
        $('#search-bar').animate({width:'55%'},200);
    });
    $('#search-bar').focusout(function() {
        $('#search-bar').css({'width':'30%'}).val('');
        $('.search-box-narrow').css({'padding-left':'42%'});
    });

    //배너 사진 변경
    let index = 3;
    window.setInterval(function() {
        if (index == 5) {
            index = 1;
        }
        $('.banner').animate({opacity:0}, 800, function() {
            $('.banner').css('background-image','url(resources/images/market/market-banner'+index+'.png)');
        });
        $('.banner').animate({opacity:1}, 800);
        index++;
    }, 10000);

    //검색창에서 엔터키 눌렀을 때
    $("#search-bar").on("keydown",function(event) {
		if (event.keyCode == 13) {
			if (!event.shiftKey) {
				event.preventDefault();
				searchKeyword();
			}
		}
	});
});

const searchKeyword = () => {
	let keyWord = $('#search-bar').val();
	hashTagSearch(keyWord);
	$('#search-bar').val('');
}

//장바구니에 담기
const putShoppingBag = (object) => {
	let p_id = $(object).parents('.product-desc').siblings('.hidden').text();
	let p_name = $(object).parent().siblings('.product-margin:eq(1)').children('span').text();
	let p_price = $(object).siblings('.product-price').eq(0).text();
	let data = {
			"p_id":p_id,
			"p_price":p_price
	}
	
	if (confirm('선택하신 '+p_name+' 을 장바구니에 담시겠습니까?')) {
		$.ajax({
			url: 'putShoppingBag.do',
			type: 'post',
			data: JSON.stringify(data),
			contentType: 'application/json; charset=utf-8',
			success:function(msg) {
				if (msg == 'true') {
					alert('담기 완료! 장바구니로 이동합니다.');
					location.href='goShoppingBag.do';
				} else {
					alert('상품이 이미 장바구니에 담겨있습니다.');
				}
			}
		});
	}
}

//전체 상품 가져오기
const takeProduct = () => {
	let list;
	$('.product-container').html('');
		
	$.ajax({
		url: "product.do",
		type: "post",
		async: false,
		dataType: "json",
		success:function(data) {
			list = data;
			makeProductPage(list, 1);
		}
	});
	return list;
}

//페이징 함수
const pagination = () => {
	let paging = 0;
	$('.pagination').html('');
	
	$.ajax({
		url: "paging.do",
		type: "post",
		dataType: "json",
		success: function(data) {
			paging = Number(data);
			
			if (paging%9 == 0) {
				paging = paging/9;
			} else {
				paging = paging/9 + 1;
			}
			
			$('.pagination').append(
				"<a id='left-paging' onclick='leftPaging()'>&laquo;</a>"
			);
			
			for (var i = 1; i <= paging; i++) {
				$('.pagination').append(
					"<a id='page" + i + "' onclick='movePage(this)'>"+i+"</a>"
				);
			}
			$('.pagination').children().eq(1).addClass('active');
			$('.pagination').append(
				"<a id='right-paging' onclick='rightPaging()''>&raquo;</a>"		
			);
		}
	});
}

const movePage = (object) => {
	let page = Number($(object).text());
	let pageid = $(object).attr('id');
	makeProductPage(productList,page);
	
	$('.active').removeClass('active');
	document.getElementById(pageid).className += 'active';
	$(window).scrollTop(0);
}

const leftPaging = () => {
	let prevPage = $('.active').prev().text();
	if (prevPage == '«') {
		return;
	} else {
		makeProductPage(productList,prevPage);
		$('.active').prev().addClass('active');
		$('.active').eq(1).removeClass('active');
	}
	$(window).scrollTop(0);
}

const rightPaging = () => {
	let nextPage = $('.active').next().text();
	if (nextPage == '»') {
		return;
	} else {
		makeProductPage(productList,nextPage);
		$('.active').next().addClass('active');
		$('.active').eq(0).removeClass('active');
	}
	$(window).scrollTop(0);
}

const makeProductPage = (list, page) => {
	let firstProduct = Number(page)*9-9;
	let idx = 0;
	let col = 0;
	$('.product-container').html('');
	
	for (let i = firstProduct; i < list.length; i++) {
		if (i == firstProduct+9) {break;}
		if (idx == 0) {
			$('.product-container').append(
					"<div class='row product-section'>" + "<div class='col-md-12 product-col'>" +
					"<div class='product-card' style='margin: 0 2%;'>" +
					"<div class='hidden' style='opacity:0;'>"+ list[i].p_id +"</div>" +
					"<div class='product-img' align='center'>" +
					"<img src='"+ list[i].img_path +"' class='p-img' onclick='goProductPage(this)'>" +
					"</div>" +
					"<div class='product-desc'>" +
					"<div class='product-margin'>" +
					"<span class='short-desc'>" + list[i].p_short_desc + "</span><br>" +
					"</div>" +
					"<div class='product-margin'>" +
					"<span class='product-title' onclick='goProductPage(this)'>" + list[i].p_name + "</span><br>" +
					"</div>" +
					"<div class='product-margin' style='margin-top:5px; margin-bottom: 15px;'>" +
					"<span class='product-price'>" + list[i].p_price + "</span><span class='product-price'>원</span>" +
					"<img src='resources/images/market/shop.png' class='shop-cart' onclick='putShoppingBag(this)'>" +
					"</div>" +
					"</div>" +
					"</div>"
			);
			idx++;
			
		} else {
			$('.product-col').eq(col).append(
					"<div class='product-card' style='margin: 0 2%;'>" +
					"<div class='hidden' style='opacity:0;'>"+ list[i].p_id +"</div>" +
					"<div class='product-img' align='center'>" +
					"<img src='"+ list[i].img_path +"' class='p-img' onclick='goProductPage(this)'>" +
					"</div>" +
					"<div class='product-desc'>" +
					"<div class='product-margin'>" +
					"<span class='short-desc'>" + list[i].p_short_desc + "</span><br>" +
					"</div>" +
					"<div class='product-margin'>" +
					"<span class='product-title' onclick='goProductPage(this)'>" + list[i].p_name + "</span><br>" +
					"</div>" +
					"<div class='product-margin' style='margin-top:5px; margin-bottom: 15px;'>" +
					"<span class='product-price'>" + list[i].p_price + "</span><span class='product-price'>원</span>" +
					"<img src='resources/images/market/shop.png' class='shop-cart' onclick='putShoppingBag(this)'>" +
					"</div>" +
					"</div>" +
					"</div>"	
			);
			
			if (idx != 2) {
				idx++;
			} else if (idx == 2) {
				col++;
				idx = 0;
			}
		}
	}
}

//좋아하는 상품 이미지 가져오기
//product_like 테이블, product 테이블 조인해서 데이터 가져오면 됨
function likeProduct() {
	$.ajax({
		url:"likeProduct-main.do",
		type:"post",
		dataType:"json",
		success:function(data) {
			let list = data;
			$(list).each(function(key, value) {
				$('.like-title').append(
					"<div class='like-img-div'>" +
					"<img id='" + value.p_id + "' class='like-img' src='" + value.img_path + "' onclick='goLikeProduct(this)'>" +
					"</div>"
				);
			});
		}
	});
}

function goLikeProduct(object) {
	let p_id = $(object).attr('id');
	location.href = 'goProductPage.do?p_id='+p_id;
}

//키워드 검색
function hashTagSearch(object) {
	let tagname = '';
	let href = '';
	if ($(object).attr('class')=='keyword') {
		tagname = tagMatch($(object).text().substring(1));
		href = 'hashTagSearch.do';
	} else {
		tagname = object;
		href = 'searching.do';
	}
	
	$.ajax({
		url: href,
		type:'post',
		data: JSON.stringify(tagname),
		contentType: 'application/json; charset=utf-8',
		success:function(list) {
			$('.pagination').html('');
			$('.product-container').html('');
			
			if (list.length == 0) {
				$('.product-container').append(
						"<div class='row' style='height:250px; margin-bottom:40px;'>" +
						"<div class='col-md-12' align='center'>" +
						"<div style='width:80%; height:30%; margin:0 auto; padding-top: 4%; font-size:x-large; font-weight:medium'>" +
						"검색하신 '<span>" + tagname + "</span>' 에 대한 상품이 존재하지 않습니다." +
						"</div></div></div>"
				);
			} else {
				makeProductPage(list, 1);
			}
		}
	});
}

function totalProduct() {
	makeProductPage(productList, 1)
	pagination();
}

//태그이름 영문이름으로 변경
function tagMatch(tagName) {
	switch (tagName) {
		case '한식' : return 'korean';
		case '일식' : return 'japanese';
		case '중식' : return 'chinese';
		case '양식' : return 'western';
		case '비건' : return 'vegan';
		case '고기만' : return 'meat';
		case '해산물' : return 'fish';
		case '스페인' : return 'spanish';
	}
}

function goProductPage(object) {
	let productId = '';
	
	if ($(object).attr('class') == 'p-img') {
		productId = $(object).parent().siblings('.hidden').text();
	} else {
		productId = $(object).parent().parent().siblings('.hidden').text();
	}
	location.href = 'goProductPage.do?p_id='+productId;
}
</script>

</head>
<body style="margin-top:150px;">
	<div id="header">
		<%@ include file="../common/header.jsp"%>
	</div>
	<!-- 본문 작성 -->
	<div class="fixed-Banner">
		<div class="like-title">내가 찜한 상품</div>
	</div>
	<div class="container" style="height: fit-content;">
		<!-- 베너 -->
		<div class="row" style="margin-top: 10px;">
			<div class="col-md-12 banner">
				<div class="banner-content">
					<div class="banner-text" style="font-size:larger;">우리의 밥상에 건강과 행복을 차려볼까요?</div>
				</div>
				<div class="search-box-narrow">
					<input type="text" class="search-narrow" id="search-bar" placeholder="키워드를 입력해주세요.">
				</div>
			</div>
		</div>
		<!-- 태그 -->
		<div class="row">
			<ul class="keyword-tag" style="margin: 0 auto; width: auto;">
				<li>
                    <span class="total-keyword" onclick="totalProduct()" style="color: red;">#키워드검색</span>
                </li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#양식</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#중식</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#일식</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#한식</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#비건</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#고기만</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#해산물</span></li>
				<li><span class="keyword" onclick="hashTagSearch(this)">#스페인</span></li>
			</ul>
		</div>
		<hr id="horizontal">
		<div class="product-container">
		<!-- 상품 리스트 -->
		</div>
		<div class="row" style="margin: 0 auto;">
			<!--페이징 구현-->
			<!-- 현재 페이지는 class='active' -->
			<div class="col-md-12" align="center">
				<div class="paging-section">
					<div class="pagination" align="center"></div>
				</div>
			</div>
		</div>
	</div>

	<div id="footer">
		<%@ include file="../common/footer.jsp"%>
	</div>
</body>
</html>