import { NextFunction } from "express";

import { ApiError } from "./api-error";

export const UnauthorizedError = (message: string, next: NextFunction) => {
  const unauthorizedError = new ApiError(message, 401);
  next(unauthorizedError);
};
