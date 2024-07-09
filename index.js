var express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
var app = express();
var connection = require('./database');
var { spawn } = require('child_process');

const url = "http://localhost:5173/"

app.use(cors());
const corsOptions = {
    //origin: 'http://localhost:5173', // Allow requests from this origin
    optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
};




app.use(cors(corsOptions));
app.use(express.json());



const serviceAccount = require('D:/Firebase_Docfind_serviceapi/cinema-app-caa49-firebase-adminsdk-x51b3-2724dd654c.json');



admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});


const transporter = nodemailer.createTransport({
    service: 'Gmail', 
    port : 465,
    secure :true,
    logger : true,
    
    auth: {
        user: 'qamarsohaib251@gmail.com',
        pass: 'mvcfnwlkcszqgciq'
    },
    tls :{
        rejectUnauthorized: true
    }
});



function sendCustomPasswordResetEmail(userEmail, displayName, link) {
    const mailOptions = {
        from: 'qamarsohaib251@gmail.com',
        to: userEmail,
        subject: 'Password Reset Request',
        text: `Hello ${displayName},\n\nYou requested a password reset. Click the link below to reset your password:\n\n${link}\n\nIf you did not request this, please ignore this email.\n\nThank you.`
    };

    return transporter.sendMail(mailOptions);
}




app.post('/generate-password-reset-link', async (req, res) => {
    const { email,name } = req.body;

    if (!email) {
        return res.status(400).json({ error: 'Email is required' });
    }

    try {
        const user = await admin.auth().getUserByEmail(email);
        const resetLink = await admin.auth().generatePasswordResetLink(email, {
            url: `http://localhost:5173/Login`, // URL to redirect to after the reset
        });

        await sendCustomPasswordResetEmail(email, name, resetLink);

        res.status(200).json({ message: 'Password reset link sent to your email' });
    } catch (error) {
        console.error('Error generating password reset link:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});




app.post('/read/details' , function(req,res){

    const {id} = req.body;
    let sql = 'select *from Details where id = ?';
    connection.query(sql,[id],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});



app.post('/read/details/doctorprofile' , function(req,res){

    const {name} = req.body;
    let sql = 'select Details.name,Details.speciality,DoctorInfo.patients,DoctorInfo.experience,DoctorInfo.rating,DoctorInfo.about_doctor from Details inner join DoctorInfo on Details.name = DoctorInfo.doc_name where Details.name = ? ';
    connection.query(sql,[name],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});


app.post('/read/details/doctorprofile2' , function(req,res){

    const {name} = req.body;
    let sql = 'select *from DoctorInfo where doc_name = ?';
    connection.query(sql,[name],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});

app.post('/read/appointments' , function(req,res){

    const {name} = req.body;
    let sql = 'select *from Doc_Appointments where doct_name = ?';
    connection.query(sql,[name],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});

app.post('/add/userdata' , function(req,res){

    const {pname,age,email,mobile_number} = req.body;
    let sql = 'INSERT INTO userdata (pname, age, email,mobile_number) VALUES (?, ?, ?, ?)';
    connection.query(sql,[pname,age,email,mobile_number],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});

app.post('/add/notifications' , function(req,res){

    const {patientname,doctor_name,timing} = req.body;
    let sql = 'INSERT INTO Notifications(patientname,doctor_name,timing) VALUES (?, ?, ?)';
    connection.query(sql,[patientname,doctor_name,timing],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});



app.post('/read/notifications' , function(req,res){

    const {patientname} = req.body;
    let sql = 'select *from Notifications where patientname = ?';
    connection.query(sql,[patientname],function(err,results){
        if(err) throw err;
        res.send(results);
    })
});





app.listen(3030, function () {
    console.log('Connected to server at 3030');
    connection.connect(function (err) {
        if (err) throw err;
        console.log('Database Connected');
    });
})

