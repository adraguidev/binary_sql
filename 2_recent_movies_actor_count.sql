SELECT 
    m.id,
    m.title,
    COUNT(DISTINCT mc.person_id) AS actors_count
FROM 
    Movie m
LEFT JOIN 
    MovieCharacter mc ON m.id = mc.movie_id
WHERE 
    m.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY 
    m.id, m.title
ORDER BY 
    m.release_date DESC;
