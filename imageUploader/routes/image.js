const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("path");
const isLoggedIn = require("../middleware/isLoggedIn");

const storage = multer.diskStorage({
  destination: "./public/uploads/",
  filename: function (req, file, cb) {
    cb(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});

const upload = multer({
  storage: storage,
  limits: { fileSize: 2000000 }, // 2MB max file size
}).single("image");

router.get("/upload", isLoggedIn, (req, res) => {
  res.render("upload");
});

router.post("/upload", isLoggedIn, (req, res) => {
  upload(req, res, (err) => {
    if (err) {
      console.error(err);
      res.render("upload", { msg: "Error uploading file" });
    } else {
      if (req.file == undefined) {
        res.render("upload", { msg: "No file selected" });
      } else {
        res.render("upload", {
          msg: "File uploaded successfully",
          file: `uploads/${req.file.filename}`,
        });
      }
    }
  });
});

module.exports = router;
