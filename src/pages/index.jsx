import React from "react";
import clsx from "clsx";
import Link from "@docusaurus/Link";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Layout from "@theme/Layout";
import HomepageFeatures from "@site/src/components/HomepageFeatures";
import Stars from "../components/Stars";
import styles from "./index.module.css";
import Preview from "@site/src/components/Preview";

function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <header className={clsx("hero hero--primary", styles.heroBanner)}>
      <div className={`container ${styles.container}`}>
        <div className={styles.heroContent}>
          <h1 className="hero__title">{siteConfig.title}</h1>
          <p className="hero__subtitle">{siteConfig.tagline}</p>
          <div className={styles.buttons}>
            <Link
              className="button button--primary button--lg"
              to={siteConfig.customFields.primaryCTA.to}
            >
              {siteConfig.customFields.primaryCTA.text}
            </Link>
            {siteConfig.customFields.secondaryCTA ? (
              <Link
                className="button button--outline button--lg"
                to={siteConfig.customFields.secondaryCTA.to}
              >
                {siteConfig.customFields.secondaryCTA.text}
              </Link>
            ) : null}
          </div>
        </div>
        <div className={styles.heroImage}>
          <img
            src={siteConfig.customFields.heroImage.src}
            alt={siteConfig.customFields.heroImage.alt}
          />
        </div>
      </div>
    </header>
  );
}

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={siteConfig.title}
      description="Description will go into a meta tag in <head />"
    >
      <Stars>
        <HomepageHeader />
      </Stars>
      <main>
        <Preview />
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
