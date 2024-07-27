SELECT 
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    JSON_BUILD_OBJECT(
        'id', f.id,
        'file_name', f.file_name,
        'url', f.url
    ) AS poster,
    JSON_BUILD_OBJECT(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name
    ) AS director
FROM 
    Movie m
JOIN 
    Person p ON m.director_id = p.id
LEFT JOIN 
    File f ON m.poster_id = f.id
JOIN 
    MovieGenre mg ON m.id = mg.movie_id
JOIN 
    Genre g ON mg.genre_id = g.id
WHERE 
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > 135
    AND g.name IN ('Action', 'Drama')
GROUP BY 
    m.id, m.title, m.release_date, m.duration, m.description, f.id, f.file_name, f.url, p.id, p.first_name, p.last_name
ORDER BY 
    m.release_date DESC;
