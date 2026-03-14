/*
  Warnings:

  - You are about to drop the column `configurationId` on the `Subscription` table. All the data in the column will be lost.

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
    "currency" TEXT NOT NULL,
    "subscriptionId" TEXT,
    CONSTRAINT "Configuration_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "Subscription" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Configuration" ("accountId", "currency", "id", "loginWithoutPassword", "transactionCountDays", "transactionReccurency") SELECT "accountId", "currency", "id", "loginWithoutPassword", "transactionCountDays", "transactionReccurency" FROM "Configuration";
DROP TABLE "Configuration";
ALTER TABLE "new_Configuration" RENAME TO "Configuration";
CREATE UNIQUE INDEX "Configuration_subscriptionId_key" ON "Configuration"("subscriptionId");
CREATE TABLE "new_Subscription" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "accountId" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "endingDate" DATETIME NOT NULL
);
INSERT INTO "new_Subscription" ("accountId", "endingDate", "id", "token") SELECT "accountId", "endingDate", "id", "token" FROM "Subscription";
DROP TABLE "Subscription";
ALTER TABLE "new_Subscription" RENAME TO "Subscription";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
