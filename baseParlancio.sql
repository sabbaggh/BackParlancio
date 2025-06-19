select * from usuarios;
select * from intereses;

CREATE TABLE conversaciones_front (
    id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    language VARCHAR(10) NOT NULL,
    level VARCHAR(20) NOT NULL,
    image TEXT
);

INSERT INTO conversaciones_front (id, title, language, level, image) VALUES
(1, 'Ordenar un cafe', 'cn', 'beginner', 'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/GettyImages-1318950018_535375_uwicaq.jpg'),
(2, 'Llegar tarde al trabajo', 'cn', 'intermediate', 'https://nypost.com/wp-content/uploads/sites/2/2025/01/office-worker-coming-late-meeting-97303488.jpg?quality=75&strip=all'),
(3, 'Ir al supermercado', 'cn', 'advanced', 'https://media.istockphoto.com/id/1133100481/photo/asian-woman-with-grocery-bag.webp'),
(4, 'Primer dia de clases', 'cn', 'beginner', 'https://www.parentmap.com/sites/default/files/styles/1180x660_scaled_cropped/public/2024-08/girl%20on%20first%20day%20of%20school%20holding%20a%20sign_istock.jpg?itok=5yOyTbBM'),
(5, 'Conociendo nuevos colegas', 'cn', 'intermediate', 'https://www.rwrecruitment.com/wp-content/uploads/2019/09/Getting-to-know-your-colleagues-in-a-new-job.jpg');

INSERT INTO conversaciones_front (id, title, language, level, image) VALUES
(6, 'Ordenar un cafe', 'en', 'beginner', 'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/GettyImages-1318950018_535375_uwicaq.jpg'),
(7, 'Llegar tarde al trabajo', 'en', 'intermediate', 'https://nypost.com/wp-content/uploads/sites/2/2025/01/office-worker-coming-late-meeting-97303488.jpg?quality=75&strip=all'),
(8, 'Ir al supermercado', 'en', 'advanced', 'https://media.istockphoto.com/id/1133100481/photo/asian-woman-with-grocery-bag.webp'),
(9, 'Primer dia de clases', 'en', 'beginner', 'https://www.parentmap.com/sites/default/files/styles/1180x660_scaled_cropped/public/2024-08/girl%20on%20first%20day%20of%20school%20holding%20a%20sign_istock.jpg?itok=5yOyTbBM'),
(10, 'Conociendo nuevos colegas', 'en', 'intermediate', 'https://www.rwrecruitment.com/wp-content/uploads/2019/09/Getting-to-know-your-colleagues-in-a-new-job.jpg');

INSERT INTO conversaciones_front (id, title, language, level, image) VALUES
(11, 'Ordenar un cafe', 'pt', 'beginner', 'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/GettyImages-1318950018_535375_uwicaq.jpg'),
(12, 'Llegar tarde al trabajo', 'pt', 'intermediate', 'https://nypost.com/wp-content/uploads/sites/2/2025/01/office-worker-coming-late-meeting-97303488.jpg?quality=75&strip=all'),
(13, 'Ir al supermercado', 'pt', 'advanced', 'https://media.istockphoto.com/id/1133100481/photo/asian-woman-with-grocery-bag.webp'),
(14, 'Primer dia de clases', 'pt', 'beginner', 'https://www.parentmap.com/sites/default/files/styles/1180x660_scaled_cropped/public/2024-08/girl%20on%20first%20day%20of%20school%20holding%20a%20sign_istock.jpg?itok=5yOyTbBM'),
(15, 'Conociendo nuevos colegas', 'pt', 'intermediate', 'https://www.rwrecruitment.com/wp-content/uploads/2019/09/Getting-to-know-your-colleagues-in-a-new-job.jpg');
