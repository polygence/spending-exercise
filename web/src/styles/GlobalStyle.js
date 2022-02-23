import { createGlobalStyle } from 'styled-components';

const GlobalStyle = createGlobalStyle`
  *,
  *::before,
  *::after {
    box-sizing: border-box;
  }

  html, body, #app {
    height: 100%;
  }

  main {
    min-height: 100%;
  }

  :root {
    --color-background: #F2F1F6;
    --color-white: #fff;
    --color-black: #2e2e2e;
    --color-blue: #307CCC;
    --font-family:'Karla', -apple-system, BlinkMacSystemFont, avenir next, avenir, segoe ui, helvetica neue, helvetica, Ubuntu, roboto, noto, arial, sans-serif;
  }

  html {
    overflow-y: scroll;
  }

  body {
    background-color: var(--color-background);
    color: var(--color-black);
    font-family: var(--font-family);

    @media(max-width: 768px){
      padding: 0 1rem;
    }
  }
`;

export default GlobalStyle;
