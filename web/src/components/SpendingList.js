import React, { useState, useEffect } from "react";
import {FiDollarSign, FiTrash2} from "react-icons/fi";
import { DateTime } from "luxon";
import Loader from "./Loader";
import {
  ErrorMessage,
  Spending,
  IconWrapper,
  RedIconWrapper,
  TextWrapper,
  Amount,
  AmountWrapper,
} from "../styles/ComponentStyles";

export default function SpendingList({ spendings, setSpendings, filterParams }) {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    setLoading(true);
    let params = new URLSearchParams(filterParams).toString();
    fetch(`http://localhost:5000/spendings?${params}`, {
      method: "GET",
      headers: { "Content-Type": "application/json" },
    })
      .then(async (res) => {
        const body = await res.json();
        return {
          status: res.status,
          body,
        };
      })
      .then((response) => {
        if (response.status === 200) {
          setSpendings(response.body);
        }
      })
      .catch((err) => {
        console.error(err);
        setError(true);
      })
      .finally(() => {
        setLoading(false);
      });
  }, [filterParams]);

  const deleteHandler = spending => e => {
    e.preventDefault();
    if (window.confirm("Are you sure you want to delete " + spending.description + "?") == true) {
      setLoading(true);
      fetch(`http://localhost:5000/spendings/${spending.id}`, {
        method: "DELETE",
        headers: {"Content-Type": "application/json"},
      })
        .then(async (res) => {
          const body = await res.json();
          return {
            status: res.status,
            body,
          };
        })
        .then((response) => {
          if (response.status === 200) {
            let index = spendings.findIndex(function(sp) {
              return sp.id == spending.id
            });
            spendings.splice(index, 1);
            setSpendings(spendings);
          }
        })
        .catch((err) => {
          console.error(err);
        })
        .finally(() => {
          setLoading(false);
        });
    }
  }

  if (loading) return <Loader />;

  return (
    <>
      {error && (
        <ErrorMessage>
          The server is probably down. Please try again later.
        </ErrorMessage>
      )}
      {!spendings.length && !error && (
        <h1 style={{ textAlign: "center", marginTop: "4rem" }}>
          Yay!{" "}
          <span role="img" aria-label="jsx-a11y/accessible-emoji">
            🎉
          </span>{" "}
          No spendings!
        </h1>
      )}
      {spendings.length > 0 &&
      spendings.map((spending) => (
        <Spending key={spending.id}>
          <IconWrapper>
            <FiDollarSign color="var(--color-blue)"/>
          </IconWrapper>
          <TextWrapper>
            <h3>{spending.description}</h3>
            <p>
              {DateTime.fromISO(spending.spent_at).toFormat(
                "t - MMMM dd, yyyy"
              )}
            </p>
          </TextWrapper>
          <AmountWrapper>
            <Amount currency={spending.currency.name}>
              {(parseFloat(spending.amount_cents) / 100).toFixed(spending.currency.scale)}
            </Amount>
          </AmountWrapper>
          <RedIconWrapper onClick={deleteHandler(spending)}>
            <FiTrash2 color="var(--color-red)"/>
          </RedIconWrapper>
        </Spending>
      ))}
    </>
  );
}
