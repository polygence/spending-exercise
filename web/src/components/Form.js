import React, {useState} from 'react';
import {InputStyles} from '../styles/InputStyles';
import {SelectStyles} from '../styles/SelectStyles';
import {ErrorMessage, SuccessMessage, FormStyles} from '../styles/ComponentStyles';
import Loader from "./Loader";

export default function Form({spendings, setSpendings}) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState({
    error: false,
    messages: []
  });

  const [success, setSuccess] = useState({
    success: false,
    message: ''
  });

  const [state, setState] = useState({
    description: '',
    amount: 0,
    currency: 'USD'
  });

  function handleChange(e) {
    const {name, value} = e.target;

    setState({
      ...state,
      [name]: value
    });
  }

  const submitHandler = (event) => {
    event.preventDefault();
    setError({error: false, message: ''});
    setLoading(true);

    fetch(`http://localhost:5000/spendings`, {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({spending: state})
    })
      .then(async (res) => {
        const body = await res.json();
        return {
          status: res.status,
          body,
        };
      })
      .then((response) => {
        if (response.status === 201) {
          setSuccess({success: true, message: response.body.description + " is successfully created."});
          setState({description: '', amount: 0, currency: 'USD'})
          setSpendings([response.body, ...spendings]);
        } else {
          setSuccess({success: false, message: ''});
          setError({error: true, messages: response.body.messages});
        }
      })
      .catch((err) => {
        console.error(err);
        setSuccess({success: false, message: ''});
        setError({error: true, messages: ["Unexpected error."]});
      })
      .finally(() => {
        setLoading(false);
      });
  }

  if (loading) return <Loader/>;

  return (
    <>
      {success.success && (
        <SuccessMessage>
          {success.message}
        </SuccessMessage>
      )}

      {error.error && (
        <ErrorMessage>
          {error.messages.map((message, index) => (<div key={index}>{message}<br/></div>))}
        </ErrorMessage>
      )}
      <FormStyles onSubmit={submitHandler}>
        <InputStyles
          type='text'
          placeholder='description'
          name='description'
          value={state.description}
          onChange={handleChange}
        />
        <InputStyles
          type='number'
          placeholder='amount'
          name='amount'
          value={state.amount}
          onChange={handleChange}
        />
        <SelectStyles
          name='currency'
          value={state.currency}
          onChange={handleChange}
        >
          <option value='HUF'>HUF</option>
          <option value='USD'>USD</option>
        </SelectStyles>
        <InputStyles type='submit' value='Save' />
      </FormStyles>
    </>
  );
}
