const express = require("express");
const passport = require("passport");
const router = express.Router();

router.get("/login", (req, res) => {
  res.render("login");
});

router.post(
  "/login",
  passport.authenticate("local", {
    successRedirect: "/images/upload",
    failureRedirect: "/auth/login",
  })
);

router.get("/signup", (req, res) => {
  res.render("signup");
});

router.post(
  "/signup",
  passport.authenticate("local-signup", {
    successRedirect: "/images/upload",
    failureRedirect: "/auth/signup",
  })
);

router.get("/logout", (req, res) => {
  req.logout();
  res.redirect("/");
});

module.exports = router;
