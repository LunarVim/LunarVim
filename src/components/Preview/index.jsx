import React, { useState } from "react";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import useBaseUrl from '@docusaurus/useBaseUrl';
import styles from "./styles.module.css";
import Clouds from "../Clouds/";

const Preview = () => {
  const {
    siteConfig: {
      customFields: { previewImgs },
    },
  } = useDocusaurusContext();

  const [previewIdx, setPreviewIdx] = useState(0);
  const imgsCount = previewImgs.length;

  const nextImg = () => {
    if (previewIdx === imgsCount - 1) {
      setPreviewIdx(0);
    } else {
      setPreviewIdx((current) => current + 1);
    }
  };

  const prevImg = () => {
    if (previewIdx === 0) {
      setPreviewIdx(imgsCount - 1);
    } else {
      setPreviewIdx((current) => current - 1);
    }
  };

  return (
    <Clouds>
      <div className={`container ${styles.container}`}>
        <div className={styles.slider}>
          <img
            src={useBaseUrl(previewImgs[previewIdx].src)}
            alt={previewImgs[previewIdx].alt}
            loading="lazy"
          />
        </div>
        <div className={styles.dots}>
          {previewImgs.map((_, idx) => (
            <button
              key={idx}
              onClick={() => setPreviewIdx(idx)}
              className={`${styles.dot} ${idx === previewIdx ? styles.active : null
                }`}
            />
          ))}
        </div>
        <button className={`${styles.btn} ${styles.prev}`} onClick={prevImg}>
          <Arrow />
        </button>
        <button className={`${styles.btn} ${styles.next}`} onClick={nextImg}>
          <Arrow />
        </button>
      </div>
    </Clouds>
  );
};

const Arrow = (props) => (
  <svg width="29" height="30" viewBox="0 0 18 19" fill="none" {...props}>
    <path
      d="M4.5 7.05497L9 11.7325L13.5 7.05497"
      stroke="white"
      strokeWidth="1.5"
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </svg>
);

export default Preview;
