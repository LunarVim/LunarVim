# LunarVim.com
Website for LunarVim

module.exports = {
  lang: "en-US",
  title: "LunarVim to the Moon!",
  description: "This is my first VuePress site",

  themeConfig: {
    logo: "https://vuejs.org/images/logo.png",
    docsBranch: "master",
    docsDir: "docs",
    sidebar: {
      "/docs/": [
        "", // this is your docs/README.md
        // all sub-items here (I explain later)
      ],
      "/": [
        // Your fallback (this is your landing page)
        "", // this is your README.md (main)
      ],
    },
    sidebarDepth: 2,
  },
};
