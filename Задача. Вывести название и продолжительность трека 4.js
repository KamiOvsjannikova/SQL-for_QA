db.tracks.findOne(
    { _id: 4 },
    { title: 1, duration:1 , _id: 0}
)