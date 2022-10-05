import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';
import Stars from "../Stars";

const FeatureList = [
  {
    title: 'Opinionated',
    Svg: require('@site/static/img/telescope.svg').default,
    description: (
      <>
        LunarVim ships with a sane default config for you to build on top of. Features include autocompletion, integrated terminal, file explorer, fuzzy finder, LSP, linting, formatting and debugging.
      </>
    ),
  },
  {
    title: 'Extensible',
    Svg: require('@site/static/img/astronaut.svg').default,
    description: (
      <>
        Just because LunarVim has an opinion doesn't mean you need to share it. Every builtin plugin can be toggled on or off in the config.lua file. This is the place to add your own plugins, keymaps, autocommands, leader bindings and all other custom settings.
      </>
    ),
  },
  {
    title: 'Fast',
    Svg: require('@site/static/img/rocket.svg').default,
    description: (
      <>
        LunarVim lazyloads plugins wherever possible to maximize speed. Disabled plugins also will not decrease speed due to the plugin list being compiled with only the active plugins. This strategy allows LunarVim to not have to choose between features and speed.
      </>
    ),
  },
];

const Feature = ({Svg, title, description}) => (
  <div className={clsx('col col--4')}>
    <div className="text--center">
      <Svg className={styles.featureSvg} role="img" />
    </div>
    <div className="text--center padding-horiz--md">
      <h3>{title}</h3>
      <p>{description}</p>
    </div>
  </div>
);

const Features = () => {
  return (
    <Stars starsCount={40}>
      <section className={styles.features}>
        <div className={`container ${styles.container}`}>
          <div className="row">
            {FeatureList.map((props, idx) => (
              <Feature key={idx} {...props} />
            ))}
          </div>
        </div>
      </section>
    </Stars>
  );
}

export default Features;
