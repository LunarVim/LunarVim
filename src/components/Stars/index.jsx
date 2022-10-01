import React from "react";
import styles from "./styles.module.css";

// sizes of star in px
const SIZES = [1, 1, 2, 3, 4];
// count of stars
const COUNT = 100;

//get random position
function randomPosition(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

const Stars = ({ children }) => (
  <div className={styles.starsContainer}>
    {/* generating array with length = count */}
    {[...Array(COUNT)].map((_, i) => {
      /* randomize position and size */
      const top = randomPosition(1, 100);
      const left = randomPosition(1, 100);
      const random = Math.floor(Math.random() * SIZES.length);
      const randomSize = SIZES[random];

      /* give the star different class name for different animations  */
      const num = i <= COUNT / 4 ? "star1" : i <= COUNT / 3 ? "star2" : i <= COUNT / 2 ? "star3" : "star4";

      return (
        <div
          key={i}
          className={`${styles.star} ${styles[num] || ""}`}
          style={{
            position: "absolute",
            top: top + "%",
            left: left + "%",
            height: randomSize + "px",
            width: randomSize + "px",
          }}
        />
      );
    })}
    {children}
  </div>
);

export default Stars;
