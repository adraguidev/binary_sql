SELECT 
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    JSON_BUILD_OBJECT(
        'id', pf.id,
        'file_name', pf.file_name,
        'url', pf.url
    ) AS poster,
    JSON_BUILD_OBJECT(
        'id', d.id,
        'first_name', d.first_name,
        'last_name', d.last_name,
        'photo', JSON_BUILD_OBJECT(
            'id', df.id,
            'file_name', df.file_name,
            'url', df.url
        )
    ) AS director,
    ARRAY_AGG(DISTINCT JSON_BUILD_OBJECT(
        'id', a.id,
        'first_name', a.first_name,
        'last_name', a.last_name,
        'photo', JSON_BUILD_OBJECT(
            'id', af.id,
            'file_name', af.file_name,
            'url', af.url
        )
    )) AS actors,
    ARRAY_AGG(DISTINCT JSON_BUILD_OBJECT(
        'id', g.id,
        'name', g.name
    )) AS genres
FROM 
    Movie m
LEFT JOIN 
    File pf ON m.poster_id = pf.id
JOIN 
    Person d ON m.director_id = d.id
LEFT JOIN 
    PersonPhoto dp ON d.id = dp.person_id AND dp.is_primary = true
LEFT JOIN 
    File df ON dp.file_id = df.id
LEFT JOIN 
    MovieCharacter mc ON m.id = mc.movie_id
LEFT JOIN 
    Person a ON mc.person_id = a.id
LEFT JOIN 
    PersonPhoto ap ON a.id = ap.person_id AND ap.is_primary = true
LEFT JOIN 
    File af ON ap.file_id = af.id
JOIN 
    MovieGenre mg ON m.id = mg.movie_id
JOIN 
    Genre g ON mg.genre_id = g.id
WHERE 
    m.id = 1
GROUP BY 
    m.id, m.title, m.release_date, m.duration, m.description, 
    pf.id, pf.file_name, pf.url, 
    d.id, d.first_name, d.last_name, df.id, df.file_name, df.url;
