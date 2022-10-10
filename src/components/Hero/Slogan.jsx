import React, { useState, useLayoutEffect } from "react";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import styles from "./index.module.css";
import Translate from "@docusaurus/Translate";

const Slogan = () => {
  const { siteConfig: { customFields: { tagline: taglineList } } } = useDocusaurusContext();
  const [{sloganText, currentSloganIdx, currentTaglineIdx}, setAnimation] = useState({sloganText: "" , currentSloganIdx: 0 , currentTaglineIdx: 0 })
  const TYPE_SPEED = 100;
  const READ_DURATION = 2500;

  useLayoutEffect(() => {
    const typewriterEffect = () => {
      if ( currentSloganIdx === taglineList[currentTaglineIdx].length - 1 ) {
        setTimeout(() => {
          setAnimation({
            sloganText: "",
            currentTaglineIdx: currentTaglineIdx + 1,
            currentSloganIdx: 0
          })
        }, READ_DURATION)
      } else {
        setAnimation({currentSloganIdx: currentSloganIdx +  1, sloganText: taglineList[currentTaglineIdx].substring(0, currentSloganIdx + 2), currentTaglineIdx: currentTaglineIdx});
      }
    };

    const timeout = setTimeout(typewriterEffect, TYPE_SPEED);

    return () => {
      clearTimeout(timeout);
    };
  }, [currentSloganIdx]);

  return (
    <p className={`hero__subtitle ${styles.slogan}`}>
      <Translate>{sloganText}</Translate>
    </p>
  );
};

export default Slogan;
