-- [*] Qual'è il paese più esteso di tutti?
SELECT `countries`.`name`, `countries`.`surface_area`
FROM `countries`
ORDER BY `countries`.`surface_area` DESC
LIMIT 1

-- Quante sono le Repubbliche?
SELECT COUNT(*)
FROM `countries`
WHERE `government_form` = 'Republic'

-- [*] Quanti stati ci sono in ogni continente?
SELECT `countries`.`continent`, COUNT(*) as `countries_count`
FROM `countries`
GROUP BY `countries`.`continent`
ORDER BY `countries_count` DESC

-- Da quanti stati è stata adottata ciascuna forma di governo?
SELECT `countries`.`government_form`, COUNT(*) as `adopted_by`
FROM `countries`
GROUP BY `countries`.`government_form`
ORDER BY `adopted_by` DESC

-- Qual'è la città più popolosa d'Europa?
SELECT `cities`.`name`, `cities`.`population`
FROM `cities`
JOIN `countries` ON `countries`.`code` = `cities`.`country_code`
WHERE `countries`.`continent` = 'Europe'
ORDER BY `cities`.`population` DESC
LIMIT 1

---------------- ASPETTATIVA DI VITA ---------------------

-- [*] Qual è l'aspettativa di vita dell'Italia?
SELECT `life_expectancy`
FROM `countries`
WHERE `name` = 'Italy'

-- [*] Qual è la top 3 dei paesi con la più alta aspettativa di vita del mondo?
SELECT `countries`.`name`, `countries`.`life_expectancy`
FROM `countries`
ORDER BY `countries`.`life_expectancy` DESC
LIMIT 3

---------------- LINGUE ---------------------

-- [***] Qual'è la lingua più parlata al mondo?
SELECT
	`languages`.`name`,
	SUM(`countries`.`population` * `country_language`.`percentage`) as `speakers`
FROM `country_language`
JOIN `countries`
ON `countries`.`code` = `country_language`.`country_code`
JOIN `languages`
ON `languages`.`id` = `country_language`.`language_id`
GROUP BY `languages`.`name`
ORDER BY `speakers` DESC
LIMIT 1

-- [**] Quante lingue diverse si parlano in ogni paese?
SELECT `countries`.`name`, COUNT(*) as `different_languages`
FROM `country_language`
JOIN `countries`
ON `countries`.`code` = `country_language`.`country_code`
GROUP BY `country_language`.`country_code`
ORDER BY `different_languages` DESC

-- [**] Quante lingue diverse si parlano in ogni continente?
SELECT `countries`.`continent`, COUNT(*) as `different_languages`
FROM `country_language`
JOIN `countries`
ON `countries`.`code` = `country_language`.`country_code`
JOIN `languages`
ON `languages`.`id` = `country_language`.`language_id`
GROUP BY `countries`.`continent`
ORDER BY `different_languages` DESC

-- [**] Quali lingue si parlano in Australia?
SELECT `countries`.`name`, `languages`.`name`
FROM `country_language`
JOIN `countries`
ON `countries`.`code` = `country_language`.`country_code`
JOIN `languages`
ON `languages`.`id` = `country_language`.`language_id`
WHERE `countries`.`name` = 'Australia'

-- [**] Qual'è la lingua ufficiale del Guatemala?
SELECT `countries`.`name`, `languages`.`name`
FROM `country_language`
JOIN `countries`
ON `countries`.`code` = `country_language`.`country_code`
JOIN `languages`
ON `languages`.`id` = `country_language`.`language_id`
WHERE `countries`.`name` = 'Guatemala'
AND `country_language`.`is_official` = 'T'