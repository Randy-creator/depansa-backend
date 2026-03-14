import { NextFunction } from "express";

import { ApiError } from "./api-error";

export const NotFoundError = (message: string, next: NextFunction) => {
  const notFoundError = new ApiError(message, 404);
  next(notFoundError);
};
