import React from "react";
import ContributorsList from "react-contributors";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import './styles.css';

const Contributors = () => {
  const { siteConfig: { customFields: { Contributors:  { owner, repos } } } } = useDocusaurusContext();
  return <div className="container">
    <h1 className="title">LunarVim Contributors</h1>
    <ContributorsList owner={owner} repo={repos} />
  </div>
};

export default Contributors;
