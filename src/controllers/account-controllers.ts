import { RequestHandler } from "express";
import { v4 } from "uuid";
import * as dotenv from "dotenv";
dotenv.config();

import { AccountServices } from "@/services";
import { errorWrapper } from "@/utilities";
import { AccountValidator } from "@/validator";
import { ApiError } from "@/errors";

export class AccountController {
  static readonly signIn: RequestHandler = async (req, res, next) => {
    try {
      const { email, password } = req.body;
      AccountValidator.signIn({ email, password });
      const data = await AccountServices.signIn(email, password);
      res.json(data);
    } catch (err) {
      next(err);
    }
  };

  static readonly signUp: RequestHandler = async (req, res, next) => {
    try {
      const account = req.body;
      AccountValidator.signUp(account);
      const createdUser = await AccountServices.singUp(v4(), account);
      res.json(createdUser);
    } catch (err) {
      next(err);
    }
  };

  static readonly signInWithGoogle: RequestHandler = async (req, res, next) => {
    try {
      const { idToken } = req.body;
      if (!idToken) throw new Error("idToken is required");
      const data = await AccountServices.signInWithGoogle(idToken);
      res.json(data);
    } catch (err) {
      next(err);
    }
  };

    static readonly resetPassword: RequestHandler = async (req, res, next) => {
      try {
        const { email, oldPassword, newPassword } = req.body;
        if (!email || !oldPassword || !newPassword) {
          throw new ApiError("email, oldPassword and newPassword are required", 400);
        }
        await AccountServices.resetPassword(email, oldPassword, newPassword);
        res.json({ message: "Password updated successfully" });
      } catch (err) {
        next(err);
      }
    };
}