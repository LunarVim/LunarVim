import React from "react";
import styles from "./styles.module.css";

//get random number between min and max
const randomNumber = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const STAR_SIZES = [1, 1, 2, 3, 4]; // in px
const STARS_COUNT = 75;
const FALLING_STARS_COUNT = randomNumber(3, 4);

const Stars = ({ children }) => (
  <div className={styles.starsContainer}>
    {/* generating array with length = STARS_COUNT */}
    {[...Array(STARS_COUNT)].map((_, i) => {
      /* random and size */
      const size = STAR_SIZES[Math.round(Math.random() * STAR_SIZES.length)];

      return (
        <div
          key={i}
          className={styles.star}
          style={{
            position: "absolute",
            top: `${randomNumber(1, 100)}%`,
            left: `${randomNumber(1, 100)}%`,
            height: `${size}px`,
            width: `${size}px`,
            animationDuration: `${randomNumber(2, 6)}s`,
          }}
        />
      );
    })}
    {/* generating array with length = FALLING_STARS_COUNT */}
    {[...Array(FALLING_STARS_COUNT)].map((_, i) => (
      <div
        key={i}
        className={styles.fallingStar}
        style={{
          top: `${randomNumber(0, 30)}%`,
          left: `${randomNumber(0, 70)}%`,
          animationDelay: `${randomNumber(0, 5)}s`,
          animationDuration: `${randomNumber(10, 20)}s`,
        }}
      />
    ))}
    {children}
  </div>
);

export default Stars;
