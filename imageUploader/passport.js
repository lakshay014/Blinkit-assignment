const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
const User = require("./models/User");
const config = require("./config");

passport.serializeUser(function (user, done) {
  done(null, user.id);
});

passport.deserializeUser(function (id, done) {
  User.findById(id, function (err, user) {
    done(err, user);
  });
});

passport.use(
  "local",
  new LocalStrategy(
    {
      usernameField: "username",
      passwordField: "password",
      passReqToCallback: true,
    },
    (req, username, password, done) => {
      User.findOne({ username: username }, (err, user) => {
        if (err) {
          return done(err);
        }
        if (!user || !user.validPassword(password)) {
          return done(null, false, { message: "Invalid username or password" });
        }
        return done(null, user);
      });
    }
  )
);

passport.use(
  "local-signup",
  new LocalStrategy(
    {
      usernameField: "username",
      passwordField: "password",
      passReqToCallback: true,
    },
    (req, username, password, done) => {
      process.nextTick(() => {
        User.findOne({ username: username }, (err, user) => {
          if (err) {
            return done(err);
          }
          if (user) {
            return done(null, false, { message: "Username already taken" });
          } else {
            const newUser = new User();
            newUser.username = username;
            newUser.password = newUser.generateHash(password);
            newUser.save((err) => {
              if (err) {
                throw err;
              }
              return done(null, newUser);
            });
          }
        });
      });
    }
  )
);
