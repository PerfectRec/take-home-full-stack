-- create a function which will maintain the `updated_at` column of any table
CREATE FUNCTION trigger_set_timestamp ()
  RETURNS TRIGGER
  AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- create the app_user table
CREATE TABLE app_user (
  id uuid DEFAULT gen_random_uuid (),
  external_id varchar(255) NOT NULL,
  email varchar(255) NOT NULL UNIQUE,
  fname varchar(255) DEFAULT NULL,
  lname varchar(255) DEFAULT NULL,
  display_name varchar(255) NOT NULL,
  image varchar(255) DEFAULT NULL,
  is_active boolean NOT NULL,
  role varchar(255) NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

-- create indices on the app_user table
CREATE INDEX app_user_created_at_idx ON app_user (created_at);

-- ensure that app_user.updated_at is maintained automatically
CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON app_user
  FOR EACH ROW
  EXECUTE PROCEDURE trigger_set_timestamp ();

-- Create table product_category
CREATE TABLE product_category (
  id uuid DEFAULT gen_random_uuid (),
  name varchar(255) NOT NULL,
  label varchar(255) NOT NULL,
  spreadsheet_id varchar(255) NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

-- Create table product
CREATE TABLE product (
  id uuid DEFAULT gen_random_uuid (),
  label varchar(255) NOT NULL,
  ratings jsonb NOT NULL,
  facts jsonb NOT NULL,
  product_category_id uuid NULL,
  image varchar(255) DEFAULT NULL,
  is_active boolean NOT NULL DEFAULT TRUE,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  CONSTRAINT fk_category FOREIGN KEY (product_category_id) REFERENCES product_category (id)
);

CREATE INDEX product_ratings_idx ON product USING GIN (ratings);

CREATE INDEX product_facts_idx ON product USING GIN (facts);

CREATE INDEX product_product_category_idx ON product (product_category_id);

CREATE INDEX product_is_active_idx ON product (is_active);

CREATE TABLE trait (
  id uuid DEFAULT gen_random_uuid (),
  label varchar(255) NOT NULL,
  product_category_id uuid NULL,
  default_weight float NULL,
  is_active boolean NOT NULL DEFAULT TRUE,
  PRIMARY KEY (id),
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT fk_category FOREIGN KEY (product_category_id) REFERENCES product_category (id)
);

CREATE INDEX trait_product_category_idx ON trait (product_category_id);

CREATE INDEX trait_is_active_idx ON trait (is_active);

-- Create table for questions
CREATE TYPE question_type AS ENUM (
  'multiple_choice'
);

CREATE TABLE question (
  id uuid DEFAULT gen_random_uuid (),
  type question_type,
  weight float NULL,
  main_text varchar(255) NOT NULL,
  product_category_id uuid NOT NULL,
  is_active boolean NOT NULL DEFAULT TRUE,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  CONSTRAINT fk_category FOREIGN KEY (product_category_id) REFERENCES product_category (id)
);

CREATE INDEX question_product_category_idx ON question (product_category_id);

CREATE INDEX question_is_active_idx ON question (is_active);

CREATE INDEX question_weight_idx ON question (weight);

-- Create table for answer.
CREATE TABLE answer (
  id uuid DEFAULT gen_random_uuid (),
  question_id uuid NOT NULL,
  main_text varchar(255) NULL,
  trait_modifiers jsonb NOT NULL,
  is_active boolean NOT NULL DEFAULT TRUE,
  created_at timestamptz NOT NULL DEFAULT now(),
  product_category_id uuid NOT NULL,
  weight float NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_question FOREIGN KEY (question_id) REFERENCES question (id)
);

CREATE INDEX answer_question_id_idx ON answer (question_id);

CREATE INDEX answer_is_active_idx ON answer (is_active);

-- Create table for session
CREATE TABLE session (
  id uuid DEFAULT gen_random_uuid (),
  created_at timestamptz NOT NULL DEFAULT now(),
  last_active timestamptz NOT NULL DEFAULT now(),
  user_id uuid NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES app_user (id)
);

CREATE INDEX session_user_id_idx ON session (user_id);

CREATE INDEX session_created_at_idx ON session (created_at);

CREATE INDEX session_last_active_idx ON session (last_active);

-- Create table for response set.
CREATE TABLE response_set (
  id uuid DEFAULT gen_random_uuid (),
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

-- Create table for response
CREATE TABLE response (
  id uuid DEFAULT gen_random_uuid (),
  value varchar(255) NULL,
  question_id uuid NOT NULL,
  answer_id uuid NULL,
  session_id uuid NOT NULL,
  user_id uuid NULL,
  response_set_id uuid NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  CONSTRAINT fk_question FOREIGN KEY (question_id) REFERENCES question (id),
  CONSTRAINT fk_answer FOREIGN KEY (answer_id) REFERENCES answer (id),
  CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES session (id),
  CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES app_user (id),
  CONSTRAINT fk_response_set FOREIGN KEY (response_set_id) REFERENCES response_set (id)
);

CREATE INDEX response_user_id_idx ON response (user_id);

CREATE INDEX response_session_id_idx ON response (session_id);

CREATE INDEX response_question_id_idx ON response (question_id);

CREATE INDEX response_value_idx ON response (value);

CREATE INDEX response_answer_id_idx ON response (answer_id);

