import { Account } from "@prisma/client";
import * as bcrypt from "bcryptjs";
import * as jwt from "jsonwebtoken";
import { OAuth2Client } from "google-auth-library";

import { getPrismaClient } from "@/configs";
import { ApiError } from "@/errors";

const googleClient = new OAuth2Client(
      "255470363771-2b7b8jkd4njhffchc33er1icsm7r1kdi.apps.googleusercontent.com"
    );

export class AccountServices {
  static async singUp(userId: string, account: Account) {
    const accountExistUsername = await getPrismaClient().account.findFirst({ where: { OR: [{ username: account.username }, { email: account.email }] } });

    if (accountExistUsername) {
      const isEmailExisting = account.email === accountExistUsername.email;
      throw new ApiError((isEmailExisting ? "Email" : "Username") + "=" + (isEmailExisting ? account.email : account.username) + " is already used", 400);
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(account.password, salt);
    const parsedAccount: Account = { ...account, id: userId, password: hashedPassword };

    const createdAccount = await getPrismaClient().account.create({
      data: { ...parsedAccount },
    });
    createdAccount.password = undefined;
    return createdAccount;
  }

  static async signIn(email: string, password: string) {
    const account = await getPrismaClient().account.findFirst({ where: { email } });

    if (!account) throw new ApiError(`Account with email=${email} not found`, 404);

    const validPassword = await bcrypt.compare(password, account.password);
    if (!validPassword) throw new ApiError(`Bad password`, 400);
    const token = jwt.sign({ id: account.id, username: account.username, email: account.email }, process.env.JWT_SECRET, { expiresIn: "10h" });
    account.password = undefined;
    return { token, account: account };
  }

  static async getOneById(accountId: string) {
    return await getPrismaClient().account.findUnique({ where: { id: accountId } });
  }

 static async signInWithGoogle(idToken: string) {
  const ticket = await googleClient.verifyIdToken({
    idToken,
    audience: "255470363771-2b7b8jkd4njhffchc33er1icsm7r1kdi.apps.googleusercontent.com",
  });

  const payload = ticket.getPayload();
  if (!payload) throw new ApiError("Invalid Google token", 401);

  const { sub: googleId, email, name } = payload;

  let account = await getPrismaClient().account.findFirst({
    where: {
      OR: [
        { googleId },
        { email },
      ],
    },
  });

  if (!account) {
    account = await getPrismaClient().account.create({
      data: {
        id: googleId,
        username: name ?? email ?? googleId,
        email,
        googleId,
        password: "",
      },
    });
  } else if (!account.googleId) {
    account = await getPrismaClient().account.update({
      where: { id: account.id },
      data: { googleId },
    });
  }

  const token = jwt.sign(
    { id: account.id, username: account.username, email: account.email },
    process.env.JWT_SECRET,
    { expiresIn: "10h" }
  );

  account.password = undefined;
  return { token, account };
}
}
