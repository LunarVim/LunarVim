import React from "react";
import styles from "./styles.module.css";

const Clouds = ({ children }) => (
  <div className={styles.preview}>{children}</div>
);

export default Clouds;
