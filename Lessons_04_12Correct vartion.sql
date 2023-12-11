CREATE TABLE `users` (
  `user_id` int,
  `username` varchar(255),
  `email` varchar(255),
  `password` varchar(255),
  `created_at` datetime
);

CREATE TABLE `videos_content` (
  `video_id` int,
  `user_id` int,
  `upload_date` datetime,
  `title` varchar(64),
  `description` text
);

CREATE TABLE `reactions` (
  `reaction_id` int,
  `user_id` int,
  `video_id` int,
  `title` varchar(64),
  `created_at` datetime
);

CREATE TABLE `comments` (
  `comment_id` int,
  `comment_text` text,
  `user_id` int,
  `video_id` int,
  `created_at` timespamp
);

CREATE TABLE `playlists` (
  `playlist_id` int,
  `user_id` int,
  `title` varchar(64),
  `created_at` datetime
);

CREATE TABLE `playlist_videos` (
  `playlist_video_id` int,
  `video_id` int,
  `playlist_id` int,
  `created_at` datetime
);

ALTER TABLE `comments` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `reactions` ADD FOREIGN KEY (`video_id`) REFERENCES `videos_content` (`video_id`);

ALTER TABLE `reactions` ADD FOREIGN KEY (`user_id`) REFERENCES `videos_content` (`user_id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`video_id`) REFERENCES `videos_content` (`video_id`);

ALTER TABLE `playlist_videos` ADD FOREIGN KEY (`video_id`) REFERENCES `videos_content` (`video_id`);

ALTER TABLE `playlist_videos` ADD FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`playlist_id`);

ALTER TABLE `videos_content` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `playlists` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
