const mysql=require('mysql');
const fs = require('fs-extra');
const ip="http://192.168.1.11/"
var dir=__dirname.split("\\")

const conn =mysql.createPool({
    connectionLimit:10,
    password:"",
    user:"root",
    database:"el_eman_system",
    host:"localhost",
    port:'3306'

});
let DARK_DB={};

//////////////////// start of user schema//////////////////////////////////////////
DARK_DB.all_User=()=>{
    return new Promise((resolve,rejected)=>{

conn.query('SELECT * FROM `user`',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.SET_User=(User_name,Password,dep)=>{
    return new Promise((resolve,rejected)=>{
      
      
conn.query(`INSERT INTO user(username, password, dep) VALUES ('${User_name}','${Password}','${dep}')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.one_User=(username,password)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `user` WHERE username="'+username+'" AND password="'+password+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.change_password=(username,oldpassword,newpassword)=>{
    return new Promise((resolve,rejected)=>{
conn.query('UPDATE `user` SET `password`="'+newpassword+'" WHERE `username`="'+username+'" AND `password`="'+oldpassword+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.change_Name=(username,password,newusername)=>{
    return new Promise((resolve,rejected)=>{
conn.query('UPDATE `user` SET `username`="'+newusername+'" WHERE `username`="'+username+'" AND `password`="'+password+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.Delete_User=(username,password)=>{
    return new Promise((resolve,rejected)=>{
conn.query('DELETE FROM `user` WHERE `username`="'+username+'" AND `password`="'+password+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.Delete_User_by_Name=(username)=>{
    return new Promise((resolve,rejected)=>{
conn.query('DELETE FROM `user` WHERE `username`="'+username+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

//////////////////// end of user schema//////////////////////////////////////////
//////////////////// start of storage schema//////////////////////////////////////////
DARK_DB.all_Item=()=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `storage`',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.get_Item=(item_ID,name)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `storage` WHERE `item_ID`='+item_ID+' AND `name`="'+name+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};


DARK_DB.SET_item=(item_ID,name,status,image)=>{
    return new Promise((resolve,rejected)=>{
        

      var pathme="/server/multi_media/Storage/"+name+item_ID
      fs.mkdirSync("."+pathme);
      fs.move("./server/multi_media/Storage/"+image[0].originalname, "."+pathme+"/"+image[0].originalname, err => {});
      pathme=ip+dir[dir.length-3]+"/server/multi_media/Storage/"+name+item_ID
conn.query(`INSERT INTO storage(item_ID, name, status,image) VALUES (${item_ID},'${name}','${status}','${pathme+"/"+image[0].originalname}')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.change_status=(item_ID,name,status)=>{
    return new Promise((resolve,rejected)=>{
conn.query('UPDATE `storage` SET `status`="'+status+'" WHERE `item_ID`='+item_ID+' AND `name`="'+name+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.change_image=(item_ID,name,image)=>{
    var pathme="/server/multi_media/Storage/"+name+item_ID
    fs.move("./server/multi_media/Storage/"+image[0].originalname, "."+pathme+"/"+image[0].originalname, err => {});
    var newpath=ip+dir[dir.length-3]+pathme+"/"+image[0].originalname
    return new Promise((resolve,rejected)=>{
conn.query('UPDATE `storage` SET `image`="'+newpath+'" WHERE `item_ID`='+item_ID+' AND `name`="'+name+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};


DARK_DB.change_name=(item_ID,name,new_name)=>{
   
    return new Promise((resolve,rejected)=>{
conn.query('UPDATE `storage` SET `name`="'+new_name+'" WHERE `item_ID`='+item_ID+' AND `name`="'+name+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        var pathme="/server/multi_media/Storage/"+name+item_ID
        var pathme2="/server/multi_media/Storage/"+new_name+item_ID
        fs.renameSync("."+pathme,"."+pathme2);
        return resolve(result);
    }
});
    });
};

DARK_DB.Delete_item=(item_ID,name)=>{
    return new Promise((resolve,rejected)=>{
conn.query('DELETE FROM `storage` WHERE `item_ID`='+item_ID+' AND `name`="'+name+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        var pathme="/server/multi_media/Storage/"+name+item_ID

        fs.rmdirSync("."+pathme,{recursive:true})
        return resolve(result);
    }
});
    });
};
//////////////////// end of storage schema//////////////////////////////////////////
//////////////////// start of HR schema//////////////////////////////////////////
DARK_DB.all_hr=()=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `hr`',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.all_project_hr=()=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `hr` WHERE `Sub_Headers` ="" AND multi_media=""',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.create_HR=(project_ID,Sub_Header,multi_media)=>{
    return new Promise((resolve,rejected)=>{

      var pathme="/server/multi_media/HR/"+project_ID
      fs.mkdirSync("."+pathme);
      if(Sub_Header.includes(":")){
        var folders=Sub_Header.split(":")
        var sub=""
        for(var i=0;i<folders.length-1;i++){
            pathme=pathme+"/"+folders[i]
            
            sub=sub+folders[i]+":"
            if(!fs.existsSync("."+pathme)){

                fs.mkdirSync("."+pathme);
                
                conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${sub}','')`,(err,result)=>{
    if(err){
        // return rejected(err);
    }else{
        console.log("done/hr/create")
    }
});

                
            }
         
        }
        
    }else{
        
        console.log(Sub_Header);
        pathme=pathme+"/"+Sub_Header
        if(!fs.existsSync("."+pathme)){
            fs.mkdirSync("."+pathme);


            conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${Sub_Header+":"}','')`,(err,result)=>{
                if(err){
                    // return rejected(err);
                }else{
                    console.log("done/hr/create")
                }
            });
        }
   
    }
      

      fs.move("./server/multi_media/HR/"+multi_media[0].originalname, "."+pathme+"/"+multi_media[0].originalname, err => {});
      pathme=ip+dir[dir.length-3]+pathme
conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${Sub_Header}','${pathme+"/"+multi_media[0].originalname}')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.create_project_HR=(project_ID)=>{
    return new Promise((resolve,rejected)=>{

      var pathme="/server/multi_media/HR/"+project_ID
      fs.mkdirSync("."+pathme);


     
conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'','')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.addmulti=(project_ID,Sub_Header,multi_media)=>{
    return new Promise((resolve,rejected)=>{
var pathme="/server/multi_media/HR/"+project_ID
    if(Sub_Header.includes(":")){
        var folders=Sub_Header.split(":")
        var sub=""
        for(var i=0;i<folders.length-1;i++){
            pathme=pathme+"/"+folders[i]
            sub=sub+folders[i]+":"
            if(!fs.existsSync("."+pathme)){
                fs.mkdirSync("."+pathme);
                
                conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${sub}','')`,(err,result)=>{
                    if(err){
                        // return rejected(err);
                    }else{
                        console.log("done/hr/addmulti")
                    }
                });
            }
         
        }
        
        
    }else{
        
        console.log(Sub_Header);
        pathme=pathme+"/"+Sub_Header
        if(!fs.existsSync("."+pathme)){
            fs.mkdirSync("."+pathme);

            conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${Sub_Header+":"}','')`,(err,result)=>{
                if(err){
                    // return rejected(err);
                }else{
                    console.log("done/hr/addmulti")
                }
            });
        }
   
    }
     fs.move("./server/multi_media/HR/"+multi_media[0].originalname, "."+pathme+"/"+multi_media[0].originalname, err => {});
     pathme=ip+dir[dir.length-3]+pathme
conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${Sub_Header}','${pathme+"/"+multi_media[0].originalname}')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
     });
};




DARK_DB.add_subheader=(project_ID,Sub_Header)=>{
    return new Promise((resolve,rejected)=>{
var pathme="/server/multi_media/HR/"+project_ID
    if(Sub_Header.includes(":")){
        var folders=Sub_Header.split(":")
        var sub=""
        for(var i=0;i<folders.length-2;i++){
            pathme=pathme+"/"+folders[i]
            sub=sub+folders[i]+":"
            console.log(pathme)
            if(!fs.existsSync("."+pathme)){
                fs.mkdirSync("."+pathme);

                conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${sub}','')`,(err,result)=>{
                    if(err){
                        // return rejected(err);
                    }else{
                        console.log("done/hr/add_subheader")
                    }
                });
            }
         
        }
        
        
        pathme=pathme+"/"+folders[i]
        if(!fs.existsSync("."+pathme)){
        fs.mkdirSync("."+pathme);}
        
    }else{
        
        console.log(Sub_Header);
        pathme=pathme+"/"+Sub_Header
        if(!fs.existsSync("."+pathme)){
            fs.mkdirSync("."+pathme);
            conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${Sub_Header}','')`,(err,result)=>{
                if(err){
                    // return rejected(err);
                }else{
                    console.log("done/hr/add_subheader")
                }
            });
        }
   
    }
    

conn.query(`INSERT INTO hr(project_ID, Sub_Headers, multi_media) VALUES (${project_ID},'${Sub_Header}','')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
     });
};

DARK_DB.get_subheader=(project_ID,Sub_Header)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `hr` WHERE `Sub_Headers` like "%'+Sub_Header+'%"  AND project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};


DARK_DB.get_project_subheader=(project_ID)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `hr` WHERE NOT `Sub_Headers` = "" AND `multi_media`="" AND project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};



DARK_DB.get_project=(project_ID)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `hr` WHERE project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.change_multimedia=(project_ID,Sub_Header,add,multi_media)=>{
    return new Promise((resolve,rejected)=>{
var pathme="/server/multi_media/HR/"+project_ID
    if(Sub_Header.includes(":")){
        var folders=Sub_Header.split(":")
        
        for(var i=0;i<folders.length-1;i++){
            pathme=pathme+"/"+folders[i]         
        }
        
    }else{
        
        pathme=pathme+"/"+Sub_Header.replace(":","")
   
    }
     fs.move("./server/multi_media/HR/"+multi_media[0].originalname, "."+pathme+"/"+multi_media[0].originalname, err => {});
     pathme=ip+dir[dir.length-3]+pathme
conn.query('UPDATE `hr` SET `multi_media`="'+pathme+"/"+multi_media[0].originalname+'" WHERE `multi_media`="'+add+'" AND `Sub_Headers`="'+Sub_Header+'" AND project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
     });
};



DARK_DB.Delete_subheader=(project_ID,Sub_Header)=>{
    return new Promise((resolve,rejected)=>{
        var pathme="/server/multi_media/HR/"+project_ID
conn.query('DELETE FROM `hr` WHERE `Sub_Headers` like "%'+Sub_Header+'%" AND project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        if(Sub_Header.includes(":")){
            var folders=Sub_Header.split(":")
            
            for(var i=0;i<folders.length;i++){
                pathme=pathme+"/"+folders[i]
                
             
            }

            
        }else{
            
            console.log(Sub_Header);
            pathme=pathme+"/"+Sub_Header
            }
        fs.rmdirSync("."+pathme,{recursive:true})
        return resolve(result);


    }
});
    });
};
DARK_DB.Delete_multi_media=(project_ID,Sub_Header,multi_media)=>{
    return new Promise((resolve,rejected)=>{
        
conn.query('DELETE FROM `hr` WHERE `Sub_Headers` ="'+Sub_Header+'" AND `multi_media`="'+multi_media+'" AND project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{

        multi_media=multi_media.replace(ip,"")
        multi_media=multi_media.replace(dir[dir.length-3],"")
        fs.rmdirSync("."+multi_media,{recursive:true})
        return resolve(result);


    }
});
    });
};

DARK_DB.Delete_project_HR=(project_ID)=>{
    return new Promise((resolve,rejected)=>{
        var pathme="/server/multi_media/HR/"+project_ID
conn.query('DELETE FROM `hr` WHERE project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
      
        fs.rmdirSync("."+pathme,{recursive:true})
        return resolve(result);


    }
});
    });
};
//////////////////// end of HR schema//////////////////////////////////////////
//////////////////// start of tech schema//////////////////////////////////////////
DARK_DB.all_tech=()=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `tech`',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.get_all_project=()=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `tech` WHERE `sub_header` =""  AND `multi_media`="" ',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};



DARK_DB.create_tech=(project_ID,project_Name,Sub_Header,multi_media)=>{ 
    return new Promise((resolve,rejected)=>{
        

      var pathme="/server/multi_media/tech/"+project_ID+project_Name
      fs.mkdirSync("."+pathme);

      if(Sub_Header.includes(":")){
        var folders=Sub_Header.split(":")
        var sub=""
        
        for(var i=0;i<folders.length-1;i++){
            pathme=pathme+"/"+folders[i]
            sub=sub+folders[i]+":"
            if(!fs.existsSync("."+pathme)){
                
                fs.mkdirSync("."+pathme);
                conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_ID},'${project_Name}','${sub}','')`,(err,result)=>{
                    if(err){
                        // return rejected(err);
                    }else{
                        // return resolve(result);
                        console.log("doneeee")
                    }
                });
                
            }
         
        }
        
    }else{
        
        console.log(Sub_Header);
        pathme=pathme+"/"+Sub_Header
        if(!fs.existsSync("."+pathme)){
            fs.mkdirSync("."+pathme);
            conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_ID},'${project_Name}','${Sub_Header+":"}','')`,(err,result)=>{
                if(err){
                    return rejected(err);
                }else{
                    return resolve(result);
                }
            });
        }
   
    }

    // pathme="/server/multi_media/tech/"+project_ID+project_Name+"/"+Sub_Header
    //   fs.mkdirSync("."+pathme);

      fs.move("./server/multi_media/tech/"+multi_media[0].originalname, "."+pathme+"/"+multi_media[0].originalname, err => {});
      pathme=ip+dir[dir.length-3]+pathme
conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_ID},'${project_Name}','${Sub_Header}','${pathme+"/"+multi_media[0].originalname}')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};
DARK_DB.create_project_tech=(project_ID,project_Name)=>{
    return new Promise((resolve,rejected)=>{

      var pathme="/server/multi_media/tech/"+project_ID+project_Name
      fs.mkdirSync("."+pathme);
   
   
conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_ID},'${project_Name}','','')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};


DARK_DB.add_multi_tech=(project_id,project_Name,sub_header,multi_media)=>{
    return new Promise((resolve,rejected)=>{
var pathme="/server/multi_media/tech/"+project_id+project_Name
    if(sub_header.includes(":")){
        var folders=sub_header.split(":")
        var sub=""
        
        for(var i=0;i<folders.length-1;i++){
            pathme=pathme+"/"+folders[i]
            sub=sub+folders[i]+":"
            if(!fs.existsSync("."+pathme)){
                
                fs.mkdirSync("."+pathme);
                conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_id},'${project_Name}','${sub}','')`,(err,result)=>{
                    if(err){
                        // return rejected(err);
                    }else{
                        // return resolve(result);
                        console.log("doneeee")
                    }
                });
                
            }
         
        }
        
    }else{
        
        console.log(sub_header);
        pathme=pathme+"/"+sub_header
        if(!fs.existsSync("."+pathme)){
            fs.mkdirSync("."+pathme);
            conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_id},'${project_Name}','${sub_header+":"}','')`,(err,result)=>{
                if(err){
                    return rejected(err);
                }else{
                    return resolve(result);
                }
            });
        }
   
    }
     fs.move("./server/multi_media/tech/"+multi_media[0].originalname, "."+pathme+"/"+multi_media[0].originalname, err => {});
     pathme=ip+dir[dir.length-3]+pathme
conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_id},'${project_Name}','${sub_header}','${pathme+"/"+multi_media[0].originalname}')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
     });
};

DARK_DB.add_subheaders_tech=(project_id,project_Name,sub_header)=>{
    return new Promise((resolve,rejected)=>{
var pathme="/server/multi_media/tech/"+project_id+project_Name
    if(sub_header.includes(":")){
        var folders=sub_header.split(":")
        var sub=""
        for(var i=0;i<folders.length-2;i++){
            pathme=pathme+"/"+folders[i]
            sub=sub+folders[i]+":"
            if(!fs.existsSync("."+pathme)){

                fs.mkdirSync("."+pathme);
                conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_id},'${project_Name}','${sub}','')`,(err,result)=>{
                    if(err){
                        // return rejected(err);
                    }else{
                        // return resolve(result);
                        console.log("doneeee")
                    }
                });
            
            }
         
        }
        pathme=pathme+"/"+folders[i]
        if(!fs.existsSync("."+pathme)){
        fs.mkdirSync("."+pathme);}
        
    }else{
        
        console.log(sub_header);
        pathme=pathme+"/"+sub_header
        if(!fs.existsSync("."+pathme)){
            fs.mkdirSync("."+pathme);
        }
   
    }
    
