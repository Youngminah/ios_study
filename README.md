# iOS개발을 위한 연습용 앱

패스트캠퍼스 iOS과정.

<br></br>
<br></br>


# 🏷 프로젝트 미리보기

###   1.  원피스 현상금 앱
[폴더바로가기](https://github.com/Youngminah/ios_study/tree/master/BountyList)

**`BountyList`: iOS CollectionView**

→ 원피스 현상금 갤러리를 컬렉션 뷰로 구성.

→ 현상금 사진으 눌렀을 때, 애니메이션 적용.

#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/ios_study/blob/master/gif/onepiece.mov.gif" title="auto gif" width="30%"/>


<br></br>

-------------------------------------------------------
<br></br>

### 🎼  2. 애플뮤직 스타일 앱

[폴더바로가기](https://github.com/Youngminah/ios_study/tree/master/AppleMusicStApp)

**`AppleMusicStApp`: iOS AVPlayer 다룬 앱** 

→ Collection View로 음악들을 띄우고, Collection Header에는 오늘의 픽으로 랜덤 뮤직이 뜨게한다. 

→ AVFoundation을 이용하여 음악을 재생, 일시정지 등을 구현.

→ 플레이어는 하나로, 싱글톤 디자인 패턴을 이용하여 구현.

→ 다크모드에 대비할 수 있도로 구현.

→ TimeObserver를 프로그래스바랑 매치시켜 중간에 커서를 둘 때, 알맞은 음악 위치르 재생 할 수 있도록 구성.



#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/ios_study/blob/master/gif/applemusicst.mov.gif" title="music gif" width="30%"/>



<br></br>

-------------------------------------------------------
<br></br>


### 📽  3. 넷플릭스 스타일 앱
[폴더바로가기](https://github.com/Youngminah/ios_study/tree/master/MyNetflix)

**`MyNetflix`: iOS 네스티드 뷰 연습 앱**

→ 컨테이너 뷰로 네스티드 뷰 구성.

→ Kingfisher로 이미지 가져오기.



#### ▶︎ 실행화면
<img src="https://github.com/Youngminah/ios_study/blob/master/gif/netflix.mov.gif" title="phone book gif" width="30%"/>


<br></br>

-------------------------------------------------------
<br></br>

### 📷 카메라 앱
[폴더바로가기](https://github.com/Youngminah/ios_study/tree/master/FullScreenCamera)

**`FullScreenCamera`: iOS Photo** 

→ 풀스크린 카메라 전면, 후면 카메라로 사진 찍고, 사진첩 저장까지 구현




#### ▶︎ 실행화면 (실기기 테스트)
<img src="https://github.com/Youngminah/ios_study/blob/master/gif/카메라앱.mov.gif" alt="under the sea gif" title="Databay showcase gif" width="30%"/>



<br></br>



-------------------------------------------------------
<br></br>

### 🚀  5. 파이어베이스 연습
[폴더바로가기](https://github.com/Youngminah/ios_study/tree/master/Firebase101)

**`Firebase101`: 파이어베이스 연습용 앱 ** 

→ 파이어베이스로 서버를 대신하여 CRUD연습







<br></br>

<br></br>



-------------------------------------------------------
<br></br>



## :memo: Commit Convention

```
  - Init : 초기화
  - Add : 파일 추가
  - Rename : 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 
  - Remove : 파일을 삭제하는 작업만 수행한 경우
  - Feat : 기능 추가
  - Delete : 기능 삭제
  - Update : 기능 수정
  - Fix : 버그 수정
  - Refactor: 리팩토링
  - Style : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음)
  - Docs : 문서 (문서 추가(Add), 수정, 삭제)
  - Chore : 기타 변경사항 (빌드 스크립트 수정, 에셋 추가 등)
  - Design : 사용자 UI 디자인 변경 
  - !BREAKING CHANGE : 커다란 API 변경의 경우 !
  - HOTFIX : 급하게 치명적인 버그를 고쳐야하는 경우
  - Comment : 필요한 주석 추가 및 변경   
  - Test : 테스트 추가, 테스트 리팩토링(프로덕션 코드 변경 X) 
  - Chore : 빌드 태스트 업데이트, 패키지 매니저를 설정하는 경우(프로덕션 코드 변경 X) 

```

<br></br>
