CREATE TABLE `players` (
  `player_id` int,
  `username` varchar(255),
  `email` varchar(255),
  `password` varchar(255),
  `rating` int
);

CREATE TABLE `Games` (
  `game_id` int,
  `white_player_id` int,
  `black_player_id` int,
  `start_time` timestamp,
  `end_time` timestamp,
  `result` varchar(65)
);

CREATE TABLE `Moves` (
  `move_id` int,
  `game_id` int,
  `player_id` int,
  `move_number` int,
  `from_square` varchar(2),
  `to_square` varchar(2)
);

ALTER TABLE `Games` ADD FOREIGN KEY (`white_player_id`) REFERENCES `players` (`player_id`);

ALTER TABLE `Games` ADD FOREIGN KEY (`black_player_id`) REFERENCES `players` (`player_id`);

ALTER TABLE `Moves` ADD FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`);

ALTER TABLE `Moves` ADD FOREIGN KEY (`game_id`) REFERENCES `Games` (`game_id`);
