import React from "react";
import Translate from "@docusaurus/Translate";
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
          <h1 className="hero__title"><Translate>LunarVim</Translate></h1>
          <p className="hero__subtitle"><Translate>Cool slogan about LunarVim</Translate></p>
          <div className={styles.buttons}>
            <Link
              className="button button--primary button--lg"
              to={siteConfig.customFields.primaryCTA.to}
            >
              <Translate>Install</Translate>
            </Link>
            {siteConfig.customFields.secondaryCTA ? (
              <Link
                className="button button--outline button--lg"
                to={siteConfig.customFields.secondaryCTA.to}
              >
                <Translate>Support</Translate>
              </Link>
            ) : null}
          </div>
        </div>
        <div className={styles.heroImage}>
          <img
            src={require('@site/static/img/lunarvim_logo.png').default}
            alt={siteConfig.customFields.heroImage.alt}
          />
        </div>
      </div>
    </header >
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
      <Stars>
        <HomepageFeatures />
      </Stars>
      </main>
    </Layout>
  );
}
