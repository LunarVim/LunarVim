import React from "react";
import styles from "./styles.module.css";

// star sizes in px
const SIZES = [1, 1, 2, 3, 4];
// stars count
const COUNT = 100;

//get random position
function randomNumber(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

const Stars = ({ children }) => (
  <div className={styles.starsContainer}>
    {/* generating array with length = count */}
    {[...Array(COUNT)].map((_, i) => {
      /* randomize position and size */
      const top = randomNumber(1, 100);
      const left = randomNumber(1, 100);
      const size = SIZES[Math.floor(Math.random() * SIZES.length)];

      return (
        <div
          key={i}
          className={styles.star}
          style={{
            position: "absolute",
            top: `${top}%`,
            left: `${left}%`,
            height: `${size}px`,
            width: `${size}px`,
            animationDelay: `${randomNumber(2, 6)}s`,
            animationDuration: `${randomNumber(2, 6)}s`,
          }}
        />
      );
    })}
    {children}
  </div>
);

export default Stars;
