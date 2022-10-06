import React, { useEffect, useRef } from 'react';
import BrowserOnly from '@docusaurus/BrowserOnly';
import Translate from '@docusaurus/Translate';

const AsciinemaPlayer = ({ src, ...asciinemaOptions }) => {
  // ignore if run on node
  if (typeof window === 'undefined') {
    return null;
  }

  const [lib, setLib] = React.useState(null);
  const ref = useRef(null);

  // load asciinema-player library dynamic
  // top-level import will cause error when building
  useEffect(async () => {
    const loadLib = async () => {
      return await import('asciinema-player');
    }

    setLib(await loadLib());
  }, [lib]);


  // create player instance
  useEffect(() => {
    if (!lib) {
      return;
    }

    const currentRef = ref.current;
    lib.create(src, currentRef, asciinemaOptions);
  }, [lib, src]);

  const Loading = () => {
    return (
      <div>
        <Translate description="AsciinemaPlayer loading text">Loading a terminal...</Translate>
      </div>
    );
  }

  return (
    <>
      {lib ?
        <BrowserOnly>{
          () => (<div ref={ref} />)
        }
        </BrowserOnly>
        :
        <Loading />
      }
    </>
  );
};

export default AsciinemaPlayer;
