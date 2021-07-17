const fs = require("fs");
const path = require("path");

module.exports = {
  themeConfig: {
    home: "/getting-started/",
    logo: "/assets/lunarvim_logo.png",
    navbar: [
      {
        text: "Getting Started",
        link: "/getting-started/01-introduction.html",
      },
      {
        text: "Languages",
        link: "/languages/01-languages.html",
      },
      {
        text: "Modules",
        link: "/modules/01-modules.html",
      },
      {
        text: "For Devs",
        link: "/dev/01-lua-resources.html",
      },
      {
        text: "Community",
        link: "/community/01-links.html",
      },
      {
        text: "Sponsors",
        link: "/sponsors/01-thank-you.html",
      },
    ],
    repo: "https://github.com/ChristianChiarulli/LunarVim",

    docsRepo: "https://github.com/LunarVim/LunarVim.com",
    docsBranch: "master",
    docsDir: "docs",
    editLinkPattern: ":repo/-/edit/:branch/:path",
    sidebar: {
      "/getting-started": getSideBar(
        "/getting-started",
        "Getting Started",
        false
      ),
      "/languages/": getSideBar("languages", "Supported Languages", false),
      "/modules/": getSideBar("modules", "Lunar Modules", false),
      "/dev/": getSideBar("dev", "For Developers", false),
      "/community/": getSideBar("community", "Community", false),
      "/sponsors/": getSideBar("sponsors", "Sponsors", false),
    },
  },
};

function getSideBar(folder, title, include_readme) {
  const extension = [".md"];

  const files = fs
    .readdirSync(path.join(`${__dirname}/../${folder}`))
    .filter(
      (file) =>
        file.toLocaleLowerCase() != "readme.md" &&
        fs.statSync(path.join(`${__dirname}/../${folder}`, file)).isFile() &&
        extension.includes(path.extname(file))
    );

  if (include_readme) {
    files.unshift("README.md");
  }

  return [{ text: title, children: files }];
}
