import React, { useEffect } from "react";
import styles from "./styles.module.css";

const SIZES = [1, 1, 2, 3, 4];
const COUNT = 75;

//get random position
function randomPosition(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

export default function Stars({ children }) {
  useEffect(() => {
    for (let i = 0; i < 100; i++) {}
  }, []);

  return (
    <div className={styles.starsContainer}>
        {[...Array(COUNT)].map((_, i) => {
          const top = randomPosition(1, 100);
          const left = randomPosition(1, 100);
          const random = Math.floor(Math.random() * SIZES.length);
          const randomSize = SIZES[random];
          const num = i <= COUNT/4 ? "star1" : i <= COUNT/3 ? "star2" : "star3";
          return <div key={i} className={`${styles.star} ${styles[num]}`} style={{
            position: "absolute",
            top: top + "%",
            left: left + "%",
            height: randomSize + "px",
            width: randomSize + "px",
          }} />
        })}
      {children}
    </div>
  );
}
