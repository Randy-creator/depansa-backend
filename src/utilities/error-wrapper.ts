import { NextFunction } from "express";

export const errorWrapper = (fn: Function, next: NextFunction) => {
  try {
    fn();
  } catch (error) {
    next(error);
  }
};
