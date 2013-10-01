CREATE TABLE users (

  id INTEGER PRIMARY KEY,

  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,

	title VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,

	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,

	question_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,

	question_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	body VARCHAR(255) NOT NULL,

	parent_reply_id INTEGER,
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)

);

CREATE TABLE question_likes (
	id INTEGER PRIMARY KEY,

	question_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- In addition to creating tables, we can seed our database with some
-- starting data.

INSERT INTO
users(fname, lname)
VALUES
('john', 'smith'),
('sarah', 'smith'),
('dale', 'jenkins');


INSERT INTO
questions(title, body, user_id)
VALUES
('question1?', 'question 1 body?',
	(SELECT id FROM users WHERE fname = 'john' AND lname = 'smith')),
('question2?', 'question 2 body?',
	(SELECT id FROM users WHERE fname = 'sarah' AND lname = 'smith'));


INSERT INTO
question_followers(question_id, user_id)
VALUES
((SELECT id FROM questions WHERE title = 'question1?'),
	(SELECT id FROM users WHERE fname = 'sarah' AND lname = 'smith')),
((SELECT id FROM questions WHERE title = 'question2?'),
	(SELECT id FROM users WHERE fname = 'john' AND lname = 'smith'));


INSERT INTO
replies(question_id, user_id, body, parent_reply_id)
VALUES
((SELECT id FROM questions WHERE title = 'question1?'),
	(SELECT id FROM users WHERE fname = 'sarah' AND lname = 'smith'),
	'reply1', NULL),
((SELECT id FROM questions WHERE title = 'question1?'),
	(SELECT id FROM users WHERE fname = 'john' AND lname = 'smith'),
	'reply2', (SELECT id FROM replies WHERE body = 'reply1'));

INSERT INTO
question_likes(question_id, user_id)
VALUES
((SELECT id FROM questions WHERE title = 'question1?'),
	(SELECT id FROM users WHERE fname = 'sarah' AND lname = 'smith')),

((SELECT id FROM questions WHERE title = 'question2?'),
	(SELECT id FROM users WHERE fname = 'dale' AND lname = 'jenkins'));