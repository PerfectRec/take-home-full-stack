import { ApolloServer } from "apollo-server-micro";
import Cors from "micro-cors";
import { schema as typeDefs } from "@server/graphql/schema";
import { resolvers } from "@server/graphql/resolvers";

const cors = Cors();

const apolloServer = new ApolloServer({
  typeDefs,
  resolvers,
});

const startServer = apolloServer.start();

export default cors(async function handler(req, res) {
  // allow CORS requests from Apollo Studio in local environment
  if (process.env.APP_ENV === "local") {
    res.setHeader("Access-Control-Allow-Credentials", "true");
    res.setHeader(
      "Access-Control-Allow-Origin",
      "https://studio.apollographql.com"
    );
    res.setHeader(
      "Access-Control-Allow-Headers",
      "Origin, X-Requested-With, Content-Type, Accept"
    );
  }

  if (req.method === "OPTIONS") {
    res.end();
    return false;
  }

  await startServer;

  await apolloServer.createHandler({
    path: "/api/graphql",
  })(req, res);
});

export const config = {
  api: {
    bodyParser: false,
  },
};
