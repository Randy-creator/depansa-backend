import { NextFunction } from "express";

import { ApiError } from "./api-error";

export const ForbiddenError = (message: string, next: NextFunction) => {
  const forbiddenError = new ApiError(message, 403);
  next(forbiddenError);
};
