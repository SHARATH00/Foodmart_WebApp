--------------------------------------------------------
--  File created - Thursday-May-04-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ADMIN
--------------------------------------------------------

  CREATE TABLE "ADMIN" ("ID" NUMBER(10,0), "NAME" VARCHAR2(40), "EMAIL" VARCHAR2(40), "PASSWORD" VARCHAR2(100))
--------------------------------------------------------
--  DDL for Table CART
--------------------------------------------------------

  CREATE TABLE "CART" ("ID" NUMBER(10,0), "PRODUCT_ID" NUMBER(10,0), "QTY" NUMBER(10,0), "ADDED_DATE" DATE DEFAULT SYSDATE, "EMAIL" VARCHAR2(100))
--------------------------------------------------------
--  DDL for Table CATEGORY
--------------------------------------------------------

  CREATE TABLE "CATEGORY" ("ID" NUMBER(10,0), "NAME" VARCHAR2(40), "IMG" VARCHAR2(200))
--------------------------------------------------------
--  DDL for Table CHECKOUT_CART
--------------------------------------------------------

  CREATE TABLE "CHECKOUT_CART" ("ID" NUMBER(10,0), "PRODUCT_ID" NUMBER(10,0), "QTY" NUMBER(10,0) DEFAULT 1, "ORDER_DATE" DATE DEFAULT SYSDATE, "EMAIL" VARCHAR2(100), "ORDER_ID" NUMBER(10,0))
--------------------------------------------------------
--  DDL for Table PRODUCTS
--------------------------------------------------------

  CREATE TABLE "PRODUCTS" ("ID" NUMBER(10,0), "NAME" VARCHAR2(40), "ADDED_ON" DATE DEFAULT SYSDATE, "CAT_ID" NUMBER(10,0), "IMG" VARCHAR2(200), "QTY" NUMBER(10,0))
