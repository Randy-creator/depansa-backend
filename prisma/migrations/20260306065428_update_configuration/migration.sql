/*
  Warnings:

  - You are about to drop the column `subscriptionId` on the `Configuration` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Configuration" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "accountId" TEXT NOT NULL,
    "transactionReccurency" INTEGER NOT NULL,
    "transactionCountDays" INTEGER NOT NULL,
    "loginWithoutPassword" BOOLEAN NOT NULL,
    "currency" TEXT NOT NULL
);
INSERT INTO "new_Configuration" ("accountId", "currency", "id", "loginWithoutPassword", "transactionCountDays", "transactionReccurency") SELECT "accountId", "currency", "id", "loginWithoutPassword", "transactionCountDays", "transactionReccurency" FROM "Configuration";
DROP TABLE "Configuration";
ALTER TABLE "new_Configuration" RENAME TO "Configuration";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
