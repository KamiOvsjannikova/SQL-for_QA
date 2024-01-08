db.users.findOne(
    {_id: 1}, // filter
    {country: 1, _id:0 }// projection
    )  