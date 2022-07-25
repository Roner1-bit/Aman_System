const express=require("express");
const DB=require("../DB");
const router=express.Router();
const multer=require('multer');
const fs = require('fs');


  var storage = multer.diskStorage({
    destination: (req, file, cb) => {
        
        var pathme="./server/multi_media/Storage/"
        // fs.mkdirSync(pathme);
        
     cb(null, pathme);
     },
     filename: (req, file, cb) => {
       let photo = `${file.originalname}`
       req.body.photo = photo
      cb(null, photo);
   },
  });
  var storage2 = multer.diskStorage({
    destination: (req, file, cb) => {
        
        var pathme="./server/multi_media/HR/"
        // fs.mkdirSync(pathme);
        
     cb(null, pathme);
     },
     filename: (req, file, cb) => {
       let photo = `${file.originalname}`
       req.body.photo = photo
      cb(null, photo);
   },
  });
  var storage3 = multer.diskStorage({
    destination: (req, file, cb) => {
        
        var pathme="./server/multi_media/tech/"
        // fs.mkdirSync(pathme);
        
     cb(null, pathme);
     },
     filename: (req, file, cb) => {
       let photo = `${file.originalname}`
       req.body.photo = photo
      cb(null, photo);
   },
  });
  var uploading2 = multer({
    storage:storage2
   })

  var uploading = multer({
    storage:storage
   })
  var uploading3 = multer({
    storage:storage3
   })
//////////////////// start of user tabel//////////////////////////////////////////
router.get('/All/Users', async (req,res,next)=>{
    try{
        let result =await DB.all_User();
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
router.post('/set/Users', async (req,res,next)=>{
    try{
        let result =await DB.SET_User(req.body.username,req.body.password,req.body.dep);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.post('/get/User', async (req,res,next)=>{
    try{
        let result =await DB.one_User(req.body.username,req.body.password);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.patch('/change/password', async (req,res,next)=>{
    try{
        let result =await DB.change_password(req.body.username,req.body.oldpassword,req.body.newpassword);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
router.patch('/change/UserName', async (req,res,next)=>{
    try{
        let result =await DB.change_Name(req.body.username,req.body.password,req.body.newusername);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
router.delete('/delete/user', async (req,res,next)=>{
    try{
        let result =await DB.Delete_User(req.body.username,req.body.password);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

//////////////////// end of user tabel//////////////////////////////////////////
//////////////////// start of storage tabel//////////////////////////////////////////
router.get('/All/storage', async (req,res,next)=>{
    try{
        let result =await DB.all_Item();
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.post('/get/storage', async (req,res,next)=>{
    try{
        let result =await DB.get_Item(req.body.item_ID,req.body.name);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
var f=uploading.fields([{name:"item_image",maxCount:1}])
router.post('/set/item',f, async (req,res,next)=>{
    try{
        let result =await DB.SET_item(req.body.item_ID,req.body.name,req.body.status,req.files['item_image']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});


router.patch('/change/status', async (req,res,next)=>{
    try{
        let result =await DB.change_status(req.body.item_ID,req.body.name,req.body.status);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
router.patch('/change/image', f,async (req,res,next)=>{
    try{
        let result =await DB.change_image(req.body.item_ID,req.body.name,req.files['item_image']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
router.patch('/change/name',async (req,res,next)=>{
    try{
        let result =await DB.change_name(req.body.item_ID,req.body.name,req.body.new_name);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.delete('/delete/item', async (req,res,next)=>{
    try{
        let result =await DB.Delete_item(req.body.item_ID,req.body.name);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
//////////////////// end of storage tabel//////////////////////////////////////////
//////////////////// start of HR tabel//////////////////////////////////////////
router.get('/All/hr', async (req,res,next)=>{
    try{
        let result =await DB.all_hr();
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
var H=uploading2.fields([{name:"multi_media",maxCount:1}])
router.post('/set/hr',H, async (req,res,next)=>{
    try{
        let result =await DB.create_HR(req.body.project_ID,req.body.Sub_Header,req.files['multi_media']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
var H=uploading2.fields([{name:"multi_media",maxCount:1}])

router.post('/hr/add/multi',H, async (req,res,next)=>{
    try{
        let result =await DB.addmulti(req.body.project_ID,req.body.Sub_Header,req.files['multi_media']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.post('/hr/get/Sub_Header', async (req,res,next)=>{
    try{
        let result =await DB.get_subheader(req.body.project_ID,req.body.Sub_Header);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.post('/hr/get/project', async (req,res,next)=>{
    try{
        let result =await DB.get_project(req.body.project_ID);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});


router.patch('/hr/change/multimedia',H, async (req,res,next)=>{
    try{
        let result =await DB.change_multimedia(req.body.project_ID,req.body.Sub_Header,req.body.address,req.files['multi_media']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});



router.delete('/hr/delete/Sub_Header', async (req,res,next)=>{
    try{
        let result =await DB.Delete_subheader(req.body.project_ID,req.body.Sub_Header);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});



router.delete('/hr/delete/project', async (req,res,next)=>{
    try{
        let result =await DB.Delete_project_HR(req.body.project_ID);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
//////////////////// End of HR tabel//////////////////////////////////////////
//////////////////// Start of tech tabel//////////////////////////////////////////

router.get('/All/tech', async (req,res,next)=>{
    try{
        let result =await DB.all_tech();
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});
var T=uploading3.fields([{name:"multi_media",maxCount:1}])
router.post('/set/tech',T, async (req,res,next)=>{
    try{
        let result =await DB.create_tech(req.body.project_ID,req.body.project_Name,req.body.Sub_Header,req.files['multi_media']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});


router.post('/tech/add/multi',T, async (req,res,next)=>{
    try{                                    //project_id,project_Name,sub_header,multi_media
        let result =await DB.add_multi_tech(req.body.project_ID,req.body.project_Name,req.body.Sub_Header,req.files['multi_media']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});



router.post('/tech/get/Sub_Header', async (req,res,next)=>{
    try{
        let result =await DB.get_subheader_tech(req.body.project_ID,req.body.project_Name,req.body.Sub_Header);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

router.post('/tech/get/project', async (req,res,next)=>{
    try{
        let result =await DB.get_project_tech(req.body.project_ID,req.body.project_Name);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});


router.patch('/tech/change/multimedia',T, async (req,res,next)=>{
    try{
        let result =await DB.change_multimedia_tech(req.body.project_ID,req.body.project_Name,req.body.Sub_Header,req.body.address,req.files['multi_media']);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});


router.delete('/tech/delete/Sub_Header', async (req,res,next)=>{
    try{
        let result =await DB.Delete_subheader_tech(req.body.project_ID,req.body.project_Name,req.body.Sub_Header);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});



router.delete('/tech/delete/project', async (req,res,next)=>{
    try{
        let result =await DB.Delete_project_tech(req.body.project_ID,req.body.project_Name);
        res.json(result);
    }catch(e){
        console.log(e);
        res.sendStatus(500);
    }

});

//////////////////// end of tech tabel//////////////////////////////////////////
module.exports=router;