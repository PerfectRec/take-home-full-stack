import { gql } from "apollo-server-micro";

export const schema = gql`
  type Question {
    id: ID
    type: String
    weight: Float
    main_text: String
    product_category_id: ID
  }

  type Query {
    questions(product_category_id: ID): [Question]
  }
`;
