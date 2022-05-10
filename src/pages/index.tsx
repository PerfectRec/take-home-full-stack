import Head from "next/head";
import { gql, useQuery } from "@apollo/client";

const QUESTIONS_QUERY = gql`
  query questions($product_category_id: ID) {
    questions(product_category_id: $product_category_id) {
      id
      type
      main_text
      product_category_id
    }
  }
`;

export default function Index() {
  const { loading, error, data } = useQuery(QUESTIONS_QUERY, {
    variables: {
      product_category_id: "ded315c4-2dc0-4b96-88a3-472cba1cdf75", // Laptops
    },
  });

  return (
    <>
      <Head>
        <title>PerfectRec: Supercharge your dollar</title>
      </Head>
      <div className="container mx-auto min-h-[85vh] items-center justify-center">
        <div className="mx-4 my-4">
          <h2 className="text-3xl font-bold">Find your perfect laptop.</h2>
          <p className="my-2">
            Answer the questions below, and we&apos;ll recommend your perfect
            laptop.
          </p>
          <div className="my-8">
            {loading && <div>Loading...</div>}
            {error && (
              <div>
                <h4 className="text-l font-bold">Error!</h4>
                <p>{error.message}</p>
              </div>
            )}
            {data?.questions[0] && (
              <div>
                <p className="font-bold">{data.questions[0].main_text}</p>
                <p>TBD: Render multiple choice answers here</p>
              </div>
            )}
          </div>
        </div>
      </div>
    </>
  );
}
