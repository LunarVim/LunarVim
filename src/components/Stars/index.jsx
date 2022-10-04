import React, { useContext } from "react";
import { AnimationsContext } from "../../hooks/useAnimations";
import styles from "./styles.module.css";

//get random number between min and max
const randomNumber = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const STAR_SIZES = [1, 1, 2, 3, 4]; // in px

const Stars = ({ children, starsCount = 75, FALLING_STARS_COUNT = 0 }) => {
  const { animate } = useContext(AnimationsContext);

  return <div className={styles.starsContainer}>
    {/* generating array with length = STARS_COUNT */}
    { animate ? [...Array(starsCount)].map((_, i) => {
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
    }) : null}
    {/* generating array with length = FALLING_STARS_COUNT */}
    { animate ? [...Array(FALLING_STARS_COUNT)].map((_, i) => (
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
    )) : null }
    {children}
  </div>
};

export default Stars;
