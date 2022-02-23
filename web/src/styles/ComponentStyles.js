import styled from 'styled-components';

export const FiltersWrapper = styled.div`
  display: flex;
  margin-bottom: 2rem;

@media (max-width: 756px) {
  flex-direction: column;
}
`;

export const CurrencyFilters = styled.ul`
  list-style-type: none;
  display: flex;
  padding: 0;
  gap: 1rem;
  margin-left: auto;

@media (max-width: 756px) {
  margin-left: unset;
}
`;

export const CurrencyButton = styled.button`
  border: none;
  font-family: var(--font-family);
  font-size: 20px;
  cursor: pointer;
  background-color: ${(p) =>
    p.name === p.currencyFilter ? '#d1e7fb' : 'var(--color-white)'};
  color: ${(p) =>
    p.name === p.currencyFilter ? 'var(--color-blue)' : 'inherit'};
  font-weight: ${(p) => (p.name === p.currencyFilter ? '700' : '400')};
  border-radius: 8px;
  padding: 6px 12px;
  /* box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 2px 0px,
    rgba(60, 64, 67, 0.15) 0px 1px 3px 1px; */
`;

export const Orderings = styled.div`
  display: flex;
  align-items: center;

  select {
    appearance: none;
    border: none;
    margin: 0;
    font-family: inherit;
    font-size: inherit;
    cursor: inherit;
    line-height: inherit;

    padding: 10px;
    font-family: var(--font-family);
    font-size: 18px;
    border-radius: 8px;
    border: 1px solid darkgray;
    /* box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 2px 0px,
      rgba(60, 64, 67, 0.15) 0px 1px 3px 1px; */
}
`;

export const FormStyles = styled.form`
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  margin-bottom: 4rem;
`;

export const HeaderStyles = styled.header`
  margin-bottom: 4rem;
  font-family: 'Montserrat', 'Poppins', var(--font-family);

  ul {
    list-style-type: none;
    display: flex;
    gap: 5rem;
    text-transform: uppercase;
  }

  li {
    font-weight: 500;
    border-bottom: 2px solid transparent;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    line-height: 1;
    padding: 12px 16px 8px;
    border-radius: 8px;
  }

  @media (max-width: 756px) {
    margin-bottom: 2rem;
  }
`;

export const FlexWrapper = styled.div`
  max-width: 800px;
  margin: 1rem auto;
  display: flex;
  align-items: center;

  @media (max-width: 756px) {
    justify-content: center;
    flex-direction: column;
  }
`;

export const MainContainer = styled.main`
  max-width: 800px;
  margin: 1rem auto;
  position: relative;
`;

export const LdsDualRing = styled.div`
  display: inline-block;
  width: 80px;
  height: 80px;

  &::after {
    content: ' ';
    display: block;
    width: 64px;
    height: 64px;
    margin: 8px;
    border-radius: 50%;
    border: 6px solid var(--color-blue);
    border-color: var(--color-blue) transparent var(--color-blue) transparent;
    animation: lds-dual-ring 1.2s linear infinite;
  }

  @keyframes lds-dual-ring {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
`;

export const LoaderStyles = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
`;

export const Spending = styled.article`
  border-radius: 8px;
  box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 2px 0px,
    rgba(60, 64, 67, 0.15) 0px 1px 3px 1px;
  padding: 1.5rem;
  background-color: var(--color-white);
  display: flex;
  align-items: center;
  margin-bottom: 1.5rem;

  h3,
  p {
    margin: 0;
  }

  h3 {
    line-height: 1.4;
  }

  p {
    color: #adadad;
  }
  @media (max-width: 756px) {
    flex-direction: column;
    padding: 1rem;
  }
`;

export const IconWrapper = styled.div`
  padding: 8px;
  line-height: 0;
  background-color: #d1e7fb;
  border-radius: 12px;
  margin-right: 1.5rem;

  svg {
    width: 28px;
    height: 28px;
  }

  @media (max-width: 756px) {
    margin: 0;

    svg {
      width: 24px;
      height: 24px;
    }
  }
`;

export const TextWrapper = styled.div`
  @media (max-width: 756px) {
    text-align: center;
    margin: 0.5rem 0;
  }
`;

export const AmountWrapper = styled.div`
  margin-left: auto;
  margin-right: 1rem;

  @media (max-width: 756px) {
    margin: 0.5rem 0;
  }
`;

export const Amount = styled.h3`
  &::before {
    content: '${(props) => (props.currency === 'USD' ? '$' : '')}';
  }

  &::after {
    content: '${(props) => (props.currency === 'HUF' ? ' HUF' : '')}';
  }
`;

export const ErrorMessage = styled.h1`
  text-align: center;
  margin: 4rem auto;
  font-size: 20px;
  background-color: #fb7c7d;
  color: var(--color-white);
  padding: 10px 15px;
  border-radius: 8px;
  max-width: 80%;
`;
