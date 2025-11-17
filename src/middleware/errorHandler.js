import { isHttpError } from 'http-errors';
import { isCelebrateError } from 'celebrate';

export const errorHandler = (err, req, res, next) => {
  if (isCelebrateError(err)) {
    const details = err.details.get('body') || err.details.get('query') || err.details.get('params');
    const message = details ? details.message : 'Validation error';
    return res.status(400).json({
      message,
    });
  }

  const status = isHttpError(err) ? err.status : 500;
  const message = isHttpError(err) ? err.message : 'Internal Server Error';

  res.status(status).json({
    message,
  });
};

