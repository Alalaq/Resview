DROP TRIGGER update_restaurant_rating_trigger on restaurant_cuisine_rating;
DROP TRIGGER update_restaurant_rating_trigger on restaurants;


CREATE OR REPLACE FUNCTION update_restaurant_rating()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE restaurants
    SET general_rating =
            (SELECT AVG((rating))
             FROM restaurant_cuisine_rating
             WHERE restaurant_cuisine_rating.restaurant_id = NEW.restaurant_id)
    WHERE restaurants.restaraunt_id = NEW.restaurant_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_restaurant_rating_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON restaurant_cuisine_rating
    FOR EACH ROW
EXECUTE FUNCTION update_restaurant_rating();



INSERT INTO restaurants (name, general_rating, price, address, description)
VALUES ('The Hungry Bear', null, '$$', 'Tverskaya st. 1, Moscow',
        'The Hungry Bear is a cozy restaurant with a wide range of dishes. It is famous for its burgers and delicious desserts.'),
       ('La Bella Vita', null, '$$$', 'Nevsky Prospekt 2, St. Petersburg',
        'La Bella Vita is an upscale Italian restaurant with a romantic atmosphere. The menu includes a variety of traditional Italian dishes, and the wine list is extensive.'),
       ('Golden Dragon', null, '$$', 'Bauman st. 10, Kazan',
        'Golden Dragon is a Chinese restaurant that also serves Japanese and Korean cuisine. The menu includes a variety of noodles, dumplings, and stir-fries.'),
       ('Le Chat Noir', null, '$$$', 'Gorky st. 1, Nizhny Novgorod',
        'Le Chat Noir is a French restaurant that also serves Italian and Russian cuisine. The atmosphere is elegant and romantic, and the menu includes a variety of classic French dishes.'),
       ('The Red Dragon', null, '$', 'Lenin st. 5, Ekaterinburg',
        'The Red Dragon is a casual Chinese restaurant with a laid-back atmosphere. The menu includes a variety of rice and noodle dishes, as well as soups and appetizers.'),
       ('Mamma Mia', null, '$$', 'Lenina st. 2, Novosibirsk',
        'Mamma Mia is an Italian restaurant that also serves American and Mexican cuisine. The menu includes a variety of pizzas, pastas, and burgers.'),
       ('The Golden Phoenix', null, '$$$', 'Leningradskaya st. 10, Samara',
        'The Golden Phoenix is a Chinese restaurant that also serves Japanese and Korean cuisine. The menu includes a variety of dim sum, sushi, and Korean barbecue.'),
       ('The Kazan Kitchen', null, '', 'Kremlevskaya st. 1, Kazan',
        'The Kazan Kitchen offers traditional Tatar cuisine in a modern setting. The menu includes dishes such as chak-chak and echpochmak, as well as Russian favorites like borscht.'),
       ('Mangal', null, '$$$', 'Gogol st. 10, Kazan',
        'Mangal is a high-end Turkish restaurant with an extensive wine list. The menu includes a variety of kebabs and mezze, as well as grilled seafood.'),
       ('Soul Kitchen', null, '', 'Bauman st. 5, Kazan',
        'Soul Kitchen is a cozy cafe that serves healthy, organic food. The menu includes vegetarian and vegan options, as well as smoothies and juices.'),
       ('Chez Michel', null, '', 'Pushkin st. 1, Moscow',
        'Chez Michel is a French restaurant that offers a modern take on classic dishes. The atmosphere is elegant and sophisticated.'),
       ('The Spicy Noodle', null, '$', 'Kirova st. 5, Kazan',
        'The Spicy Noodle is a casual Asian restaurant that specializes in noodles and dumplings. The menu includes both Chinese and Japanese options.'),
       ('Mamma Roma', null, '$$', 'Kremlevskaya st. 10, Kazan',
        'Mamma Roma is an Italian restaurant that specializes in pizza and pasta. The menu includes a variety of traditional Italian dishes.'),
       ('The Ottoman Empire', null, '', 'Kremlevskaya st. 15, Kazan',
        'The Ottoman Empire is a Turkish restaurant that offers a fusion of Ottoman and Mediterranean cuisine. The atmosphere is luxurious and the service is impeccable.');

INSERT INTO restaurant_cuisine_rating (restaurant_id, cuisine, rating)
VALUES (1, 'AMERICAN', 4.3),
       (1, 'ITALIAN', 4.5),
       (1, 'MEXICAN', 3.8),
       (1, 'JAPANESE', 3.9),
       (1, 'KOREAN', 4.2),
       (2, 'ITALIAN', 4.6),
       (2, 'FRENCH', 4.8),
       (2, 'AMERICAN', 4.3),
       (2, 'CHINESE', 3.9),
       (2, 'JAPANESE', 4.1),
       (2, 'KOREAN', 4.4),
       (3, 'CHINESE', 4.0),
       (3, 'JAPANESE', 4.1),
       (3, 'KOREAN', 4.2),
       (4, 'FRENCH', 4.7),
       (4, 'ITALIAN', 4.6),
       (4, 'RUSSIAN', 4.3),
       (5, 'CHINESE', 3.8),
       (5, 'JAPANESE', 3.9),
       (5, 'KOREAN', 4.1),
       (6, 'AMERICAN', 4.2),
       (6, 'ITALIAN', 4.4),
       (6, 'MEXICAN', 3.9),
       (7, 'CHINESE', 4.1),
       (7, 'JAPANESE', 4.2),
       (7, 'KOREAN', 4.3),
       (8, 'AMERICAN', 4.2),
       (8, 'FRENCH', 4.5),
       (8, 'KOREAN', 4.3),
       (9, 'ITALIAN', 4.6),
       (9, 'MEXICAN', 4.4),
       (10, 'CHINESE', 4.2),
       (10, 'JAPANESE', 4.5),
       (10, 'RUSSIAN', 4.3),
       (11, 'FRENCH', 4.7),
       (11, 'GEORGIAN', 4.2),
       (11, 'AMERICAN', 4.6),
       (11, 'ITALIAN', 4.5),
       (12, 'CHINESE', 4.4),
       (12, 'KOREAN', 4.1),
       (12, 'JAPANESE', 4.3),
       (12, 'INDIAN', 4.2),
       (13, 'ITALIAN', 4.5),
       (13, 'FRENCH', 4.2),
       (13, 'RUSSIAN', 4.4),
       (13, 'CHINESE', 4.3),
       (13, 'JAPANESE', 4.6),
       (14, 'MEXICAN', 4.2),
       (14, 'AMERICAN', 4.4),
       (14, 'GEORGIAN', 4.3),
       (14, 'ITALIAN', 4.7),
       (14, 'CHINESE', 4.5);