const fs = require("fs");
const path = require("path");

module.exports = {
  base: "/LunarVim.com/",
  themeConfig: {
    home: "/",
    logo: "/assets/lunarvim_logo.png",
    navbar: [
      {
        text: "Getting Started",
        link: "/",
      },
      {
        text: "Languages",
        link: "/languages/",
      },
      {
        text: "Modules",
        link: "/modules/",
      },
      {
        text: "For Devs",
        link: "/dev/",
      },
      {
        text: "Community",
        link: "/community/",
      },
      {
        text: "Sponsors",
        link: "/sponsors/",
      },
    ],
    repo: "https://github.com/ChristianChiarulli/LunarVim",

    docsRepo: "https://github.com/LunarVim/LunarVim.com",
    docsBranch: "master",
    docsDir: "docs",
    editLinkPattern: ":repo/-/edit/:branch/:path",
    sidebar: {
      "/": getSideBar("/", "Getting Started", true),
      "/languages/": getSideBar("languages", "Supported Languages", true),
      "/modules/": getSideBar("modules", "Lunar Modules", true),
      "/dev/": getSideBar("dev", "For Developers", true),
      "/community/": getSideBar("community", "Community", true),
      "/sponsors/": getSideBar("sponsors", "Sponsors", true),
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
