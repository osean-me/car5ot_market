--------------계정 생성--------------
CREATE USER C##CARROT IDENTIFIED BY C##CARROT;
GRANT CONNECT, RESOURCE, CREATE VIEW, UNLIMITED TABLESPACE TO C##CARROT;

-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------

-- 주소 테이블 / 기본키 시퀀스 생성
CREATE TABLE ADDRESS (
ADDR_NO NUMBER PRIMARY KEY,
ADDR_STATE VARCHAR2(30) NOT NULL,
ADDR_CITY VARCHAR2(30) NOT NULL,
ADDR_BASE VARCHAR2(30) NOT NULL
);
CREATE SEQUENCE ADDR_SEQ NOCACHE;


-- 회원 테이블 / 기본키 시퀀스 생성
CREATE TABLE MEMBER (
MEMBER_NO NUMBER PRIMARY KEY,
MEMBER_ID VARCHAR2(60) NOT NULL UNIQUE,
MEMBER_PW VARCHAR2(30) NOT NULL,
MEMBER_ADDR_NO REFERENCES ADDRESS(ADDR_NO) ON DELETE SET NULL,
MEMBER_NICK VARCHAR2(30) NOT NULL,
MEMBER_PHONE VARCHAR2(11) NOT NULL UNIQUE,
MEMBER_AUTH VARCHAR2(9) DEFAULT '일반' CHECK(MEMBER_AUTH IN('일반','업체','관리자')),
MEMBER_JOIN DATE DEFAULT SYSDATE NOT NULL,
MEMBER_LOGIN DATE
);
CREATE SEQUENCE MEMBER_SEQ NOCACHE;

-- 회원 프로필 이미지 테이블 / 기본키 시퀀스 생성
CREATE TABLE PROFILE_IMG (
MEMBER_IMG_NO NUMBER PRIMARY KEY,
MEMBER_NO NUMBER REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE,
MEMBER_IMG_NAME VARCHAR2(256) NOT NULL,
MEMBER_IMG_TYPE VARCHAR2(10) NOT NULL,
MEMBER_IMG_SIZE NUMBER NOT NULL CHECK(MEMBER_IMG_SIZE > 0)
);
CREATE SEQUENCE PROFILE_IMG_SEQ NOCACHE;


-- 자기 소개 테이블
CREATE TABLE MEMBER_INTRO (
MEMBER_NO NOT NULL REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE,
INTRO VARCHAR2(4000)
);

-- 찜 목록 테이블
CREATE TABLE POST_LIKE(
MEMBER_NO REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE,
BOARD_NO REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE,
POST_NO NUMBER NOT NULL
);

-- 회원별 매너지수 카운트 테이블
CREATE TABLE MEMBER_MANNER(
MEMBER_NO REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE,
MANNER_COUNT NUMBER DEFAULT 50
);


-- 좋아요 / 싫어요 누른 리스트 테이블
CREATE TABLE MEMBER_MANNER_LIST(
THIS_MEMBER_NO REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE,
PUSH_MEMBER_NO REFERENCES MEMBER(MEMBER_NO) 
);

-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
--게시판 테이블--
CREATE TABLE Board(
board_no NUMBER PRIMARY KEY,
board_title varchar2(20) NOT NULL,
post_table_name varchar2(20) NOT null
);
CREATE SEQUENCE board_seq nocache;

--홍보 게시판--
CREATE TABLE promotion_board(
promotion_cate_num NUMBER PRIMARY KEY,
promotion_cate_title varchar2(100) NOT NULL,
board_no REFERENCES board(board_no) ON DELETE cascade
);
CREATE SEQUENCE promotion_board_seq nocache;

--중고 게시판--
CREATE TABLE used_board(
used_cate_num NUMBER PRIMARY KEY,
used_cate_title varchar2(100) NOT NULL,
board_no REFERENCES board(board_no) ON DELETE cascade
);
CREATE SEQUENCE used_board_seq nocache;

--동네 홍보 글--
CREATE TABLE promotion_post(
post_no NUMBER PRIMARY KEY,
post_title varchar2(120) NOT NULL,
post_content varchar2(4000) NOT NULL,
post_price NUMBER NOT NULL,
post_date DATE DEFAULT sysdate NOT NULL,
post_phone varchar2(11) NOT NULL UNIQUE,
post_view NUMBER DEFAULT 0 NOT NULL,
post_like NUMBER DEFAULT 0 NOT NULL,
promotion_cate_num REFERENCES promotion_board(promotion_cate_num) ON DELETE CASCADE,
member_no REFERENCES member(member_no) ON DELETE set NULL,
MEMBER_IMG_NO REFERENCES PROFILE_IMG(MEMBER_IMG_NO) ON DELETE set NULL,
addr_no REFERENCES address(addr_no) ON DELETE SET null,
board_no REFERENCES board(board_no) ON DELETE cascade
);
CREATE SEQUENCE promotion_post_seq nocache;

