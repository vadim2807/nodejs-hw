import { isHttpError } from 'http-errors';

export const errorHandler = (err, req, res, next) => {
  const status = isHttpError(err) ? err.status : 500;
  const message = isHttpError(err) ? err.message : 'Internal Server Error';

  res.status(status).json({
    message,
  });
};

