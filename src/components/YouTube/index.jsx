import React from "react";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Clouds from "../Clouds";
import styles from "./styles.module.css";

const YouTube = () => {
  const {
    siteConfig: {
      customFields: { YouTube },
    },
  } = useDocusaurusContext();

  return (
    <Clouds>
      <section className={`container ${styles.container}`}>
        {YouTube.map((yt) => (
          <div key={yt.id} className={styles.yt}>
            <h2>{yt.title}</h2>
            <iframe
              loading="lazy"
              width="560"
              height="315"
              src={`https://www.youtube.com/embed/${yt.type === "playlist" ? `playlist?list=${yt.id}` : yt.id}`}
              title={yt.title}
              frameBorder="0"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowFullScreen
            ></iframe>
          </div>
        ))}
      </section>
    </Clouds>
  );
};

export default YouTube;
