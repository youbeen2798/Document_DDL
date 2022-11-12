# 증명서 종류 테이블
CREATE table cerificate_kind(
	id INT AUTO_INCREMENT,
    certificate_name NVARCHAR(100) NOT NULL,
	PRIMARY KEY(id)
    );
    
# 증명서 테이블
CREATE table certificate(
	# 증명서 확인번호
	confirmation_number CHAR(16),
    # 신청인
    petitoner BIGINT NOT NULL,
    # 증명서 종류 - certificate_kind 참조
    kind_id INT NOT NULL,
    # 발급일
    issue_date DATE NOT NULL,
    PRIMARY KEY(confirmation_number),
    CONSTRAINT refer_certificate_id FOREIGN KEY(kind_id) REFERENCES certificate_kind(id)
);

# 주소 테이블
CREATE TABLE location (
	# 주소 아이디
	id INT AUTO_INCREMENT,
    # 구분
    classification NVARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

# 신고인 자격 테이블
CREATE TABLE declarant_qualification (
	id INT AUTO_INCREMENT,
    qualification_name NVARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

# 주소 테이블
CREATE TABLE address (
	id BIGINT AUTO_INCREMENT,
    detailed_address NVARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

# 사람 테이블
CREATE TABLE person (
	id BIGINT AUTO_INCREMENT,
    name NVARCHAR(100) NOT NULL,
    resident_registration_number CHAR(300) UNIQUE NOT NULL,
    gender NCHAR(1) NOT NULL,
    birthday DATE NOT NULL,
    spouse BIGINT,
    PRIMARY KEY (id),
    CONSTRAINT refer_spouse_id FOREIGN KEY (spouse) REFERENCES person(id)
);


-- # 출생신고서 세부 정보 테이블
-- CREATE TABLE birth_detail (
-- 	id BIGINT,
--     birth_datetime DATETIME NOT NULL,
--     location_id INT NOT NULL,
--     declarant_id BIGINT NOT NULL,
--     report_date DATE NOT NULL,
--     PRIMARY KEY (id) REFERENCES 

    
    