import React, { useContext, useEffect, useState } from "react";
import { AnimationsContext } from "../../hooks/useAnimations";
import Translate from "@docusaurus/Translate";
import clsx from "clsx";
import Link from "@docusaurus/Link";
import styles from "./index.module.css";
import Stars from "../Stars";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import ShootingStar from "../Icons/ShootingStar";
import DisabledStar from "../Icons/DisabledStar";
import Slogan from "./Slogan";

const Hero = () => {
  const { siteConfig: { customFields: { primaryCTA, secondaryCTA, heroImage } } } = useDocusaurusContext();
  const { animate, setAnimate } = useContext(AnimationsContext);

  return (
    <Stars FALLING_STARS_COUNT={3}>
      <button className={styles.toggleAnimations} onClick={() => setAnimate(currentState => !currentState)}>
        {animate ?
          <DisabledStar /> :
          <ShootingStar />
        }
      </button>

      <header className={clsx("hero hero--primary", styles.heroBanner)}>
        <div className={`container ${styles.container}`}>
          <div className={styles.heroContent}>
            <h1 className={`hero__title ${styles.heroTitle}`}>LunarVim</h1>
            <Slogan />
            <div className={styles.buttons}>
              <Link
                className="button button--primary button--lg"
                to={primaryCTA.to}
              >
                <Translate>{primaryCTA.text}</Translate>
              </Link>
              {secondaryCTA ? (
                <Link
                  className="button button--outline button--lg"
                  to={secondaryCTA.to}
                >
                  <Translate>{secondaryCTA.text}</Translate>
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
