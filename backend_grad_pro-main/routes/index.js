const express = require('express')
const actions = require('../methods/actions')
const user = require('../models/user')
const router = express.Router()


router.get('/', (req, res) => {
    res.send('Hello World')
})

router.get('/dashboard', (req, res) => {
    res.send('Dashboard')
})

router.post('/addworker',actions.addNewWorker)
router.post('/addmanager',actions.addNewManager)
router.post('/adduser',actions.addNew)
router.post('/addservice',actions.addNewService)
router.post('/addcategory',actions.addNewCategory)
router.post('/addorder',actions.addNewOrder)
//@desc Authenticate a user
//@route POST /authenticate
router.post('/authenticate', actions.authenticate)
router.post('/authenticatem', actions.authenticatem)
router.post('/authenticatew', actions.authenticatew)

//@desc Get info on a user
//@route GET /getinfo
router.get('/getlocation/:name', actions.getlocation)
//save reg, lat,long to database
router.put('/savelocation',actions.savelocation)
//delete user
router.delete('/d_user',actions.d_user)
//get dynamic category client home page
router.get('/getcategory', actions.getcategory)
//get dynamic services according to its category
router.get('/getservice', actions.getservice)
//get client's order in booking
router.get('/getorder/:clientname', actions.getorder)
//client cancel his order request
router.put('/cancelrequest/:_id',actions.cancelrequest)
//get spacific order according id
router.get('/getspacificorder/:_id', actions.getspacificorder)
router.get('/getworkernameandphonenumber/:_id', actions.getworkernameandphonenumber)
//client set rate for a completed service
router.put('/rateorder/:_id',actions.rateorder) 
//get workers according their category and region
router.get('/getworkers/:category/:region', actions.getworkers)
//push a new time for array of time in worker
router.put('/addtimeforworker/:_id',actions.addtimeforworker)
//get worker info from profile page
router.get('/getworkerinfo/:phonenumber',actions.getworkerinfo)
//update worker info in profile page
router.put('/updateworkerinfo/:phonenumber',actions.updateworkerinfo)
//get id of worker using name
router.get('/getworkerid/:phonenumber', actions.getworkerid)
//get workers pending orders
router.get('/getworkerorders/:worker', actions.getworkerorders)
//worker accept request
router.put('/acceptrequest/:_id',actions.acceptrequest)
//get client phonenumber
router.get('/getclientnameandphonenumber/:name', actions.getclientnameandphonenumber)
//get workers assigned and completed orders
router.get('/getassignedorder/:worker', actions.getassignedorder)
//get worker name to home page
router.get('/getworkername/:phonenumber', actions.getworkername) 
//set order status finish
router.put('/endrequest/:_id',actions.endrequest)
//remove time after finish order
router.put('/removetimeforworker/:_id/:time',actions.removetimeforworker)
//set order status start
router.put('/startrequest/:_id',actions.startrequest)
//get last 10 records in orders for that srvice
router.get('/getlast10times/:service', actions.getlast10times)
//change estimated time to the last 10 records average
router.put('/changeestimatedtime/:service',actions.changeestimatedtime)
//get every worker rate from order's collection to get avrg rate for worker
router.get('/getworkerrate/:worker', actions.getworkerrate)
//change worker rate
router.put('/changeworkerrate/:_id',actions.changeworkerrate)
//change password for client
router.put('/newpassforclient/:name',actions.newpassforclient)
//----------------------------------------------------------------//
//get 3 workers with largest rating
router.get('/get3bestworker', actions.get3bestworker)
//get today's order 
router.get('/gettodaysorder', actions.gettodaysorder)
//delete order
router.delete('/d_order/:_id',actions.d_order)
//get count today's order 
router.get('/getcountorder', actions.getcountorder)
//get count of worker 
router.get('/getcountworker', actions.getcountworker)
//get count of worker 
router.get('/getcountclient', actions.getcountclient)
//get admin name
router.get('/getadminname/:phonenumber', actions.getadminname)
//get count of orders acording to category 
router.get('/getcountorderbycategory/:category', actions.getcountorderbycategory)
//get workers
router.get('/mgetworkers', actions.mgetworkers)
//get clients
router.get('/mgetclients', actions.mgetclients)
//get count of client's order
router.get('/getcountclientorder/:clientname',actions.getcountclientorder)
//delete service
router.delete('/d_service/:_id',actions.d_service)
//get orders
router.get('/mgetorders', actions.mgetorders)
module.exports = router