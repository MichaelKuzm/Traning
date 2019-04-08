CREATE TABLE IF NOT EXISTS Organization (
    id         integer                  COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT,
    version    integer         NOT NULL COMMENT 'Служебное поле hibernate',
    name       varchar(50)     NOT NULL COMMENT 'Наименование',
    full_name  varchar(200)    NOT NULL COMMENT 'Полное наименование',
    inn        varchar(12)     NOT NULL COMMENT 'ИНН организации',
    kpp        varchar(9)      NOT NULL COMMENT 'КПП организации',
    is_active  integer         NOT NULL COMMENT 'Флаг активности'
);
COMMENT ON TABLE Organization IS 'Организация';


CREATE TABLE IF NOT EXISTS Office (
    id         integer                  COMMENT 'Уникальный идентификатор' PRIMARY KEY AUTO_INCREMENT,
    version    integer         NOT NULL COMMENT 'Служебное поле hibernate',
    org_id     integer         NOT NULL COMMENT 'Код организации',
    address    varchar(1000)   NOT NULL COMMENT 'Адрес офиса организации',
    phone      varchar(20)     NOT NULL COMMENT 'Телефон офиса организации',
    is_active  integer         NOT NULL COMMENT 'Флаг активности'
);
COMMENT ON TABLE Office IS 'Офис';

CREATE INDEX IF NOT EXISTS IX_Office_org_id ON Office (org_id);
ALTER TABLE Office ADD FOREIGN KEY (org_id) REFERENCES Organization(id);


CREATE TABLE IF NOT EXISTS User (
    id               integer                  COMMENT 'Уникальный идентификатор ' PRIMARY KEY AUTO_INCREMENT,
    office_id        integer                  COMMENT 'Id Office', 
    first_name       varchar(50)     NOT NULL COMMENT 'Имя клиента',
    second_name      varchar(50)     NOT NULL COMMENT 'Фамилия  клиента',
    middle_name      varchar(50)     NOT NULL COMMENT 'Отчество клиента',
    position         varchar(20)     NOT NULL COMMENT 'Позиция клиента',
    phone            varchar(20)     NOT NULL COMMENT 'Телефон клиента',
    doc_code         varchar(20)     NOT NULL COMMENT 'Наименование документа',
    doc_number       varchar(20)     NOT NULL COMMENT 'Номер документа',
    doc_date         date            NOT NULL COMMENT 'Дата выдачи документа',
    citizenship_code varchar(20)     NOT NULL COMMENT 'Код страны',
    is_identified    varchar(20)     NOT NULL COMMENT ''
);
COMMENT ON TABLE User IS 'Клиент';


CREATE TABLE IF NOT EXISTS Doc_Type (
    code       integer                  COMMENT 'Уникальный идентификатор документа' PRIMARY KEY AUTO_INCREMENT,
    name       varchar(50)     NOT NULL COMMENT 'Наименование документа'
);
COMMENT ON TABLE Doc_Type IS 'Типы документов';


CREATE TABLE IF NOT EXISTS Country (
    code       integer                  COMMENT 'Уникальный идентификатор страны' PRIMARY KEY AUTO_INCREMENT,
    name       varchar(50)     NOT NULL COMMENT 'Наименование страны'
);
COMMENT ON TABLE Country IS 'Типы документов';


CREATE INDEX IF NOT EXISTS IX_User_doc_code ON User (doc_code);
ALTER TABLE User ADD FOREIGN KEY (doc_code) REFERENCES Doc_Type(code);

CREATE INDEX IF NOT EXISTS IX_User_citizenship_code ON User (citizenship_code);
ALTER TABLE User ADD FOREIGN KEY (citizenship_code) REFERENCES Country(code);

