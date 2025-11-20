import crypto from 'crypto';
import { FIFTEEN_MINUTES, ONE_DAY } from '../constants/time.js';
import { Session } from '../models/session.js';

export const createSession = async (userId) => {
  const accessToken = crypto.randomBytes(30).toString('base64');
  const refreshToken = crypto.randomBytes(30).toString('base64');

  return Session.create({
    userId,
    accessToken,
    refreshToken,
    accessTokenValidUntil: new Date(Date.now() + FIFTEEN_MINUTES),
    refreshTokenValidUntil: new Date(Date.now() + ONE_DAY),
  });
};

export const setSessionCookies = (res, session, req) => {
  // Проверяем, является ли хост localhost
  const host = req?.headers?.host || res.req?.headers?.host || '';
  const isLocalhost = host.includes('localhost') || host.includes('127.0.0.1');
  
  res.cookie('accessToken', session.accessToken, {
    httpOnly: true,
    secure: !isLocalhost,
    sameSite: isLocalhost ? 'lax' : 'none',
    maxAge: FIFTEEN_MINUTES,
  });

  res.cookie('refreshToken', session.refreshToken, {
    httpOnly: true,
    secure: !isLocalhost,
    sameSite: isLocalhost ? 'lax' : 'none',
    maxAge: ONE_DAY,
  });

  res.cookie('sessionId', session._id, {
    httpOnly: true,
    secure: !isLocalhost,
    sameSite: isLocalhost ? 'lax' : 'none',
    maxAge: ONE_DAY,
  });
};

