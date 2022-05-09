-- DATA
-- Product category
INSERT INTO product_category (id, label, name, spreadsheet_id)
  VALUES ('ded315c4-2dc0-4b96-88a3-472cba1cdf75', 'Laptops', 'laptops', '1Vr-KxbsRosmYZ-3Mt4q00i9yfe2IxW-hvwfVL5wyLBM');

-- Traits
INSERT INTO trait (id, label, product_category_id, default_weight)
  VALUES ('589643b9-3a1d-40e7-9ec6-20a3113e801c', 'CPU Power', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 1.0);

INSERT INTO trait (id, label, product_category_id, default_weight)
  VALUES ('21530616-f7dc-4d02-8af6-fac38ae53e44', 'Mobility', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 0.5);

INSERT INTO trait (id, label, product_category_id)
  VALUES ('dfc6d666-7c68-467f-9842-66d5cb4956fe', 'Refresh Rate (hz)', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75');

-- Products
INSERT INTO product (id, label, ratings, facts, product_category_id, image)
  VALUES ('05ffa4d6-524b-4ea2-b62a-e277501ea26d', 'Acer Predator Helios 300', '{"mobility": 98, "cpuPower": 100}', '{"refreshRate": "144"}', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 'https://via.placeholder.com/150');

-- Questions
INSERT INTO question (id, main_text, type, product_category_id, weight)
  VALUES ('d8239476-afbf-4bf1-a674-74ba299d4fa3', 'What is your main usage for your laptop?', 'multiple_choice', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 0);

INSERT INTO question (id, main_text, type, product_category_id, weight)
  VALUES ('934da878-d8fa-4174-8d7e-d786ae34b98d', 'How much do you move around with your laptop?', 'multiple_choice', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 1);

-- Answers for "What is your main usage for your laptop?"
INSERT INTO answer (id, question_id, main_text, trait_modifiers, product_category_id, weight)
  VALUES ('6ef8487c-7aef-441c-ac33-0acbde6ed4ea', 'd8239476-afbf-4bf1-a674-74ba299d4fa3', 'Professional use', '{"cpuPower": {"number": 0.8, "operator": "*"}}', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 0);

INSERT INTO answer (id, question_id, main_text, trait_modifiers, product_category_id, weight)
  VALUES ('6c92d085-dd7c-4e74-93c9-16e8090d5ae9', 'd8239476-afbf-4bf1-a674-74ba299d4fa3', 'Gaming', '{"cpuPower": {"number": 1.5, "operator": "*"}}', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 1);

-- Answers for "How much do you move around with your laptop?"
INSERT INTO answer (id, question_id, main_text, trait_modifiers, product_category_id, weight)
  VALUES ('13d7eeda-da5a-4f14-8d20-39d3addb8039', '934da878-d8fa-4174-8d7e-d786ae34b98d', 'A lot', '{"mobility": {"number": 1, "operator": "*"}}', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 0);

INSERT INTO answer (id, question_id, main_text, trait_modifiers, product_category_id, weight)
  VALUES ('8e2ef43c-69e7-4822-b026-b989440c9cb8', '934da878-d8fa-4174-8d7e-d786ae34b98d', 'A little', '{"cpuPower": {"number": 0.3, "operator": "*"}}', 'ded315c4-2dc0-4b96-88a3-472cba1cdf75', 1);

-- Session
INSERT INTO session (id, created_at, last_active)
  VALUES ('8a042805-6738-4806-9456-8405974c9b40', DEFAULT, DEFAULT);
