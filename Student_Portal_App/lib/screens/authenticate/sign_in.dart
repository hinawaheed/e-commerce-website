import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/utilities/constants.dart';
class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
final AuthService _auth = AuthService();
final _formkey = GlobalKey<FormState>();
bool loading = false;

 String email = '';
 String password = '';
 String error  = ' ';

  @override

    
  Widget build(BuildContext context) {
    
    return loading ? Loading() : Scaffold(

      resizeToAvoidBottomPadding: false,
        
     
  body: Container(
    height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF73AEF5),
          Color(0xFF61A4F1),
          Color(0xFF478DE0),
          Color(0xFF398AE5),
                ],
        stops: [0.1, 0.4, 0.7, 0.12],
                  ),
                ),

        
                
    padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
     child: Form(
          key : _formkey,
          child: Column(
            children: <Widget>[
             Text('Sign In',style: TextStyle( color: Colors.white,fontFamily: 'OpenSans',fontSize: 30.0,fontWeight: FontWeight.bold,)),
              
             
              SizedBox(height: 20.0),
              Container(
            
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
      
                child: TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.only(top:12),
                  prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                  ),
                  hintText: "Enter your Email",
                  hintStyle: kHintTextStyle,
                  border:
                    
              OutlineInputBorder(borderRadius: BorderRadius.circular(0))
                    
                  ),
                  validator : (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val){
                    setState(() => email=val);
                  }

                ),
              ),


    
                
              SizedBox(height: 20.0),
                    
              Container(
                decoration: kBoxDecorationStyle,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                  prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                  ),
                
                  contentPadding: EdgeInsets.only(top: 12),
                  hintText: "Password",
                  hintStyle: kHintTextStyle,
                  
                 
                  border:
                    
              OutlineInputBorder(borderRadius: BorderRadius.circular(0))

                  ),
                    
                  validator : (val) => val.length <7  ? 'Enter a password that is 7+ character long' : null,
                  
                  onChanged: (val){
                    setState(() => password =val);
            },
                ),
              ),
              
              SizedBox(height: 20.0, ),
              
              Container(
                width: double.infinity,
                child: RaisedButton(
                  
                  elevation: 5.0,
                   shape: new RoundedRectangleBorder(
                   borderRadius: new BorderRadius.circular(10),
                   side: BorderSide(color: Colors.blue)),
                   color : Colors.white,
                  
                  child: Text(
                   'LOGIN ',
                   style: TextStyle(color: Color(0xFF527DAA),letterSpacing: 1.5,fontSize: 18.0,fontWeight: FontWeight.bold,fontFamily: 'OpenSans',), 
                   
                  ),
                  onPressed: () async {
                    
                    if ( _formkey.currentState.validate())
                    {
                      setState(() => loading = true);
                      dynamic result = await _auth.signinWithEP(email, password);
                      print('valid');
                      if( result == null)
                      {
                        setState((){
                          error = 'Eror signing in. Please Check Email and Password';
                          loading = false;
                        });
                      }
                    print(email);
                    print(password);
                    }
                  },
                ),
              ),
           SizedBox(height: 14.0),
              Text(
                error,
                style: TextStyle(color : Colors.white, fontSize : 14.0),
              ),
               ],),
        ),
      ) ,
    );
  }

  String getuserdata(){
    return(email);
  }
}
