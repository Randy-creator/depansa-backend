import { RequestHandler } from "express";
import * as jwt from "jsonwebtoken";

import { ApiError } from "@/errors";

export const securityHandler: RequestHandler<any, any, any, any, any> = (req, _res, _next) => {
  const primaryToken = `${req.headers.authorization}`.split(" ");
  if (primaryToken.length === 0) throw new ApiError("Bad credentials", 403);
  const token = primaryToken[1];

  const { accountId } = req.params as Record<string, string>;

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    const decodedAccount = decoded?.valueOf() as any;
    if (err || accountId !== decodedAccount.id) throw new ApiError("Invalid token", 403);
    (req as any).account = decodedAccount;
    _next();
  });
};
