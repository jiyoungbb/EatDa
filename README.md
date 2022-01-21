<h1 align="center">프로젝트 : EatDa</h1>
<br>
<h4>구성원</h4>
<a href="https://github.com/kangactor123">강동희 👨🏻</a> | <a href="https://github.com/GongJeongHwa">공정화 👩🏻</a><br> 
<a href="https://github.com/noasued">남혜림 🧑🏻</a><br>
<a href="https://github.com/jiyoungbb">박지영(jiyoungbb) 👩🏻</a> | <a href="https://github.com/YEJIXD">윤예지 👩🏻</a>
<br>
<h2>1. 기획 의도 및 목표</h2>
<ul>
  <li>요리 재료를 살펴보고 구매하기도 귀찮을 만큼 바쁜 현대인들을 위한 플랫폼 제작</li>
  <li>간단 레시피와 식재료 밀키트 구독서비스를 제공하는 웹사이트 제작</li>
  <li>나만의 레시피를 올릴 수 있는 SNS 서비스(eatDaGram)를 제공하는 사용자 위주의 레시피 정보 사이트 제작</li>
  <li>많은 기능에 욕심내지 않고 기본에 충실한 웹사이트 제작</li>
</ul>
<br>
<h2>2. 사용 기술</h2>
<ul>
  <li>사용 언어 : Java(8), JavaScript(ES5), HTML5, CSS3 프레임워크 : Spring Legacy, MyBatis, Bootstrap</li>
  <li>라이브러리 : jQuery, Jackson</li>
  <li>서버 : Tomcat 9.0</li>
  <li>DB : Oracle(11g)</li>
  <li>협업툴 : Github</li>
  <li>개발툴 : Eclipse</li>
  <li>운영체제 : Window10, Mac</li>
</ul>
<br>
<h2>3. 페이지 및 기능</h2>
<ul>
  <li>공통 : 화면설계, DB설계, 기능구현</li>
  <li>
    <ul>
      <li>메인페이지 (Index 페이지) - 공정화, 강동희</li>
      <li>블로그 , 이벤트 페이지 , SUMMERNOTE API - 남혜림</li>
      <li>레시피 페이지 , SUMMERNOTE API - 공정화</li>
      <li>구독 , 관리자 페이지 , 이메일 발송 서비스 - 윤예지</li>
      <li>로그인 , 회원가입 , 마이페이지 , 카카오 주소찾기 API , 이메일 인증 서비스 - 박지영</li>
      <li>마켓 , 장바구니 , 결제 , 결제완료 , 음BTI 페이지, Iamport 결제 API , 카카오 주소찾기 API - 강동희</li>
    </ul>
  </li>
</ul>
<br>
<h2>4.설계</h2>
<h3>DB 설계</h3>
<img width:"1401" alt="erd" src="https://user-images.githubusercontent.com/78011677/150083165-b9a9798c-9077-47f6-b100-42b76252fc93.png">

<h3>블로그 ( eatDaGram )</h3>
<h4>1) 블로그 메인(리스트)</h4>
<img width="1402" alt="스크린샷 2022-01-19 오후 12 21 34" src="https://user-images.githubusercontent.com/78011677/150058384-8891e851-b894-471f-bafe-738ea3136700.png">
<h4>2) 블로그 상세 보기 및 댓글 보기</h4>
<img width="1401" alt="스크린샷 2022-01-19 오후 12 21 46" src="https://user-images.githubusercontent.com/78011677/150058391-4e88e106-ad90-438a-b68a-0d51b83c2d04.png">
<h4>3) 블로그 작성</h4>
<img width="1410" alt="스크린샷 2022-01-19 오후 12 21 59" src="https://user-images.githubusercontent.com/78011677/150058395-7ea90750-3b6b-4cba-9823-1357230c123c.png">
<h4>4) 블로그 수정</h4>
<img width="1401" alt="스크린샷 2022-01-19 오후 12 22 16" src="https://user-images.githubusercontent.com/78011677/150058401-557cb7c1-cb28-41fc-a927-d5c034501698.png">
<h4>5) 댓글 신고</h4>
<img width="1407" alt="스크린샷 2022-01-19 오후 12 22 27" src="https://user-images.githubusercontent.com/78011677/150058405-de13bc80-3ea2-423b-a82b-789bb97623a3.png">
<br>
<h3>이벤트</h3>
<h4>1) 이벤트 메인(갤러리 형태의 리스트)</h4>
<img width="1405" alt="스크린샷 2022-01-19 오후 12 22 42" src="https://user-images.githubusercontent.com/78011677/150058254-d258c46a-5817-4dce-9138-db25829af5d5.png">
<h4>2) 이벤트 상세 보기</h4>
<img width="1404" alt="스크린샷 2022-01-19 오후 12 22 50" src="https://user-images.githubusercontent.com/78011677/150058261-c80e3944-6595-4ff2-8948-c499d3d5d073.png">
<h4>3) 이벤트 작성</h4>
<img width="1405" alt="스크린샷 2022-01-19 오후 12 22 56" src="https://user-images.githubusercontent.com/78011677/150058270-b5ad3fd6-a039-4f74-a90f-572ed01dcf72.png">
<h4>4) 이벤트 수정</h4>
<img width="1405" alt="스크린샷 2022-01-19 오후 12 23 03" src="https://user-images.githubusercontent.com/78011677/150058280-a9fcf2dd-9ee9-4d0d-b2cd-127e253b93a9.png">

<br>

<h2>5. 결과</h2>
<ul>
  <li>의도대로 화면 구현 완료</li>
  <li>블로그 명칭을 블로그 --> eatDaGram(잇다그램)으로 변경</li>
  <li>summernote api 적용 완료(text 및 다중 image 서버에 업로드)</li>
</ul>
<h3><a href="https://youtu.be/NBUTcBKvKzs">블로그 ( eatDaGram ) 페이지 결과 화면 : YouTube Link</a></h3>
<h3><a href="https://youtu.be/afVzUJeX7eA">이벤트 페이지 결과 화면 : YouTube Link</a></h3>

<br>

<h2>6. 프로젝트를 하며 느낀점</h2>
<ul>
  <li>원활한 커뮤니케이션과 협업을 통해 문제해결 의지 상승 및 문제해결에 가까워졌을 때의 즐거움이 컸다.</li>
  <li>Spring Legacy를 배운 후 적용해볼 수 있어 유용한 시간이었다.</li>
  <li>전반적인 아키텍쳐를 표현하고 시작하지 않아 아쉬웠다.</li>
  <li>보안적인 측면까지 고려할 수 있었다면 좋았을 것 같다.</li>
  <li>깃 프로젝트 관리를 좀 더 깔끔하게 할 수 있도록 익혀야겠다.</li>
</ul>
