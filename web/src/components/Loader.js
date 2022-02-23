import React from 'react';
import { LoaderStyles, LdsDualRing } from '../styles/ComponentStyles';

export default function Loader() {
  return (
    <>
      <LoaderStyles>
        <LdsDualRing color={'var(--color-blue)'} />
      </LoaderStyles>
    </>
  );
}