--중고거래 글--
CREATE TABLE used_post(
post_no NUMBER PRIMARY KEY,
post_title varchar2(120) NOT NULL,
post_content varchar2(4000) NOT NULL,
post_price NUMBER NOT NULL,
post_date DATE DEFAULT sysdate NOT NULL,
post_view NUMBER DEFAULT 0 NOT NULL,
post_like NUMBER DEFAULT 0 NOT NULL,
used_cate_num REFERENCES used_board(used_cate_num) ON DELETE CASCADE,
member_no REFERENCES member(member_no) ON DELETE set NULL,
MEMBER_IMG_NO REFERENCES PROFILE_IMG(MEMBER_IMG_NO) ON DELETE set NULL,
addr_no REFERENCES address(addr_no) ON DELETE SET null,
post_state varchar(12) check(post_state in('판매중','예약중','거래완료')),
board_no REFERENCES board(board_no) ON DELETE cascade
);
CREATE SEQUENCE used_post_seq nocache;


-- 이미지 테이블 추가 

CREATE TABLE used_post_img (
post_IMG_NO NUMBER PRIMARY KEY,
post_no REFERENCES used_post(post_no) ON DELETE set NULL,
post_IMG_NAME VARCHAR2(256) NOT NULL,
post_IMG_TYPE VARCHAR2(10) NOT NULL,
post_IMG_SIZE NUMBER NOT NULL CHECK(post_IMG_SIZE > 0)
);
CREATE TABLE promotion_post_img (
post_IMG_NO NUMBER PRIMARY KEY,
post_no REFERENCES promotion_post(post_no) ON DELETE set NULL,
post_IMG_NAME VARCHAR2(256) NOT NULL,
post_IMG_TYPE VARCHAR2(10) NOT NULL,
post_IMG_SIZE NUMBER NOT NULL CHECK(post_IMG_SIZE > 0)
);

--게시글 번호 sequence--
CREATE SEQUENCE post_seq nocache;

-- 댓글 테이블--

-- 중고 거래 댓글 테이블 / 시퀀스 
CREATE TABLE USED_POST_REPLY (
REPLY_NO NUMBER PRIMARY KEY,
MEMBER_NO REFERENCES MEMBER(MEMBER_NO) ON DELETE SET NULL,
POST_NO REFERENCES USED_POST(POST_NO) ON DELETE CASCADE,
REPLY_CONTENT VARCHAR2(350) NOT NULL,
SUPER_NO REFERENCES USED_POST_REPLY(REPLY_NO) ON DELETE CASCADE,
GROUP_NO NUMBER NOT NULL,
DEPTH NUMBER NOT NULL,
REPLY_DATE DATE DEFAULT SYSDATE NOT NULL
);
CREATE SEQUENCE USED_POST_REPLY_SEQ NOCACHE;

-- 홍보 거래 댓글 테이블 / 시퀀스 
CREATE TABLE PROMOTION_POST_REPLY (
REPLY_NO NUMBER PRIMARY KEY,
MEMBER_NO REFERENCES MEMBER(MEMBER_NO) ON DELETE SET NULL,
POST_NO REFERENCES  PROMOTION_POST(POST_NO) ON DELETE CASCADE,
REPLY_CONTENT VARCHAR2(350) NOT NULL,
SUPER_NO REFERENCES PROMOTION_POST_REPLY(REPLY_NO) ON DELETE CASCADE,
GROUP_NO NUMBER NOT NULL,
DEPTH NUMBER NOT NULL,
REPLY_DATE DATE DEFAULT SYSDATE NOT NULL
);
CREATE SEQUENCE PROMOTION_POST_REPLY_SEQ NOCACHE;

-----------------------------------------------------------------------------------------------------------
--데이터 넣기
-----------------------------------------------------------------------------------------------------------
-- 게시판 데이터 삽입--
INSERT INTO Board values(1,'USED_BOARD','USED_POST');
INSERT INTO Board values(2,'PROMOTION_BOARD','PROMOTION_POST');

-- 홍보 게시판 카테고리 데이터 삽입
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'중고차/오토바이',2);
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'동네 구인구직',2);
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'부동산',2);
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'농수산물',2);
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'지역업체',2);
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'과외/클래스 모집',2);
INSERT INTO promotion_board VALUES(promotion_board_seq.nextval,'전시/공연',2);
SELECT * FROM PROMOTION_BOARD;

-- 중고거래 게시판 카테고리 데이터 삽입
INSERT INTO used_board values(used_board_seq.nextval,'디지털/가전',1);
INSERT INTO used_board values(used_board_seq.nextval,'가구/인테리어',1);
INSERT INTO used_board values(used_board_seq.nextval,'유아동/유아도서',1);
INSERT INTO used_board values(used_board_seq.nextval,'생활/가공식품',1);
INSERT INTO used_board values(used_board_seq.nextval,'스포츠/레저',1);
INSERT INTO used_board values(used_board_seq.nextval,'여성/잡화',1);
INSERT INTO used_board values(used_board_seq.nextval,'여성 의류',1);
INSERT INTO used_board values(used_board_seq.nextval,'남성패션/잡화',1);
INSERT INTO used_board values(used_board_seq.nextval,'게임/취미',1);
INSERT INTO used_board values(used_board_seq.nextval,'뷰티/미용',1);
INSERT INTO used_board values(used_board_seq.nextval,'반려동물',1);
INSERT INTO used_board values(used_board_seq.nextval,'도서/티켓/음반',1);
INSERT INTO used_board values(used_board_seq.nextval,'기타',1);
INSERT INTO used_board values(used_board_seq.nextval,'삽니다',1);