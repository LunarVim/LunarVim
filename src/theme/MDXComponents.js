import React from 'react';
import MDXComponents from '@theme-original/MDXComponents';
import Asciinema from '../components/Asciinema'

export default {
  ...MDXComponents,

  // Add custom components to be used in markdown
  Asciinema: Asciinema,
}
