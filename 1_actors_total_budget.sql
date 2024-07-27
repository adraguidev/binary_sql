SELECT 
    p.id,
    p.first_name,
    p.last_name,
    COALESCE(SUM(m.budget), 0) AS total_movies_budget
FROM 
    Person p
LEFT JOIN 
    MovieCharacter mc ON p.id = mc.person_id
LEFT JOIN 
    Movie m ON mc.movie_id = m.id
GROUP BY 
    p.id, p.first_name, p.last_name
ORDER BY 
    total_movies_budget DESC;
