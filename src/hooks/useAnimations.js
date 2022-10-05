import React, { createContext, useEffect, useState } from "react";

export const AnimationsContext = createContext(true);

const AnimationsContextProvider = (props) => {
  const [animate, setAnimate] = useState(false);

  useEffect(() => {
    setAnimate(JSON.parse(localStorage.getItem("animate") || "true"));
  }, [])

  useEffect(() => {
    localStorage.setItem("animate", JSON.stringify(animate));
  }, [animate])

  return <AnimationsContext.Provider value={{ animate, setAnimate }} >
    {props.children}
  </AnimationsContext.Provider>
}

export default AnimationsContextProvider;
