import React, { useState } from 'react';
import { FiltersWrapper, Orderings, CurrencyFilters, CurrencyButton } from '../styles/ComponentStyles';

export default function CurrencyFilter({onFilterParamsChanged, filterParams}) {

  const onOrderSelection = (event) => {
    onFilterParamsChanged({order: event.target.value});
  }

  const onCurrencySelection = (event) => {
    onFilterParamsChanged({currency: event.target.name});
  }

  return (
    <>
      <FiltersWrapper>
        <Orderings>
          <select onChange={onOrderSelection} >
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
              currencyFilter={filterParams.currency}
              onClick={onCurrencySelection}
            >
              ALL
            </CurrencyButton>
          </li>
          <li>
            <CurrencyButton
              name='HUF'
              currencyFilter={filterParams.currency}
              onClick={onCurrencySelection}
            >
              HUF
            </CurrencyButton>
          </li>
          <li>
            <CurrencyButton
              name='USD'
              currencyFilter={filterParams.currency}
              onClick={onCurrencySelection}
            >
              USD
            </CurrencyButton>
          </li>
        </CurrencyFilters>
      </FiltersWrapper>
    </>
  );
}
