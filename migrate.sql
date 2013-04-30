insert into SB.articles(title,url_alias,created,author_id,content) select title,alias,created,16,CONCAT(introtext,`fulltext`) from shantanubhadoria2.sb_content;
update SB.articles a left join shantanubhadoria2.sb_content sc on a.title = sc.title set a.created=sc.created;

insert into SB.tags(tag) select distinct sca.title from  shantanubhadoria2.sb_content sc left join shantanubhadoria2.sb_categories sca on sc.catid=sca.id ;
insert into SB.article_tag_maps(article_id,tag) select a.id,sca.title 
 from  shantanubhadoria2.sb_content sc left join shantanubhadoria2.sb_categories sca on sc.catid=sca.id left join SB.articles a on sc.title=a.title; 
