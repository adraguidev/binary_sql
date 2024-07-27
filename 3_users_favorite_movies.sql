SELECT 
    u.id,
    u.username,
    ARRAY_AGG(fm.movie_id) AS favorite_movie_ids
FROM 
    User u
LEFT JOIN 
    FavoriteMovie fm ON u.id = fm.user_id
GROUP BY 
    u.id, u.username
ORDER BY 
    u.id;
