-- CreateTable
CREATE TABLE "Subscription" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "accountId" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "endingDate" DATETIME NOT NULL,
    "configurationId" TEXT NOT NULL,
    CONSTRAINT "Subscription_configurationId_fkey" FOREIGN KEY ("configurationId") REFERENCES "Configuration" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Configuration" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "accountId" TEXT NOT NULL,
    "subscriptionId" TEXT NOT NULL,
    "transactionReccurency" INTEGER NOT NULL,
    "transactionCountDays" INTEGER NOT NULL,
    "loginWithoutPassword" BOOLEAN NOT NULL,
    "currency" TEXT NOT NULL
);