conn.query(`INSERT INTO tech(project_id,project_Name,sub_header,multi_media) VALUES (${project_id},'${project_Name}','${sub_header}','')`,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
     });
};



DARK_DB.get_subheader_tech=(project_ID,project_Name,Sub_Header)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `tech` WHERE `sub_header` like "'+Sub_Header+'%" AND `project_Name`="'+project_Name+'" AND `project_id`='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};

DARK_DB.get_project_subheader_tech=(project_ID,project_Name)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `tech` WHERE NOT `sub_header` ="" AND `multi_media`=""  AND `project_Name`="'+project_Name+'" AND `project_id`='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};



DARK_DB.get_project_tech=(project_ID,project_Name)=>{
    return new Promise((resolve,rejected)=>{
conn.query('SELECT * FROM `tech` WHERE project_id='+ project_ID+' AND `project_Name`="'+project_Name+'"',(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
    });
};


DARK_DB.change_multimedia_tech=(project_ID,project_Name,Sub_Header,add,multi_media)=>{
    return new Promise((resolve,rejected)=>{
var pathme="/server/multi_media/tech/"+project_ID+project_Name
    if(Sub_Header.includes(":")){
        var folders=Sub_Header.split(":")
        
        for(var i=0;i<folders.length-1;i++){
            pathme=pathme+"/"+folders[i]         
        }
        
    }else{
        
        pathme=pathme+"/"+Sub_Header
   
    }
     fs.move("./server/multi_media/tech/"+multi_media[0].originalname, "."+pathme+"/"+multi_media[0].originalname, err => {});
     pathme=ip+dir[dir.length-3]+pathme
conn.query('UPDATE `tech` SET `multi_media`="'+pathme+"/"+multi_media[0].originalname+'" WHERE `multi_media`="'+add+'" AND `sub_header`="'+Sub_Header+'" AND project_Name="'+project_Name+'" AND project_id='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        return resolve(result);
    }
});
     });
};


