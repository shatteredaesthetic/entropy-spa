module.exports = {
  config: {
    paths: {
      watched: ["app"]
    },
    files: {
      javascripts: {
        joinTo: "js/app.js"
      },
      stylesheets: {
        joinTo: "css/app.css"
      }
    },
    plugins: {
      elmBrunch: {
        mainModules: ["app/elm/Main.elm"],
        outputFolder: "public/js/"
      },
      elmCss: {
        sourcePath: "app/elm/Stylesheets.elm",
        outputDir: "public/css/",
        pattern: /Styles.elm/
      },
      sass: {
        mode: "native"
      }
    }
  }
};
