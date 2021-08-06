const fs = require("fs");
const path = require("path");

module.exports = {
  // base: "/LunarVim.com/",
  lang: "en-US",
  title: "LunarVim Docs",
  description: "Documentation for LunarVim",
  head: [["link", { rel: "icon", href: "/assets/lunarvim_logo.png" }]],
  home: "/languages",

  themeConfig: {
    logo: "/assets/lunarvim_logo.png",
    navbar: [
      {
        text: "Getting Started",
        link: "/",
      },
      {
        text: "Configuration",
        link: "/configuration/",
      },
      {
        text: "Languages",
        link: "/languages/",
      },
      {
        text: "Plugins",
        link: "/plugins/",
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
    repo: "https://github.com/LunarVim/LunarVim",

    docsRepo: "https://github.com/LunarVim/LunarVim.com",
    docsBranch: "master",
    docsDir: "docs",
    // editLinkPattern: ":repo/-/edit/:branch/:path",
    sidebar: {
      "/": getSideBar("/", "Getting Started", true),
      "/configuration/": getSideBar("configuration", "Configuration"),
      "/languages/": getSideBar("languages", "Languages", true),
      "/plugins/": getSideBar("plugins", "Plugins", true),
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
