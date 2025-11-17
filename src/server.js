import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { errors } from 'celebrate';

import { connectMongoDB } from './db/connectMongoDB.js';
import { logger } from './middleware/logger.js';
import notesRoutes from './routes/notesRoutes.js';
import { notFoundHandler } from './middleware/notFoundHandler.js';
import { errorHandler } from './middleware/errorHandler.js';

const PORT = process.env.PORT ?? 3000;

const app = express();

app.use(logger);
app.use(express.json());
app.use(cors());

app.use(notesRoutes);

app.use(notFoundHandler);
app.use(errors());
app.use(errorHandler);

const startServer = async () => {
  try {
    await connectMongoDB();
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  } catch (error) {
    console.error('Failed to start server', error);
    process.exit(1);
  }
};

startServer();
