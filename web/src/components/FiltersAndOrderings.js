import React from 'react';

import { FiltersWrapper, Orderings, CurrencyFilters, CurrencyButton } from '../styles/ComponentStyles';

export default function CurrencyFilter({
}) {

  return (
    <>
      <FiltersWrapper>
        <Orderings>
          <select>
            <option value='-date'>Sort by Date descending (default)</option>
            <option value='date'>Sort by Date ascending</option>
            <option value='-amount_in_huf'>Sort by Amount descending</option>
            <option value='amount_in_huf'>Sort by Amount ascending</option>
          </select>
        </Orderings>
        <CurrencyFilters>
          <li>
            <CurrencyButton
              name=''
            >
              ALL
            </CurrencyButton>
          </li>
          <li>
            <CurrencyButton
              name='HUF'
            >
              HUF
            </CurrencyButton>
          </li>
          <li>
            <CurrencyButton
              name='USD'
            >
              USD
            </CurrencyButton>
          </li>
        </CurrencyFilters>
      </FiltersWrapper>
    </>
  );
}
