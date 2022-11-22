// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

/* const lightCodeTheme = require('prism-react-renderer/themes/github'); */
/* const darkCodeTheme = require('prism-react-renderer/themes/dracula'); */
const codeTheme = require("./src/theme/code-theme");
const socials = require("./socials");

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "LunarVim",
  url: "https://lunarvim.org",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/lunarvim_icon.png",
  trailingSlash: false,

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "lunarvim", // Usually your GitHub org/user name.
  projectName: "lunarvim", // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en", "de", "es"],
    localeConfigs: {
      en: {
        label: "English",
      },
      de: {
        label: "Deutsch",
      },
      es: {
        label: "Español",
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
            "https://github.com/LunarVim/lunarvim.org/tree/master/",
          versions: {
            current: {
              label: 'master',
              path: 'master',
            },
          },
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            "https://github.com/LunarVim/lunarvim.org/tree/master/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  customFields: {
    taglineList: [
      "Interstellar Development Experience",
      "Neovim in <Space>",
      "Houston, how do I exit?",
      "A community driven IDE for Neovim",
      "The Neovim config from another world",
      "The IDE that's too cool for planet Earth",
      "A stellar Neovim experience",
      "The universe's most lightweight IDE",
      "No-Configuration-Required Neovim",
      "Support for +10 Languages"
    ],
    primaryCTA: {
      text: "Install",
      to: "/docs/installation",
    },
    // secondary call to action is optional
    secondaryCTA: {
      text: "Support",
      to: "/donate",
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
        type: "video",
        id: "NPmKRygD7DU",
        title: "Neovim v0.8 release",
      },
      {
        type: "video",
        id: "sFA9kX-Ud_c",
        title: "Install LunarVim Stable Release",
      },
      {
        type: "playlist",
        id: "PLhoH5vyxr6QoYP4bKw0krF4aEn_3_pfWA",
        title: "LunarVim (IDE for Neovim)",
      },
    ],
    Contributors: {
      owner: "LunarVim",
      repos: ["LunarVim", "lunarvim.org", "starter.lvim",],
    },
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
            docId: "installation",
            position: "left",
            label: "Docs",
          },
          { to: "/blog", label: "Blog", position: "left" },
          {
            position: "left",
            to: "/donate",
            label: "Donate",
          },
          ...socials,
          {
            type: 'docsVersionDropdown',
            position: 'right',
            dropdownActiveClassDisabled: true,
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
        additionalLanguages: [
          "lua",
          "markup",
          "javascript",
          "css",
          "bash",
          "powershell",
          "python",
        ],
      },
      announcementBar: {
        id: 'new_release_1.2',
        content: 'New Release! <a target="_blank" rel="noopener noreferrer" href="https://github.com/LunarVim/LunarVim">install</a>',
        backgroundColor: 'var(--primary-fg)',
        textColor: 'var(--primary-bg)',
        isCloseable: true,
      },
    }),
  plugins: [
    [
      "./plugins/asciinema",
      {
        casts_folder: "static/casts",
        font_name: "glyphs.ttf",
        source_font: "src/theme/fura_code_nerd.ttf",
      },
    ],
    [
      require.resolve("@easyops-cn/docusaurus-search-local"),
      ({
        hashed: true,
        language: ["en", "es", "de"],
        indexDocs: true,
        indexBlog: false,
        indexPages: false,
        explicitSearchResultPath: true
      }),
    ],
  ],
};

module.exports = config;
