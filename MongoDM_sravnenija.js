db.tracks.find(
    { duration: { $gte: 5 * 60 } } // filter
)