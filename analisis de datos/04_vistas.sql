   --Vista general para usar en Power BI--

CREATE VIEW vista_general AS
SELECT
    V.order_id,
    V.sales,
    C.customer_name,
    C.segment,
    P.product_name,
    P.category,
    U.city,
    U.state,
    U.region,
    D.year,
    D.month_name,
    D.quarter
FROM ventas V
JOIN clientes C
ON V.customer_id = C.customer_id
JOIN productos P
ON V.product_id = P.product_id
JOIN Geografia U
ON V.postal_code = U.postal_code
JOIN Tiempo D
ON V.order_date = D.order_date;
