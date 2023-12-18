CREATE TABLE `users` (
  `user_id` integer PRIMARY KEY,
  `fullname` varchar(64),
  `email` varchar(64),
  `password` varchar(255),
  `country` varchar(255),
  `created_at` timestamp,
  `role_id` int
);

CREATE TABLE `messages` (
  `message_id` integer PRIMARY KEY,
  `user_id` integer,
  `chat_id` integer,
  `message_text` varchar(255),
  `status` varchar(64),
  `created_at` timestamp,
  `read_flag` boolean
);

CREATE TABLE `chats` (
  `chat_id` integer,
  `topic` varchar(255)
);

CREATE TABLE `chat_members` (
  `message_id` integer PRIMARY KEY,
  `user_id` integer,
  `chat_id` integer,
  `status` varchar(64),
  `created_at` timestamp,
  `read_flag` boolean
);

CREATE TABLE `roles` (
  `role_id` integer,
  `role_name` archar(64),
  `is_active` boolean,
  `created_at` timestamp
);

CREATE TABLE `reactions` (
  `reaction_id` integer PRIMARY KEY,
  `message_id` integer,
  `user_id` integer,
  `description` varchar(255),
  `created_at` timestamp
);

ALTER TABLE `reactions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `reactions` ADD FOREIGN KEY (`message_id`) REFERENCES `messages` (`message_id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`);

ALTER TABLE `chat_members` ADD FOREIGN KEY (`chat_id`) REFERENCES `chats` (`chat_id`);

ALTER TABLE `roles` ADD FOREIGN KEY (`role_id`) REFERENCES `users` (`role_id`);

ALTER TABLE `chat_members` ADD FOREIGN KEY (`read_flag`) REFERENCES `messages` (`read_flag`);
