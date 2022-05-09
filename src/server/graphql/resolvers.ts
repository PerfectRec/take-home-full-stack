import dbRegistry from "@server/db-registry";

export const resolvers = {
  Query: {
    questions: async (_parent: object, args) => {
      const { rows } = await dbRegistry.query(`SELECT * FROM question WHERE product_category_id = '${args.product_category_id}' ORDER BY weight DESC`);
      return rows;
    },
  },
};
