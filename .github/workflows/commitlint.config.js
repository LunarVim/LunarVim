module.exports = {
  rules: {
    "body-leading-blank": [1, "always"],
    "body-max-line-length": [2, "always", 100],
    "footer-leading-blank": [1, "always"],
    "footer-max-line-length": [2, "always", 100],
    "header-max-length": [2, "always", 72],
    "scope-case": [2, "always", "lower-case"],
    "subject-case": [
      2,
      "never",
      ["upper-case", "pascal-case", "sentence-case", "start-case"],
    ],
    "subject-empty": [2, "never"],
    "subject-full-stop": [2, "never", "."],
    "type-case": [2, "always", "lower-case"],
    "type-empty": [2, "never"],
    "type-enum": [
      2,
      "always",
      [
        "build",
        "chore",
        "ci",
        "docs",
        "feat",
        "fix",
        "perf",
        "refactor",
        "revert",
        "test",
      ],
    ],
  },
  /*
    add a custom parser to handle exclamation marks in a commit
    see: https://github.com/conventional-changelog/commitlint/issues/2226#issuecomment-911749509
  */
  parserPreset: {
    parserOpts: {
      headerPattern: /^(\w*)(?:\((.*)\))?!?: (.*)$/,
      referenceActions: null,
      issuePrefixes: ['ISS-'],
    },
  },
};
