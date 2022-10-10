import React, { useState, useEffect } from "react";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import styles from "./index.module.css";
import Translate from "@docusaurus/Translate";

const Slogan = () => {
  const { siteConfig: { customFields: { taglineList } } } = useDocusaurusContext();
  const [{sloganText, currentSloganIdx, currentTaglineIdx}, setAnimation] = useState({sloganText: "" , currentSloganIdx: 0 , currentTaglineIdx: 0 })
  const TYPING_SPEED = 115;
  const WAIT_DURATION = 2500;

  useEffect(() => {
    const typewriterEffect = () => {
      if ( currentSloganIdx - 3 === taglineList[currentTaglineIdx].length) {
        setTimeout(() => {
          setAnimation({ sloganText: "", currentTaglineIdx: (currentTaglineIdx === taglineList.length - 1 ? 0 : currentTaglineIdx + 1), currentSloganIdx: 0 })
        }, WAIT_DURATION)
      } else {
        setAnimation({currentSloganIdx: currentSloganIdx +  1, sloganText: taglineList[currentTaglineIdx].substring(0, currentSloganIdx), currentTaglineIdx: currentTaglineIdx});
      }
    };

    const timeout = setTimeout(typewriterEffect, TYPING_SPEED);
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
