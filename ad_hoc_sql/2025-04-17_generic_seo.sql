SELECT
  SUM(t.purchase_revenue) AS revenue
-- change per‑site
FROM `tough-healer-395417.BI.LAW_ga4_sessions`     AS s  
-- change per‑site 
LEFT JOIN `tough-healer-395417.BI.LAW_ga4_transactions` AS t   
  ON s.session_id = t.session_id
WHERE
  -- organic search or direct traffic
  (
    s.medium = 'organic'OR (s.source IS NULL AND s.medium IS NULL)
  )
  -- PDP, PLP, blog, or gift landing pages w/o promoCode
  AND REGEXP_CONTAINS(s.landing_page_location, r'/(product|wines|wine|search|wine-blog|advent|gifts)(/|\?|$)')
  AND s.landing_page_location NOT LIKE '%promoCode%'
  -- change per‑site
  AND s.hostname = 'www.laithwaites.com' 
  -- exclude devs
  AND s.country  != 'India'
  -- example for last fiscal week
  AND s.session_date BETWEEN '2025-02-08' AND '2025-02-14' 
