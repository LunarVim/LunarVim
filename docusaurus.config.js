// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

/* const lightCodeTheme = require('prism-react-renderer/themes/github'); */
/* const darkCodeTheme = require('prism-react-renderer/themes/dracula'); */
const codeTheme = require("./src/themes/code-theme");

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "LunarVim",
  tagline: "Cool Slogan about LunarVim",
  url: "https://lunarvim.org",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/lunarvim_icon.png",

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "lunarvim", // Usually your GitHub org/user name.
  projectName: "lunarvim", // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en", "de"],
    localeConfigs: {
      en: {
        label: "English",
      },
      de: {
        label: "Deutsch",
      },
    },
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            "https://github.com/lunarvim/lunarvim.org/tree/main/packages/create-docusaurus/templates/shared/",
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            "https://github.com/lunarvim/lunarvim.org/tree/main/packages/create-docusaurus/templates/shared/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  customFields: {
    primaryCTA: {
      text: "Install",
      to: "/docs/installation",
    },
    // secondary call to action is optional
    secondaryCTA: {
      text: "Support",
      to: "/docs/sponsors/donate",
    },
    heroImage: {
      src: "/img/lunarvim_logo.png",
      alt: "LunarVim Logo",
    },
    previewImgs: [
      {
        src: "/img/lunarvim_preview5.png",
        alt: "LunarVim Preview",
      },
      {
        src: "/img/lunarvim_preview.png",
        alt: "LunarVim Preview",
      },
      {
        src: "/img/lunarvim_preview2.png",
        alt: "LunarVim Preview",
      },
      {
        src: "/img/lunarvim_preview3.png",
        alt: "LunarVim Preview",
      },
      {
        src: "/img/lunarvim_preview4.png",
        alt: "LunarVim Preview",
      },
    ],
    YouTube: [
      /* NOTE: max 3 preferred */
      /* type: video | playlist */
      {
        type: "playlist",
        id: "PLhoH5vyxr6QoYP4bKw0krF4aEn_3_pfWA",
        title: "LunarVim (IDE for Neovim)",
      },
      {
        type: "video",
        id: "NPmKRygD7DU",
        title: "Neovim v0.8 release",
      },
      {
        type: "playlist",
        id: "PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ",
        title: "Neovim from Scratch",
      },
    ],
    Contributors: {
      owner: "LunarVim",
      repos: ["LunarVim.org"],
    }
  },

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: "dark",
      },
      image: "img/lunarvim_preview.png",
      navbar: {
        title: "LunarVim",
        logo: {
          alt: "LunarVim Logo",
          src: "img/lunarvim_icon.png",
        },
        hideOnScroll: false,
        items: [
          {
            type: "doc",
            docId: "introduction",
            position: "left",
            label: "Docs",
          },
          { to: "/blog", label: "Blog", position: "left" },
          {
            type: "doc",
            position: "left",
            docId: "sponsors/donate",
            label: "Donate",
          },
          {
            href: "https://twitter.com/chrisatmachine",
            position: "right",
            className: "navbar-icon navbar-icon-twitter",
          },
          {
            href: "https://www.reddit.com/r/lunarvim/",
            position: "right",
            className: "navbar-icon navbar-icon-reddit",
          },
          {
            href: "https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA",
            position: "right",
            className: "navbar-icon navbar-icon-youtube",
          },
          {
            href: "https://matrix.to/#/#the-machine:matrix.org",
            position: "right",
            className: "navbar-icon navbar-icon-matrix",
          },
          {
            href: "https://discord.gg/Xb9B4Ny",
            position: "right",
            className: "navbar-icon navbar-icon-discord",
          },
          {
            href: "https://github.com/lunarvim/lunarvim",
            position: "right",
            className: "navbar-icon navbar-icon-github",
          },
          {
            type: "localeDropdown",
            position: "right",
          },
        ],
      },
      prism: {
        theme: codeTheme,
        darkTheme: codeTheme,
      },
    }),
};

module.exports = config;