DARK_DB.Delete_subheader_tech=(project_ID,project_Name,Sub_Header)=>{
    return new Promise((resolve,rejected)=>{
        var pathme="/server/multi_media/tech/"+project_ID+project_Name
conn.query('DELETE FROM `tech` WHERE `sub_header` like "%'+Sub_Header+'%" AND project_Name="'+project_Name+'" AND project_id='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        if(Sub_Header.includes(":")){
            var folders=Sub_Header.split(":")
            
            for(var i=0;i<folders.length;i++){
                pathme=pathme+"/"+folders[i]
                
             
            }

            
        }else{
            
            console.log(Sub_Header);
            pathme=pathme+"/"+Sub_Header
            }
        fs.rmdirSync("."+pathme,{recursive:true})
        return resolve(result);


    }
});
    });
};


DARK_DB.Delete_multi_tech=(project_ID,project_Name,Sub_Header,multi_media)=>{
    return new Promise((resolve,rejected)=>{
conn.query('DELETE FROM `tech` WHERE `sub_header` = "'+Sub_Header+'" AND project_Name="'+project_Name+'"AND `multi_media`="'+multi_media+'" AND project_id='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
        multi_media= multi_media.replace(ip,"")
        multi_media=multi_media.replace(dir[dir.length-3],"")
        
        fs.rmdirSync("."+multi_media,{recursive:true})
        return resolve(result);


    }
});
    });
};


DARK_DB.Delete_project_tech=(project_ID,project_Name)=>{
    return new Promise((resolve,rejected)=>{
        var pathme="/server/multi_media/tech/"+project_ID+project_Name
conn.query('DELETE FROM `tech` WHERE project_Name="'+project_Name+'" AND project_ID='+ project_ID,(err,result)=>{
    if(err){
        return rejected(err);
    }else{
      
        fs.rmdirSync("."+pathme,{recursive:true})
        return resolve(result);


    }
});
    });
};


//////////////////// end of tech schema//////////////////////////////////////////


module.exports=DARK_DB;