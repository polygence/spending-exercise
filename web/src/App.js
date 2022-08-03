import React, { useState } from 'react';
import Form from './components/Form';
import FiltersAndOrderings from './components/FiltersAndOrderings';
import SpendingList from './components/SpendingList';
import Layout from './components/Layout';

export default function App() {
  const [spendings, setSpendings] = useState([]);
  const [filterParams, setFilterParams] = useState({
    order: "-date",
    currency: ""
  });

  return (
    <>
      <Layout>
        <Form />
        <FiltersAndOrderings
          filterParams={filterParams}
          setFilterParams={setFilterParams}
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
