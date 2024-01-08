db.users.find(
    { country: 'USA' }, // filter
    { country: 0 } // projection
)