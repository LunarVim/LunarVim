import React from "react";
import Translate from "@docusaurus/Translate";
import clsx from "clsx";
import Link from "@docusaurus/Link";
import styles from "./index.module.css";
import Stars from "../Stars";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";

const Hero = () => {
  const { siteConfig: { customFields: { primaryCTA, secondaryCTA, heroImage } } } = useDocusaurusContext();

  return (
    <Stars FALLING_STARS_COUNT={3}>
      <header className={clsx("hero hero--primary", styles.heroBanner)}>
        <div className={`container ${styles.container}`}>
          <div className={styles.heroContent}>
            <h1 className="hero__title">
              <Translate>LunarVim</Translate>
            </h1>
            <p className="hero__subtitle">
              <Translate>Cool slogan about LunarVim</Translate>
            </p>
            <div className={styles.buttons}>
              <Link
                className="button button--primary button--lg"
                to={primaryCTA.to}
              >
                <Translate>Install</Translate>
              </Link>
              {secondaryCTA ? (
                <Link
                  className="button button--outline button--lg"
                  to={secondaryCTA.to}
                >
                  <Translate>Support</Translate>
                </Link>
              ) : null}
            </div>
          </div>
          <div className={styles.heroImage}>
            <img
              src={require("@site/static/img/lunarvim_logo.png").default}
              alt={heroImage.alt}
            />
          </div>
        </div>
      </header>
    </Stars>
  );
};

export default Hero;
