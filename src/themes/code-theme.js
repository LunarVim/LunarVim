const theme = {
  plain: {
    color: "var(--normal-white)",
    backgroundColor: "var(--normal-black)",
  },
  styles: [
    {
      types: ["prolog", "constant", "builtin", "important", "deleted", "type", "attr-name"],
      style: {
        color: "var(--normal-red)",
      }
    },
    {
      types: ["inserted", "function"],
      style: {
        color: "var(--normal-cyan)",
      }
    },
    {
      types: ["changed"],
      style: {
        color: "var(--normal-yellow)",
      }
    },
    {
      types: ["punctuation", "symbol"],
      style: {
        color: "var(--normal-green)",
      }
    },
    {
      types: ["string", "char", "selector"],
      style: {
        color: "var(--normal-green)",
      }
    },
    {
      types: ["keyword", "variable", "boolean", "number"],
      style: {
        color: "var(--normal-magenta)",
        fontStyle: "italic",
      }
    },
    {
      types: ["comment"],
      style: {
        color: "var(--normal-white)",
      }
    },
    {
      types: ["tag"],
      style: {
        color: "var(--normal-blue)",
      }
    }
  ]
};

module.exports = theme;
