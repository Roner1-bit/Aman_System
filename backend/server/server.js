const express=require("express");
const API_routes=require("./Routes");
const app=express();
const cors = require('cors');


app.use(express.json());
app.use(cors());
app.use("/D",API_routes);
app.listen(process.env.PORT|| '3000',()=>{
console.log(`Server is running on port: ${process.env.PORT|| '3000'}`); 
});