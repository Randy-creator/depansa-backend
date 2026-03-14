/*
  Warnings:

  - Added the required column `amount` to the `Wallet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `Wallet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isActice` to the `Wallet` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Wallet" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "isActice" BOOLEAN NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accountId" TEXT NOT NULL,
    CONSTRAINT "Wallet_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Wallet" ("accountId", "createdAt", "id", "name", "type") SELECT "accountId", "createdAt", "id", "name", "type" FROM "Wallet";
DROP TABLE "Wallet";
ALTER TABLE "new_Wallet" RENAME TO "Wallet";
CREATE UNIQUE INDEX "Wallet_name_key" ON "Wallet"("name");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
