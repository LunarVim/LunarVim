import React from "react";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import styles from "./styles.module.css";
import "./flickity.css"
import Flickity from "react-flickity-component";

const flickityOptions = {
  initialIndex: 0,
  contain: true,
  pageDots: false,
  fullscreen: true,
  lazyLoad: 1,
  autoPlay: false,
  prevNextButtons: true,
}

const Preview = () => {
  const { siteConfig } = useDocusaurusContext();
  return (
    <div className={styles.preview}>
      <div className={`container ${styles.container}`}>
        <Flickity
          className={styles.carousel} // default ''
          elementType={"div"} // default 'div'
          options={flickityOptions} // takes flickity options {}
          disableImagesLoaded={false} // default false
          reloadOnUpdate // default false
          static
        >
          {siteConfig.customFields.previewImgs.map((img, idx) => (
            <div key={img.src + idx}>
              <img src={img.src} alt={img.alt} loading="lazy" />
            </div>
          ))}
        </Flickity>
      </div>
    </div>
  );
};

export default Preview;
