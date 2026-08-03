SELECT * FROM articles WHERE MATCH(content) AGAINST('and');

SELECT * FROM articles WHERE MATCH(title,content) AGAINST('and');

SELECT * FROM articles WHERE MATCH(content) AGAINST('+SQL' IN BOOLEAN MODE);

SELECT *, MATCH(content) AGAINST('performance') AS relevance FROM articles WHERE MATCH(content) AGAINST('performance') ORDER BY relevance DESC;

SELECT * FROM articles WHERE MATCH(content) AGAINST('optimization' WITH QUERY EXPANSION);

SELECT * FROM articles WHERE MATCH(content) AGAINST('and') AND YEAR(publish_date)=2025;

SELECT * FROM articles WHERE MATCH(content) AGAINST('and') ORDER BY publish_date DESC;

ALTER TABLE articles ADD FULLTEXT INDEX idx_content(content);

ALTER TABLE articles ADD FULLTEXT INDEX idx_content_title(title,content);

SELECT * FROM articles WHERE MATCH(content) AGAINST('analytics' IN NATURAL LANGUAGE MODE);

SELECT * FROM articles WHERE MATCH(content) AGAINST('+marketing -advertising' IN BOOLEAN MODE);

UPDATE articles SET content=CONCAT(content,' cloud') WHERE article_id=1;

SELECT *, MATCH(content) AGAINST('cybersecurity') AS relevance FROM articles WHERE MATCH(content) AGAINST('cybersecurity') ORDER BY relevance DESC;

SELECT * FROM articles WHERE MATCH(content) AGAINST('innovation') LIMIT 10;

SELECT * FROM articles WHERE article_id IN (SELECT article_id FROM articles WHERE MATCH(content) AGAINST('and'));

SELECT * FROM articles WHERE MATCH(content) AGAINST('"data science"' IN BOOLEAN MODE);

SELECT a.*, au.author_name FROM articles a JOIN articles au ON a.article_id=au.article_id WHERE MATCH(a.content) AGAINST('blockchain');

SELECT * FROM articles WHERE MATCH(content) AGAINST('network');

SELECT *, MATCH(content) AGAINST('technology') AS titlerelevance, MATCH(content) AGAINST('technology') AS contentrelevance, (MATCH(content) AGAINST('technology')*2 + MATCH(content) AGAINST('technology')) AS total
FROM articles WHERE MATCH(content) AGAINST('technology') ORDER BY total DESC;

SELECT * FROM articles WHERE MATCH(content) AGAINST('innovation') LIMIT 10 OFFSET 10;

