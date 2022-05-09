import Script from "next/script";
import { AppProps } from "next/app";

import { ApolloProvider } from "@apollo/client";
import apolloClient from "@lib/graphql/client";

import Header from "@components/header";
import Footer from "@components/footer";
import "styles/globals.css";

export default function MyApp({ Component, pageProps }: AppProps) {
  return (
    <>
      <ApolloProvider client={apolloClient}>
        <Header />
        <Component {...pageProps} />
      </ApolloProvider>
      <Footer />
    </>
  );
}
