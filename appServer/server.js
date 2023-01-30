
const express = require('express')
const mongoose = require('mongoose')
var app = express()
var Data = require('./noteSchema')


mongoose.connect('mongodb://localhost/noteDB',{useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false})

mongoose.connection.once("open", () => {
    console.log("Connected to the database")
}).on("error", (error) => {
    console.log("Failed to connect " + error)
})

// Create a note. | POST request.

app.post("/create", (req, res) => {

    var note = new Data ({

        note: req.get("note"),
        title: req.get("title"),
        date:  req.get("date")
    })

    note.save().then(() => {

        if (note.isNew == false){
            console.log("Saved data.")
            res.send("iPhone Notified -- Saved data.")
        } else {
            console.log("Failed to save the data.")
        }
    })
})

// Update a note. | POST request.

app.post('/update', (req, res) => {

    Data.findOneAndUpdate({
        _id: req.get("id")

    },{
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    }, (err) => {
        console.log("Failed to update the data! " + err)
    })
    res.send("Phone Notified -- Updated")
})

// Fetch a note. | GET request.

app.get('/fetch', (req, res) => {

    Data.find({}).then((DBitems) => {
        res.send(DBitems)
    })
})

// Delete a note. | POST request.

app.post('/delete', (req, res) => {
    Data.findOneAndRemove({
        _id: req.get("id")

    }, (err) => {
        console.log("Failed" + err)
    })
    res.send("Phone Notified -- Deleted")
})





var server = app.listen(8000, "127.0.0.1", () => {
    console.log("Server is running.") 
})