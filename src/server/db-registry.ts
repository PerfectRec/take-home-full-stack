import { Pool } from "pg";

class DbRegistry {
  private pool: Pool;

  async getConnection() {
    // see docs: https://node-postgres.com/api/pool
    if (!this.pool) {
      this.pool = new Pool({
        user: process.env.DB_USER,
        host: process.env.DB_HOST,
        database: process.env.DB_NAME,
        password: process.env.DB_PASSWORD,
        port: Number(process.env.DB_PORT),
        connectionTimeoutMillis: 5000, // 5s
        idleTimeoutMillis: 30000, // 30s until idle connections will close automatically
      });

      this.pool.on("error", (err, client) => {
        console.error("Unexpected error on idle DB client", err);
      });
    }

    return await this.pool.connect();
  }

  async query(sql: string, params: any[] = null) {
    const connection = await this.getConnection();

    try {
      return connection.query(sql, params);
    } finally {
      connection.release();
    }
  }

  async queryOne(sql: string, params: any[] = null): Promise<any> {
    const connection = await this.getConnection();

    try {
      const results = await connection.query(sql, params);
      return results?.rows?.length > 0 ? results.rows[0] : null;
    } finally {
      connection.release();
    }
  }
}

export default new DbRegistry();