--------------------------------------------------------
--  DDL for Table SURVEY
--------------------------------------------------------

  CREATE TABLE "SURVEY" ("ID" NUMBER(10,0), "EMAIL" VARCHAR2(45), "ETHNICITY" VARCHAR2(45), "AGE" VARCHAR2(45), "CATEGORY" VARCHAR2(45), "EXPERIENCE" VARCHAR2(45), "LOCATION" VARCHAR2(45), "MEMBERS" VARCHAR2(45))
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "USERS" ("ID" NUMBER(10,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , "NAME" VARCHAR2(40), "EMAIL" VARCHAR2(40), "PASSWORD" VARCHAR2(100), "CREATED_AT" DATE DEFAULT SYSDATE, "LOGIN_TOKEN" CLOB, "OTP" VARCHAR2(40), "IS_EMAIL_VERIFIED" NUMBER(1,0), "OTP_REQUESTTIME" DATE, "FORGOT_OTP" VARCHAR2(40))
--------------------------------------------------------
--  DDL for Index PK_ADMIN
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ADMIN" ON "ADMIN" ("ID")
--------------------------------------------------------
--  DDL for Index FK_CART_PRODUCT_ID_IDX
--------------------------------------------------------

  CREATE INDEX "FK_CART_PRODUCT_ID_IDX" ON "CART" ("PRODUCT_ID")
--------------------------------------------------------
--  DDL for Index PK_CART
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_CART" ON "CART" ("ID")
--------------------------------------------------------
--  DDL for Index PK_CATEGORY
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_CATEGORY" ON "CATEGORY" ("ID")
--------------------------------------------------------
--  DDL for Index PK_CHECKOUT_CART
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_CHECKOUT_CART" ON "CHECKOUT_CART" ("ID")
--------------------------------------------------------
--  DDL for Index FK_CHECKOUT_CART_PRODUCT_ID_IDX
--------------------------------------------------------

  CREATE INDEX "FK_CHECKOUT_CART_PRODUCT_ID_IDX" ON "CHECKOUT_CART" ("PRODUCT_ID")
--------------------------------------------------------
--  DDL for Index PK_PRODUCTS
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_PRODUCTS" ON "PRODUCTS" ("ID")
--------------------------------------------------------
--  DDL for Index FK_PRODUCTS_CATEGORY_ID_IDX
--------------------------------------------------------

  CREATE INDEX "FK_PRODUCTS_CATEGORY_ID_IDX" ON "PRODUCTS" ("CAT_ID")
--------------------------------------------------------
--  DDL for Index PK_SURVEY
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_SURVEY" ON "SURVEY" ("ID")
--------------------------------------------------------
--  DDL for Index SYS_C0030654
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C0030654" ON "USERS" ("ID")
--------------------------------------------------------
--  DDL for Index UK_USERS_EMAIL
--------------------------------------------------------

  CREATE UNIQUE INDEX "UK_USERS_EMAIL" ON "USERS" ("EMAIL")
--------------------------------------------------------
--  DDL for Trigger CART_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CART_BRI" 
BEFORE INSERT ON CART 
FOR EACH ROW 
BEGIN
    SELECT NVL(MAX(ID),0)+1
    INTO :NEW.ID
    FROM CART;
END;
ALTER TRIGGER "CART_BRI" ENABLE
--------------------------------------------------------
--  DDL for Trigger CHECKOUT_CART_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CHECKOUT_CART_BRI" 
BEFORE INSERT ON CHECKOUT_CART 
FOR EACH ROW 
BEGIN
    IF NVL(:NEW.ID,0) = 0 THEN
        SELECT NVL(MAX(ID),0)+1
        INTO :NEW.ID
        FROM CHECKOUT_CART;
    END IF;
END;
ALTER TRIGGER "CHECKOUT_CART_BRI" ENABLE
--------------------------------------------------------
--  DDL for Trigger CHECKOUT_CART_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CHECKOUT_CART_ARI" 
AFTER INSERT ON CHECKOUT_CART 
FOR EACH ROW 
BEGIN
    UPDATE PRODUCTS SET QTY = NVL(QTY,0) + NVL(:NEW.QTY,0)
    WHERE ID =:NEW.PRODUCT_ID;
END;
ALTER TRIGGER "CHECKOUT_CART_ARI" ENABLE
--------------------------------------------------------
--  DDL for Trigger PRODUCTS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PRODUCTS_BRI" 
BEFORE INSERT ON PRODUCTS
FOR EACH ROW 
BEGIN
    SELECT NVL(MAX(ID),0)+1
    INTO :NEW.ID
    FROM PRODUCTS;
END;
ALTER TRIGGER "PRODUCTS_BRI" ENABLE
--------------------------------------------------------
--  DDL for Trigger SURVEY_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "SURVEY_BRI" 
BEFORE INSERT ON SURVEY
FOR EACH ROW 
BEGIN
    SELECT NVL(MAX(ID),0)+1
    INTO :NEW.ID
    FROM SURVEY;
END;
ALTER TRIGGER "SURVEY_BRI" ENABLE
--------------------------------------------------------
--  Constraints for Table ADMIN
--------------------------------------------------------

  ALTER TABLE "ADMIN" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "ADMIN" ADD CONSTRAINT "PK_ADMIN" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table CART
--------------------------------------------------------

  ALTER TABLE "CART" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "CART" ADD CONSTRAINT "PK_CART" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table CATEGORY
--------------------------------------------------------

  ALTER TABLE "CATEGORY" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "CATEGORY" MODIFY ("NAME" NOT NULL ENABLE)
  ALTER TABLE "CATEGORY" ADD CONSTRAINT "PK_CATEGORY" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table CHECKOUT_CART
--------------------------------------------------------

  ALTER TABLE "CHECKOUT_CART" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "CHECKOUT_CART" ADD CONSTRAINT "PK_CHECKOUT_CART" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PRODUCTS
--------------------------------------------------------

  ALTER TABLE "PRODUCTS" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "PRODUCTS" MODIFY ("NAME" NOT NULL ENABLE)
  ALTER TABLE "PRODUCTS" ADD CONSTRAINT "PK_PRODUCTS" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table SURVEY
--------------------------------------------------------

  ALTER TABLE "SURVEY" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "SURVEY" ADD CONSTRAINT "PK_SURVEY" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table USERS
--------------------------------------------------------

  ALTER TABLE "USERS" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "USERS" MODIFY ("NAME" NOT NULL ENABLE)
  ALTER TABLE "USERS" MODIFY ("EMAIL" NOT NULL ENABLE)
  ALTER TABLE "USERS" MODIFY ("PASSWORD" NOT NULL ENABLE)
  ALTER TABLE "USERS" ADD PRIMARY KEY ("ID") USING INDEX  ENABLE
  ALTER TABLE "USERS" ADD CONSTRAINT "UK_USERS_EMAIL" UNIQUE ("EMAIL") USING INDEX  ENABLE
--------------------------------------------------------
--  Ref Constraints for Table CART
--------------------------------------------------------

  ALTER TABLE "CART" ADD CONSTRAINT "FK_CART_PRODUCT_ID" FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCTS" ("ID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table CHECKOUT_CART
--------------------------------------------------------

  ALTER TABLE "CHECKOUT_CART" ADD CONSTRAINT "FK_CHECKOUT_CART_PRODUCT_ID" FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCTS" ("ID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PRODUCTS
--------------------------------------------------------

  ALTER TABLE "PRODUCTS" ADD CONSTRAINT "FK_PRODUCTS_CATEGORY_ID" FOREIGN KEY ("CAT_ID") REFERENCES "CATEGORY" ("ID") ENABLE
