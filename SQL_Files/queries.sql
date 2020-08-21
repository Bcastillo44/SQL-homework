query_transactions = """SELECT a."card_name",b."card_number",c."amount",c."date",d."merchant_name",e."merchant_category_name" FROM "transactions" AS c
INNER JOIN "credit_card" AS b ON c."card_number" = b."card_number"
INNER JOIN "card_holder" AS a ON b."card_id" = a."card_id"
INNER JOIN "merchant" AS d ON c."merchant_id" = d."merchant_id"
INNER JOIN "merchant_category" AS e ON e."merchant_category_id" = d."merchant_category_id"
ORDER BY a."card_name" ;
"""



highest_transactions = """SELECT CAST(date AS timestamp), amount as "highest_transactions" 
FROM transactions
WHERE date >= '2018-01-01 07:00:00' and date <= '2018-12-31 09:00:00' 
ORDER BY highest_transactions DESC LIMIT 100;
"""


transactions_count = """SELECT a."card_name", Count(c."transaction_id") AS "Small_Transactions",c."card_number" 
  FROM "transactions" AS c
  INNER JOIN "credit_card" AS b ON c."card_number" = b."card_number"
  INNER JOIN "card_holder" AS a ON b."card_id" = a."card_id"
  WHERE c."amount"<2
  GROUP BY c."card_number",a."card_name"
  ORDER BY "Small_Transactions" DESC;
  """

  top_five_merchants = """SELECT d."merchant_name" AS "Merchant", e."merchant_category_name" AS "Merchant Category",Count(c."transaction_id") AS "Small_Transactions" 
  FROM "transactions" AS c
  INNER JOIN "merchant" AS d ON d."merchant_id" = c."merchant_id"
  INNER JOIN "merchant_category" e ON e."merchant_category_id" = d."merchant_category_id"
  WHERE c."amount"<2
  GROUP BY d."merchant_name", e."merchant_category_name"
  ORDER BY "Small_Transactions" DESC
  LIMIT 5;"""


  transactions_view = """CREATE VIEW Transactions_View AS
    SELECT c."transaction_id", c."date", c."amount", d."merchant_name" AS "MerchantName",
            e."merchant_category_name" AS "MerchantCategory", b."card_number", a."card_name" AS "CardHolderName"
    FROM "transactions" c
    INNER JOIN "credit_card" b ON c."card_number" = b."card_number"
    INNER JOIN "card_holder" a ON a."card_id" = b."card_id"
    INNER JOIN "merchant" d ON d."merchant_id" = c."merchant_id"
    INNER JOIN "merchant_category" e ON e."merchant_category_id" = d."merchant_category_id";
    
    SELECT * FROM Transactions_View ORDER BY "transaction_id";
    """