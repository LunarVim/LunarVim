import React from "react";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import styles from "./styles.module.css";

const Preview = () => {
  const { siteConfig } = useDocusaurusContext();
  return (
    <div className={styles.preview}>
      <div className={`container ${styles.container}`}>
        <img
          src={siteConfig.customFields.previewImg.src}
          alt={siteConfig.customFields.previewImg.alt}
        />
      </div>
    </div>
  );
};

export default Preview;
