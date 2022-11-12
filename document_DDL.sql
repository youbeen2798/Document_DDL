CREATE table cerificate_kind(
	id int,
    certificate_name nvarchar(100) NOT NULL,
	PRIMARY KEY(id)
    );
    
CREATE table certificate(
	confirmation_number char(16),
    petitoner bigint NOT NULL,
    kind_id int NOT NULL,
    issue_date date NOT NULL,
    PRIMARY KEY(confirmation_number),
    CONSTRAINT refer_certificate_id FOREIGN KEY(kind_id) REFERENCES certificate_kind(id)
);
    
    