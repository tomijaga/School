-- drop table if exists cds;
-- drop table if exists songs;


BEGIN TRANSACTION;
-- CREATE TABLE cds(
--       cd_id text primary key not null, --cd unique id
--       title text NOT NULL, --title of CD
--       artist text NOT NULL, --artist whose CD it is or "various artists"
--       producer text default NULL,
--       year integer,
--       contributer text --student number who contirbuted the data
--       );

DELETE FROM cds WHERE contributer = '101121458';
INSERT INTO cds VALUES('101121458JColeBornSinner','Born Sinner','Jermaine Cole','Christain Rich',2013,'101121458');
INSERT INTO cds VALUES('SlimeNBA4KTrey','AI Youngboy 2','NBA Youngboy','Cash Money AP', 2019,'101121458');


-- CREATE TABLE songs(
--       song_id integer primary key not null, --auto incrementing key
--       title text NOT NULL, --title of song
--       composer text NOT NULL, --person or persons who wrote the song
--       cd_id text NOT NULL, --cd this song appears on
--       track integer NOT NULL, --track number of the song
--       contributer text --student number who contirbuted the data
--       );


DELETE FROM songs WHERE contributer = '101121458';

--JCole
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Villuminati','Jermaine Cole','101121458JColeBornSinner', 1,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Kerny Sermon (Skit)','Jermaine Cole','101121458JColeBornSinner', 2,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Land Of The Snakes','Jermaine Cole','101121458JColeBornSinner', 3,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Power Trip','Jermaine Cole, Miquel','101121458JColeBornSinner', 4,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Mo Money','Jermaine Cole','101121458JColeBornSinner', 5,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Trouble','Jermaine Cole','101121458JColeBornSinner', 6,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Runaway','Jermaine Cole','101121458JColeBornSinner', 7,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('She Knows','Jermain Cole, Amber Coffman, Cults','101121458JColeBornSinner', 8,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Rich Guys','Jermaine Cole','101121458JColeBornSinner', 9,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Where''s Jermaine? (Skit)','Jermaine Cole','101121458JColeBornSinner', 10,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Forbidden Fruit','Jermaine Cole, Kendrick Lamar','101121458JColeBornSinner', 11,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Chaining Day','Jermaine Cole','101121458JColeBornSinner', 12,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Ain''t That Some Shit (Interlude)','Jermaine Cole','101121458JColeBornSinner', 13,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Crooked Smile','Jermaine Cole, TLC','101121458JColeBornSinner', 14,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Let Nas Down','Jermaine Cole','101121458JColeBornSinner', 15,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Born Sinner','Jermain Cole, James Fauntleroy','101121458JColeBornSinner', 16,'101121458');

--NBA Youngboy
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Carter Son','NBA Youngboy','101121458JColeBornSinner', 1,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Time I''m On','NBA Youngboy','101121458JColeBornSinner', 2,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Hot Now','NBA Youngboy','101121458JColeBornSinner', 3,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Seeming Like It','NBA Youngboy','101121458JColeBornSinner', 4,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Self Control','NBA Youngboy','101121458JColeBornSinner', 5,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Make No Sense','NBA Youngboy','101121458JColeBornSinner', 6,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Rich As Hell','NBA Youngboy','101121458JColeBornSinner', 7,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Slime Mentalility','NBA Youngboy','101121458JColeBornSinner', 8,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Head Blown','NBA Youngboy','101121458JColeBornSinner', 9,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Ranada','NBA Youngboy','101121458JColeBornSinner', 10,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Lonely Child','NBA Youngboy','101121458JColeBornSinner', 11,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Gang Shit','NBA Youngboy','101121458JColeBornSinner', 12,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Rebel''s Kick It','NBA Youngboy','101121458JColeBornSinner', 13,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Outta Here Safe','NBA Youngboy, Quando Rando, NoCap','101121458JColeBornSinner', 14,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('In Control','NBA Youngboy','101121458JColeBornSinner', 15,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('I Don''t Know','NBA Youngboy','101121458JColeBornSinner', 16,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Where The Love At','NBA Youngboy','101121458JColeBornSinner', 17,'101121458');
INSERT INTO songs (title, composer, cd_id, track, contributer) VALUES('Free Time','NBA Youngboy','101121458JColeBornSinner', 18,'101121458');

COMMIT;