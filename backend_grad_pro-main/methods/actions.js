
var User = require('../models/user')
var Worker = require('../models/workers')
var Manager = require('../models/manager')
var Category = require('../models/category')
var Serice = require('../models/service')
var order = require('../models/order')

var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
const res = require('express/lib/response') 
const category = require('../models/category')
const user = require('../models/user')
var functions = {
    addNew: function (req, res) {
        console.log(req.body.password);
        console.log(req.body.phonenumber);
        console.log(req.body.name);
       // User.find({name:req.body.name},)
        if ((!req.body.name) || (!req.body.password)|| (!req.body.phonenumber)) {
            res.json({ success: false, msg: 'الرجاء ادخال جميع الحقول' })
        }
        else {
         
            var newUser = User({ 
                role : "user",
                name: req.body.name,   
                password: req.body.password,
                phonenumber: req.body.phonenumber
            }); 
            newUser.save(function (err, newUser) {
                if (err) {
                    res.json({ success: false, msg: 'الرجاء اختيار اسم اخر' })
                }
                else {
                    res.json({ success: true, msg: 'تم التسجيل بنجاح' })
                }
            })
        }
    },
    addNewWorker: function (req, res) {
        console.log(req.body.password);
        console.log(req.body.phonenumber);
        console.log(req.body.name);
        console.log(req.body.category);
        console.log(req.body.region);


        if ((!req.body.name) || (!req.body.password)|| (!req.body.phonenumber)|| (!req.body.category)|| (!req.body.region)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newWorker = Worker({
                role : "worker",
                name: req.body.name,
                password: req.body.password,
                phonenumber: req.body.phonenumber,
                category: req.body.category,
                region: req.body.region,
            });
            newWorker.save(function (err, newWorker) {
                if (err) {
                    res.json({ success: false, msg: 'Failed to save' })
                }
                else {
                    res.json({ success: true, msg: 'Successfully saved' })
                }
            })
        }
    },
    addNewManager: function (req, res) {
        console.log(req.body.password);

        console.log(req.body.phonenumber);
        console.log(req.body.name);
        if ((!req.body.name) || (!req.body.password)|| (!req.body.phonenumber)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newManager = Manager({
                role : "manager",
                name: req.body.name,
                password: req.body.password,
                phonenumber: req.body.phonenumber,
            });
            newManager.save(function (err, newManager) {
                if (err) {
                    return res.json({ success: false, data: 'Failed to save' })
                }
                else {
                    
                  return res.json('تم التسجيل بنجاح' )
                 }
            }) 
        }
    },
    addNewService: function (req, res) {
        if ((!req.body.catname) || (!req.body.service)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newServ = Serice({
                role : "service",
                catname: req.body.catname,
                service: req.body.service,
               // price: req.body.price,
    
               estimatedTime: req.body.estimatedTime,
                Img: req.body.Img,
            });
            newServ.save(function (err, newServ) {
                if (err) {
                    res.json({ success: false, msg: 'Failed to save' })
                }
                else {
                    res.json({ success: true, msg: 'Successfully saved' })
                }
            })
        }
    },
    addNewCategory: function (req, res) {
        if ((!req.body.name) || (!req.body.image)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newServ = Category({
                name: req.body.name,
                image: req.body.image,
            });
            newServ.save(function (err, newServ) {
                if (err) {
                    res.json({ success: false, msg: 'Failed to save' })
                }
                else {
                    res.json({ success: true, msg: 'Successfully saved' })
                }
            })
        }
    },
    addNewOrder: function (req, res) {
        console.log(req.body.name);
        console.log(req.body.time);
        console.log(req.body.service);
        console.log(req.body.address);
        console.log(req.body.category);
        if ((!req.body.name) || (!req.body.category)|| (!req.body.service)||
         (!req.body.address) || (!req.body.time) || (!req.body.worker)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var neworder = order({
                clientname: req.body.name,
                service: req.body.service,
                category: req.body.category,
                time: req.body.time,
                worker:req.body.worker,
                address: req.body.address,
                status:"قيد الانتظار"
            });
            neworder.save(function (err, neworder) {
                if (err) {
                    res.send({ success: false, msg: 'Failed to save' })
                }
                else {
                    res.send({ success: true, msg: 'Successfully saved' })
                }
            })        }
    },
    authenticatem: function (req, res) {
        Manager.findOne({
            phonenumber: req.body.phonenumber
        }, function (err, manager) {
            if (err) throw err
            if (!manager) {
                res.status(403).send({ success: false, msg: 'Authentication Failed, User not found' })
            }

            else {
                manager.comparePassword(req.body.password, function (err, isMatch) {
                    if (isMatch && !err) {
                        var token = jwt.encode(manager, config.secret)
                         res.status(200).send({ success: true, token: token })
                    }
                    else {
                         res.status(403).send({ success: false, msg: 'Authentication failed, wrong password' })
                    }
                })
            }
        }
        )
    },
    authenticatew: function (req, res) {

        Worker.findOne({
            phonenumber: req.body.phonenumber
        }, function (err, worker) {
            if (err) throw err
            if (!worker) {
                res.status(403).send({ success: false, msg: 'Authentication Failed, User not found' })
            }

            else {
                worker.comparePassword(req.body.password, function (err, isMatch) {
                    console.log(req.body.password)

                    if (isMatch && !err) {
                        var token = jwt.encode(worker, config.secret)
                        res.json({ success: true, token: token })
                    }
                    else {
                        return res.status(403).send({ success: false, msg: 'Authentication failed, wrong password' })
                    }
                })
            }
        }
        )
    },
    authenticate: function (req, res) {
        User.findOne({
            name: req.body.name
        }, function (err, user) {
            if (err) throw err
            if (!user) {
                res.status(403).send({ success: false, msg: 'المستخدم غير موجود' })
            }

            else {
                user.comparePassword(req.body.password, function (err, isMatch) {
                    if (isMatch && !err) {
                        var token = jwt.encode(user, config.secret)
                        res.json({ success: true, token: token })
                    }
                    else {
                        return res.status(403).send({ success: false, msg: 'كلمة السر خاطئة' })
                    }
                })
            }
        }
        )
    },
    getlocation: function (req , res) {
        console.log(req.params.name )

        User.findOne({name: req.params.name},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json({msg: data.region + " , " + data.address})
        })
    },
    savelocation: function (req , res) {
        
        User.findOneAndUpdate(
            { name: req.body.name }, { latitude: req.body.latitude, longitude: req.body.longitude, region: req.body.region,address:req.body.address },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "updated" });
    },  
    d_user: function (req) {
        User.findOneAndDelete(
            { name: req.body.name }, (err) => {
                console.log(err);
            }
        )
        console.log("deleted successfully");
        return res.send({ status: "deleted" });
    },
    getcategory: function (req , res) {
        Category.find({},{name:1,image:1},(error,data)=>{
            if (error) throw error;
            return res.json(data)
        })
    },
    getservice: function (req , res) {
        Serice.find({},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    },
    getorder: function (req , res) {
        console.log(req.body.clientname);

        order.find({clientname: req.params.clientname,$nor:[{status:"تم التقييم"}, {status:"تم الالغاء"}]},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    } ,
    cancelrequest: function (req , res) {
        
        order.findOneAndUpdate(
            { _id:req.params._id }, { status:"تم الالغاء" },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "cancelled" });
    },
    getspacificorder: function (req , res) {
        console.log(req.params.name )
         order.findOne({_id: req.params._id},(error,data)=>{
            if (error) throw error ;
            console.log(data)
            return res.json({worker:data.worker,time: data.time ,address: data.address ,service: data.service ,category: data.category,})

        })
    },
     getworkernameandphonenumber:function (req , res) {
        Worker.findOne({_id: req.params._id},(error,data)=>{
            if (error) throw error ;
            return res.json({name: data.name ,phonenumber: data.phonenumber})

        }) 
    },
    rateorder: function (req , res) {
        
        order.findOneAndUpdate(
            { _id: req.params._id }, {rating:req.body.rating,status:"تم التقييم"},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "ratted" });
    },
    getworkers:function (req , res) {
        console.log(req.params.region);

        Worker.find({category: req.params.category,region:req.params.region},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    },
    addtimeforworker: function (req , res) {
        console.log("req.params._id");
        console.log(req.body.time)
         Worker.findOneAndUpdate({_id:req.params._id},{$push:{time:req.body.time}},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else { 
                    console.log(data); 
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "updated"   }); 
    },
    removetimeforworker: function (req , res) {
        console.log("req.params._id");
        console.log(req.params.time)
         Worker.findOneAndUpdate({_id:req.params._id},{$pull:{time:req.params.time}},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else { 
                    console.log(data); 
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "updated"   }); 
    },
    getworkerinfo: function (req , res) {
        Worker.findOne(
            { phonenumber: req.params.phonenumber },
             (error, data) => {
                if (error) throw error
                console.log(data);
                return res.json({region: data.region ,name: data.name ,category: data.category,about:data.about,_id:data._id});

            }
        )
        console.log("you are in updated function");
    },  
    updateworkerinfo:function (req , res) {
        // if(!req.body.password){
        //     return res.status(403).send({ success: false, msg: 'Authentication failed, enter password' })

        // }
            Worker.findOne({
                phonenumber: req.params.phonenumber
            }, function (err, worker) {
                if (err) throw err
                    worker.comparePassword(req.body.password, function (err, isMatch) {
                        if (isMatch && !err) {
                            var token = jwt.encode(worker, config.secret)
                         //   res.json({ success: true, token: token })
                            if(!req.body.category){
                                Worker.findOneAndUpdate(
                                    { phonenumber: req.params.phonenumber }, { 
                                        name: req.body.name,  region: req.body.region,about:req.body.about },
                                     (error, data) => {
                                        if (error) {
                                            console.log(error);
                                        } else {
                                            console.log(data); 
                                        }
                                    }
                                )
                                console.log("you are in updated function");
                                return res.send({ msg: "تم التحديث بنجاح",token:token });}
                                else{
                                    Worker.findOneAndUpdate(
                                        { phonenumber: req.params.phonenumber }, { 
                                            name: req.body.name,  region: req.body.region,about:req.body.about ,category:req.body.category },
                                         (error, data) => {
                                            if (error) {
                                                console.log(error);
                                            } else {
                                                console.log(data);
                                            }
                                        } 
                                    )
                                    console.log("you are in updated function");
                                    return res.send({ msg: "تم التحديث بنجاح" ,token:token });
                                }
                        }
                        else {
                            console.log("data");

                            return res.send({ success: false, msg: 'قم بادخال كلمة السر' })
                        }
                    })
                
            }
            )
           
    },   
    getworkerid:function (req , res) {
        console.log(req.params.phonenumber )
        Worker.findOne({phonenumber: req.params.phonenumber},(error,data)=>{
            if (error) throw error ;
            console.log(data)
            return res.json({_id: data._id})

        })
    },
    getworkerorders: function (req , res) {
        console.log(req.params.worker);

        order.find({worker: req.params.worker, status:"قيد الانتظار"},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    } ,
    acceptrequest: function (req , res) {
        
        order.findOneAndUpdate(
            { _id:req.params._id }, { status:"قيد التنفيذ" },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "قيد التنفيذ" });
    }, 
    getclientnameandphonenumber:function (req , res) {
        console.log(req.params.name )
        User.findOne({name: req.params.name},(error,data)=>{
            if (error) throw error ;
            console.log(data)
            return res.json({phonenumber: data.phonenumber,longitude:data.longitude,latitude:data.latitude})

        })
    }, 
    getassignedorder: function (req , res) {
        console.log(req.body.worker);

        order.find({worker: req.params.worker,$or:[{status:"قيد التنفيذ"},{status:'بدء التنفيذ'},{status:'تمت'}]},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    },
    getworkername:function (req , res) {
       console.log(req.params.phonenumber)
        Worker.findOne({phonenumber: req.params.phonenumber},(error,data)=>{
            if (error) throw error ;
            console.log(data)
            return res.json({name: data.name })

        }) 
    },
    endrequest: function (req , res) {
        
        order.findOneAndUpdate(
            { _id:req.params._id }, { status:"تمت" ,durationTime:req.body.durationTime},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "انتهى" });
    },

    startrequest: function (req , res) {
        
        order.findOneAndUpdate(
            { _id:req.params._id }, { status:"بدء التنفيذ" },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "بدء" });
    },
    getlast10times:function (req , res) {
        console.log(order.find({ service:req.params.service ,status:'تمت'}).sort({_id:1}).limit(10));
        order.find({ service:req.params.service },(error,data)=>{
            return res.send({status:"success",msg:data});
        }).sort({_id:1}).limit(10);
        
    },
    changeestimatedtime: function (req , res) {
        Serice.findOneAndUpdate(
            { service:req.params.service }, { estimatedTime:req.body.estimatedTime },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "success" });
    },
    getworkerrate:function (req , res) {
        console.log(order.find({ worker:req.params.worker }).sort({_id:1}));
        order.find({ worker:req.params.worker },(error,data)=>{
            return res.send({status:"success",msg:data});
        }).sort({_id:1});
        
    },
    changeworkerrate: function (req , res) {
        Worker.findOneAndUpdate(
            { _id:req.params._id }, { rating:req.body.rating },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "success" });
    },
    newpassforclient: function (req , res) {
        
        order.findOneAndUpdate(
            { name:req.params.name,password:req.body.oldpass }, { password:req.body.password},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "success" });
},
get3bestworker:function (req , res) {
    Worker.find({ },(error,data)=>{
        return res.json(data);
    }).sort({rating:-1}).limit(4);
    
},
gettodaysorder:function (req , res) {
    order.find({status:'قيد الانتظار' },(error,data)=>{
        return res.json(data);
    });
    
},  
d_order: function (req) {
    order.findOneAndDelete(
        { _id: req.params._id }, (err) => {
            console.log(err);
        }
    )
    console.log("deleted successfully");
    return res.send({ status: "deleted" });
},  
getcountorder:function (req , res) {
    order.find(  (error,data)=>{
        return res.json(data);
    }).count();
    
},
getcountworker:function (req , res) {
    Worker.find(  (error,data)=>{
        return res.json(data);
    }).count();
    
},
getcountclient:function (req , res) {
    User.find(  (error,data)=>{
        return res.json(data);
    }).count();
    
},
getadminname:function (req , res) {
    Manager.findOne( {phonenumber:req.params.phonenumber}, (error,data)=>{
        if (error) throw error ;
        return res.json(data.name);
    });
    
},
getcountorderbycategory:function (req , res) {
    console.log(req.params.category)
    order.find( {category:req.params.category}, (error,data)=>{
        return res.json(data);
    }).count();
    
},
mgetworkers:function (req , res) {
    Worker.find((error,data)=>{
        if (error) throw error;
        console.log(data)
        return res.json(data)
    })
},
mgetclients:function (req , res) {
    User.find((error,data)=>{
        if (error) throw error;
        console.log(data)
        return res.json(data)
    })
}, 
getcountclientorder:function (req , res) {
    console.log(req.params.clientname)
    order.find( {clientname:req.params.clientname}, (error,data)=>{
        return res.json(data);
    }).count();
    
}, 
d_service: function (req) {
    Serice.findOneAndDelete(
        { _id: req.params._id }, (err) => {
            console.log(err);
        }
    )
    console.log("deleted successfully");
    return res.send({ status: "deleted" });
}, 
mgetorders:function (req , res) {
    order.find((error,data)=>{
        if (error) throw error;
        console.log(data)
        return res.json(data)
    }).sort({_id:1})
},
}


module.exports = functions