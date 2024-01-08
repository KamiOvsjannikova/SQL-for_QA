db.users.find(
    {}, // filter
    { country: 1, _id: 0 } // projection
)