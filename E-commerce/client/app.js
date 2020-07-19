var express = require('express');
var exphbs = require('express-handlebars');
var bodyParser = require('body-parser');
var session = require('express-session');
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
const bcrypt = require('bcryptjs');
 const { forwardAuthenticated } = require('./config/auth');
const flash = require('connect-flash');




var multer = require('multer')
var upload = multer({ dest: 'uploads/' })

var mongoose = require('mongoose');
var Schema = mongoose.Schema;
mongoose.connect('mongodb://localhost/project');
var productSchema = new Schema({
    product_name:{
         type: String
        //required: true
    },
    brand:{
        type: String
        //required: true
    },
        price:{
            type: Number
            //required: true
        },
    stock:{
        type: String
        //required: true
    },
    img: {
        type: String
        //required: true
    },
    description: {
        type: String
        //required: true
    }, 
       type: {
        type: String
        //required: true
    }
});

var orderSchema = new Schema({
    name: {
        type: String
        //required: true
    },
    email: {
        type: String
        //required: true
      },
    phone:{
        type: Number
        //required: true
    },
    address: {
        type: String
        //required: true
    },
    payment: {
        type: String
        //required: true
    },
    product: {
        type: String
        //required: true
    }
});
var userSchema = new Schema({
    username: {
        type: String
        //required: true
    },
    email: {
        type: String
        //required: true,
        // unique: true
    },
    password: {
        type: String
        //required: true
    }

});
// Connect to MongoDB
// mongoose
//   .connect(
//     db,
//     { useNewUrlParser: true }
//   )
//   .then(() => console.log('MongoDB Connected'))
//   .catch(err => console.log(err))


// exporting the schema in the form of model
var product = mongoose.model('product', productSchema);
var order = mongoose.model('order', orderSchema);
var User=mongoose.model('user',userSchema);
var app = express();


app.engine('handlebars', exphbs({ defaultLayout: 'main' }));
app.set('view engine', 'handlebars');

app.use(express.static('public'));

// Express body parser
app.use(express.urlencoded({ extended: true }));

// Express session
app.use(
  session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
  })
);

// Passport Middleware
app.use(passport.initialize());
app.use(passport.session());


app.use(flash());
app.use(function(req,res,next){
  res.locals.success_msg=req.flash('success_msg');
  res.locals.error_msg=req.flash('error_msg');
  res.locals.error=req.flash('error');
  next();
});
app.get('/', function(req, res) {
    product.find({}, function(err, products) {
        if (err) throw err;
        console.log(products)
        res.render('home', { product: products });

    });
});

app.get('/brand/:brand_name', function(req, res) {
    var brand_name = req.params.brand_name;
    product.find({
        brand: brand_name
    }, function(err, products) {
        if (err) throw err;
        res.render('category', { product: products });

    });

});

app.get('/category/:type', function(req, res) {
    var type = req.params.type;
    product.find({
        type: type
    }, function(err, products) {
        if (err) throw err;
        res.render('category', { product: products });

    });

});

app.get('/category/:type/brand/:brand_name', function(req, res) {
    var type = req.params.type;
    var brand_name = req.params.brand_name;
    product.find({
        type: type,
        brand: brand_name
    }, function(err, products) {
        if (err) throw err;
        res.render('category', { product: products });

    });

});

app.get('/product/:id', function(req, res) {
    var id = req.params.id;
    var brand_name = req.params.brand_name;
    product.find({
        _id: id,
    }, function(err, products) {
        if (err) throw err;
        res.render('eachproduct', { product: products[0] });

    });

});

// Login Page
app.get('/login', forwardAuthenticated, (req, res) => res.render('login'));

// Register Page
app.get('/register', forwardAuthenticated, (req, res) => res.render('register'));

// Register
app.post('/register', (req, res) => {
  const { username, email, password, password2 } = req.body;
  let errors = [];

  if (!username || !email || !password || !password2) {
    errors.push({ msg: 'Please enter all fields' });
  }

  if (password != password2) {
    errors.push({ msg: 'Passwords do not match' });
  }

  if (password.length < 6) {
    errors.push({ msg: 'Password must be at least 6 characters' });
  }

  if (errors.length > 0) {
    res.render('register', {
      errors,
      username,
      email,
      password,
      password2
    });
  } else {
    User.findOne({ email: email }).then(user => {
      if (user) {
        errors.push({ msg: 'Email already exists' });
        res.render('register', {
          errors,
          username,
          email,
          password,
          password2
        });
      } else {
        const newUser = new User({
          username,
          email,
          password
        });

        bcrypt.genSalt(10, (err, salt) => {
          bcrypt.hash(newUser.password, salt, (err, hash) => {
            if (err) throw err;
            newUser.password = hash;
            newUser
              .save()
              .then(user => {
                req.flash(
                  'success_msg',
                  'You are now registered and can log in'
                );
                res.redirect('/login');
              })
              .catch(err => console.log(err));
          });
        });
      }
    });
  }
});
module.exports = {
    ensureAuthenticated: function(req, res, next) {
      if (req.isAuthenticated()) {
        return next();
      }
    },
    forwardAuthenticated: function(req, res, next) {
      if (!req.isAuthenticated()) {
        return next();
      }
      res.redirect('/');      
    }
  };
    

 
module.exports = function(passport) {
    passport.use(
      new LocalStrategy({ usernameField: 'email' }, (email, password, done) => {
        // Match user
        User.findOne({
          email: email
        }).then(user => {
          if (!user) {
            return done(null, false, { message: 'That email is not registered' });
          }
  
          // Match password
          bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) throw err;
            if (isMatch) {
              return done(null, user);
            } else {
              return done(null, false, { message: 'Password incorrect' });
            }
          });
        });
      })
    );
  
//     passport.serializeUser(function(user, done) {
//       done(null, user.id);
//     });
  
    passport.deserializeUser(function(id, done) {
      User.findById(id, function(err, user) {
        done(err, user);
      });
    });
  };

  passport.use(new LocalStrategy(
    function(username, password, done) {
      User.findOne({ username: username }, function(err, user) {
        if (err) { return done(err); }
        if (!user) {
            return done(null, false, { message: 'Incorrect username.' });
          }
  
          if (user.password != password) {
            return done(null, false, { message: 'Incorrect password.' });
          }
        return done(null, user);
      });
    }
  ));
// Login
app.post('/login', (req, res, next) => {
  passport.authenticate('local', {
    successRedirect: '/login',
    failureRedirect: '/',
    failureFlash: true
  })(req, res, next);
s});

app.get('/cart', function(req, res) {
    res.render('cart');
    
});
app.post('/buy_now', function(req, res) {
    console.log(req.body)
    var neworder = order(
        req.body
    );
    neworder.save(function(err, data) {
        if (err) throw err;
        res.json({ a: 1 });
    });
});

app.get('/order_placed', function(req, res) {
    res.render('success');
});


app.listen(8000, function() {
    console.log('Example app listening on port 8000!');
});