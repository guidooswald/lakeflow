CREATE MATERIALIZED VIEW orders (
  CONSTRAINT positive_item_count EXPECT (item_count > 0) ON VIOLATION DROP ROW,
  CONSTRAINT amount_less_than_100 EXPECT (amount < 100)
) AS
SELECT
  order_id,
  user_id,
  amount,
  item_count,
  creation_date
FROM
  guido.c360.churn_orders;

CREATE MATERIALIZED VIEW order_amount_per_day AS
SELECT
  DATE(creation_date) AS order_date,
  SUM(amount) AS total_amount
FROM
  orders
GROUP BY
  DATE(creation_date);

CREATE MATERIALIZED VIEW order_users AS
SELECT
  user_id,
  email,
  creation_date,
  last_activity_date,
  firstname,
  lastname,
  address,
  canal,
  country,
  gender,
  age_group,
  churn
FROM
  guido.c360.churn_users;

CREATE MATERIALIZED VIEW orders_with_users AS
SELECT
  o.order_id,
  o.user_id,
  o.amount,
  o.item_count,
  o.creation_date AS order_creation_date,
  u.email,
  u.creation_date AS user_creation_date,
  u.last_activity_date,
  u.firstname,
  u.lastname,
  u.address,
  u.canal,
  u.country,
  u.gender,
  u.age_group,
  u.churn
FROM
  orders o
INNER JOIN
  order_users u
ON
  o.user_id = u.user_id;