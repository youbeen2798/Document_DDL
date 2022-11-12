# 사람 테이블
CREATE TABLE person (
	id BIGINT AUTO_INCREMENT,
    #이름
    name NVARCHAR(100) NOT NULL,
    #주민 등록 번호
    resident_registration_number TEXT NOT NULL,
    #성별
    gender NCHAR(1) NOT NULL,
    #생일
    birthday DATE NOT NULL,
    #배우자
    spouse BIGINT,
    PRIMARY KEY (id),
    CONSTRAINT person_refer_spouse_id FOREIGN KEY (spouse) REFERENCES person(id)
);

# 부모 테이블
CREATE TABLE parents (
	# 본인 고유 아이디
	id BIGINT,
    # 어머니 고유 아이디
    mother_id BIGINT,
    # 아버지 고유 아이디
    father_id BIGINT,
    PRIMARY KEY (id),
    CONSTRAINT parents_refer_id FOREIGN KEY (id) REFERENCES person(id),
	CONSTRAINT parents_refer_mother_id FOREIGN KEY (mother_id) REFERENCES person(id),
	CONSTRAINT parents_refer_father_id FOREIGN KEY (father_id) REFERENCES person(id)
);

# 주소 테이블
CREATE TABLE address (
	id BIGINT AUTO_INCREMENT,
    #상세 주소
    detailed_address NVARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

#사람 주소 테이블
CREATE TABLE person_address(
	id BIGINT AUTO_INCREMENT,
    #사람 고유 아이디
    person_id BIGINT NOT NULL,
   #주소 고유 아이디
    address_id BIGINT NOT NULL,
    #신고일
    report_date DATE NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT person_address_refer_person_id FOREIGN KEY(person_id) REFERENCES person(id),
    CONSTRAINT person_address_refer_address_id FOREIGN KEY(address_id) REFERENCES address(id)
); 

# 장소 테이블
CREATE TABLE location (
	# 장소 아이디
	id INT AUTO_INCREMENT,
    # 구분
    classification NVARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

# 증명서 종류 테이블
CREATE table certificate_kind(
	id INT AUTO_INCREMENT,
    certificate_name NVARCHAR(100) NOT NULL,
	PRIMARY KEY(id)
);
    
# 증명서 테이블
CREATE table certificate(
	# 증명서 확인번호
	confirmation_number CHAR(16),
    # 신청인
    petitioner BIGINT NOT NULL,
    # 증명서 종류 - certificate_kind 참조
    kind_id INT NOT NULL,
    # 발급일
    issue_date DATE NOT NULL,
    PRIMARY KEY(confirmation_number),
	CONSTRAINT certificate_refer_person_id FOREIGN KEY(petitioner) REFERENCES person(id),
    CONSTRAINT certificate_refer_certificate_id FOREIGN KEY(kind_id) REFERENCES certificate_kind(id)
);

# 신고인 자격 테이블
CREATE TABLE declarant_qualification (
	id INT AUTO_INCREMENT,
    # 자격 이름
    qualification_name NVARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

#신고인 테이블
CREATE TABLE declarant(
	id BIGINT AUTO_INCREMENT,
    #신고자 고유 아이디
    person_id BIGINT NOT NULL,
    #신고자 자격 - refer
    qualification INT NOT NULL,
    #신고인 이메일
    email VARCHAR(50),
    #신고인 전화번호
    phone_number VARCHAR(20),
    PRIMARY KEY(id),
    CONSTRAINT declarant_refer_person_id FOREIGN KEY(person_id) REFERENCES person(id),
	CONSTRAINT declarant_refer_declarant_qualification_id FOREIGN KEY(qualification) REFERENCES declarant_qualification(id)
);

# 출생신고서 세부 정보 테이블
CREATE TABLE birth_detail (
	id BIGINT,
    #출생 날짜 및 시간
    birth_datetime DATETIME NOT NULL,
    #태어난 장소 - locaiton.id 참조
    location_id INT NOT NULL,
    #신고인 - declarant.id 참조
    declarant_id BIGINT NOT NULL,
    #신고 날짜 
    report_date DATE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT birth_detail_refer_person_id FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT birth_detail_refer_location_id FOREIGN KEY(location_id) REFERENCES location(id),
    CONSTRAINT birth_detail_refer_declarant_id FOREIGN KEY(declarant_id) REFERENCES declarant(id)
);

# 사망신고서 세부 정보 테이블
CREATE TABLE death_detail(
	id BIGINT,
    #사망 날짜 및 시간
    death_datetime DATETIME NOT NULL,
    #사망 장소 아이디
    location_id INT NOT NULL,
    #사망 상세 주소
    death_location NVARCHAR(100) NOT NULL,
    #신고자 고유 아이디
    declarant_id BIGINT NOT NULL,
    #신고일
    report_date DATE NOT NULL,
    PRIMARY KEY(id),
	CONSTRAINT death_detail_refer_person_id FOREIGN KEY(id) REFERENCES person(id),
    CONSTRAINT death_detail_refer_location_id FOREIGN KEY(location_id) REFERENCES location(id),
	CONSTRAINT death_detail_refer_declarant_id FOREIGN KEY(declarant_id) REFERENCES declarant(id)
);

# 세대 테이블
CREATE TABLE household (
	# 세대 고유 아이디
	id BIGINT AUTO_INCREMENT,
    # 세대주 고유 아이디
    head_of_household BIGINT NOT NULL,
    # 세대 구성 사유
    reason_of_composition NVARCHAR(100) NOT NULL,
    # 세대 구성 일자
    date_of_composition DATE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT household_refer_person_id FOREIGN KEY(head_of_household) REFERENCES person(id)
);

# 사람 세대 테이블
CREATE TABLE person_household (
	# 사람 세대 고유 아이디
	id BIGINT AUTO_INCREMENT,
    # 사람 고유 아이디
    person_id BIGINT NOT NULL,
    # 세대 고유 아이디
    household_id BIGINT NOT NULL,
    # 신고일
    report_date DATE NOT NULL,
    # 변동 사유
    reason_of_change NVARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT person_household_refer_person_id FOREIGN KEY(person_id) REFERENCES person(id),
    CONSTRAINT person_household_refer_household_id FOREIGN KEY(household_id) REFERENCES household(id)
);
    
    

    
    