import React from "react";
import styles from "./styles.modules.css";
import Link from "@docusaurus/Link";

const LanguagesList = [
  {
    Svg: require("@site/static/img/hcl.svg").default,
    title: "HCL",
    docPath: "/docs/languages/hcl",
  },
  {
    Svg: require("@site/static/img/terraform.svg").default,
    title: "Terraform",
    docPath: "/docs/languages/Terraform",
  },
  {
    Svg: require("@site/static/img/c.svg").default,
    title: "C",
    docPath: "/docs/languages/c_cpp",
  },
  {
    Svg: require("@site/static/img/cpp.svg").default,
    title: "C++",
    docPath: "/docs/languages/c_cpp",
  },
  {
    Svg: require("@site/static/img/csharp.svg").default,
    title: "C#",
    docPath: "/docs/languages/csharp",
  },
  {
    Svg: require("@site/static/img/go.svg").default,
    title: "Go",
    docPath: "/docs/languages/go",
  },
  {
    Svg: require("@site/static/img/java.svg").default,
    title: "Java",
    docPath: "/docs/languages/java",
  },
  {
    Svg: require("@site/static/img/javascript.svg").default,
    title: "JavaScript",
    docPath: "/docs/languages/javascript",
  },
  {
    Svg: require("@site/static/img/json.svg").default,
    title: "JSON",
    docPath: "/docs/languages/json",
  },
  {
    Svg: require("@site/static/img/julia.svg").default,
    title: "Julia",
    docPath: "/docs/languages/julia",
  },
  {
    Svg: require("@site/static/img/lua.svg").default,
    title: "Lua",
    docPath: "/docs/languages/lua",
  },
  {
    Svg: require("@site/static/img/powershell.svg").default,
    title: "PowerShell",
    docPath: "/docs/languages/powershell",
  },
  {
    Svg: require("@site/static/img/python.svg").default,
    title: "Python",
    docPath: "/docs/languages/python",
  },
  {
    Svg: require("@site/static/img/qml.svg").default,
    title: "QML",
    docPath: "/docs/languages/qml",
  },
  {
    Svg: require("@site/static/img/ruby.svg").default,
    title: "Ruby",
    docPath: "/docs/languages/ruby",
  },
  {
    Svg: require("@site/static/img/rust.svg").default,
    title: "Rust",
    docPath: "/docs/languages/rust",
  },
  {
    Svg: require("@site/static/img/scala.svg").default,
    title: "Scala",
    docPath: "/docs/languages/scala",
  },
  {
    Svg: require("@site/static/img/swift.svg").default,
    title: "Swift",
    docPath: "/docs/languages/swift",
  },
  {
    Svg: require("@site/static/img/typescript.svg").default,
    title: "TypeScript",
    docPath: "/docs/languages/typescript",
  },
  {
    Svg: require("@site/static/img/vue.svg").default,
    title: "Vue",
    docPath: "/docs/languages/vue",
  },
];

const Languages = () => {
  return (
    <section>
      <div className={`container ${styles.container}`}>
        <h1 className={styles.title}>Languages Setup</h1>
        <div className={styles.languages}>
          {LanguagesList.map((lang) => (
            <Language key={lang.title} {...lang} />
          ))}
        </div>
      </div>
    </section>
  );
};

const Language = ({ Svg, title, docPath }) => (
  <Link to={docPath}>
    <div className={styles.lang}>
      <Svg role="img" />
      <h3>{title}</h3>
    </div>
  </Link>
);

export default Languages;
