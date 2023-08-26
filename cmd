db.employees.insertOne({
    name: "lake",
    age: 21,
    dept: "Database",
    joinDate: new ISODate("2022-10-01"),
    salary: 400000,
    bonus: null
})

db.employees.insertMany([
    {
        name: "ocean",
        age: 45,
        dept: "Network",
        joinDate: new ISODate("1999-11-15"),
        salary: 1000000,
        resignationDate: new ISODate("2002-12-23"),
        bonus: null
    },
    {
        name: "river",
        age: 34,
        dept: "DevOps",
        isNegotiating: true
    }
])

for(i = 0; i < 300; i++) {
    db.insertTest.insertOne({a : i})
}

var docs = []
for(i = 0; i < 300; i++) {
    docs.push({a: i})
}
db.insertTest.insertMany(docs)

db.employees.updateOne(
    { name: "river"},
    {
        $set: {
            salary: 350000,
            dept: "Database",
            joinDate: new ISODate("2022-12-31")
        },
        $unset: {
            isNegotiating: ""
        }
    }
)

db.employees.updateMany(
    { resignationDate: { $exists: false }, joinDate: {$exists: true}},
    { $mul: {salary: Decimal128("1.1")}
})

db.employees.updateMany(
    { resignationDate: { $exists: false }, bonus: null},
    { $set: {bonus: 100000}
})

db.employees.updateOne(
    { name : "river" },
    { $unset: {bonus: ""}
})

db.employees.updateMany(
    { resignationDate: { $exists: false }, bonus: {$exists: true}},
    { $set: {bonus: 200000}
})

db.employees.deleteOne({name: "river"})

db.employees.deleteMany({});

db.planets.findOne({ name: "Mars" })
db.planets.find({
    hasRings: true,
    orderFromSun: {$lte: 6
    }
})

db.planets.find({
    $and: [
        {hasRings: true,},
        {orderFromSun: {$lte: 6}}
    ]  
})

db.planets.find({
    $or: [
        {hasRings: { $ne: false }},
        {orderFromSun: {$gt: 6}}
    ]  
})

db.planets.find(
    { mainAtmosphere: { $in: ['O2']} }
)

db.bulk.bulkWrite(
    [
        {insertOne: {doc: 1, order: 1}},
        {insertOne: {doc: 2, order: 2}},
        {insertOne: {doc: 3, order: 3}},
        {insertOne: {doc: 4, order: 4}},
        {insertOne: {doc: 5, order: 5}},
        {
            deleteOne: {
                filter: {doc: 3}
            }
        },
        {
            updateOne: {
                filter: { doc: 2},
                update: {
                    $set: { doc: 12}
                }
            }
        }

    ]
)

db.bulk.bulkWrite(
    [
        {insertOne: {doc: 1, order: 1}},
        {insertOne: {doc: 2, order: 2}},
        {insertOne: {doc: 3, order: 3}},
        {insertOne: {doc: 4, order: 4}},
        {insertOne: {doc: 5, order: 5}},
        {
            deleteOne: {
                filter: {doc: 3}
            }
        },
        {
            updateOne: {
                filter: { doc: 2},
                update: {
                    $set: { doc: 12}
                }
            }
        },
        {ordered: false}
    ]
)

db.bulk.countDocuments()

db.bulk.estimatedDocumentCount()

// 유니크한 도큐먼트 반환
db.bulk.distinct("doc")