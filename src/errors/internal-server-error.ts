import { NextFunction } from "express";

import { ApiError } from "./api-error";

export const InternalServerError = (message: string, next: NextFunction) => {
  const internalServerError = new ApiError(message, 500);
  next(internalServerError);
};
