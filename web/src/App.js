import React, { useState } from 'react';
import Form from './components/Form';
import FiltersAndOrderings from './components/FiltersAndOrderings';
import SpendingList from './components/SpendingList';
import Layout from './components/Layout';

export default function App() {
  const [spendings, setSpendings]       = useState([]);
  const [filterParams, setFilterParams] = useState({
    order: '-date',
    currency: ''
  });

  const filterParamsHandler = (data) => {
    setFilterParams({...filterParams, ...data});
  };

  return (
    <>
      <Layout>
        <Form />
        <FiltersAndOrderings
          onFilterParamsChanged={filterParamsHandler}
          filterParams={filterParams}
        />
        <SpendingList
          spendings={spendings}
          setSpendings={setSpendings}
          filterParams={filterParams}
        />
      </Layout>
    </>
  );
}
