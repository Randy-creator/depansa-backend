import * as swaggerDocument from "@docs/openapi.json";
import { Router } from "express";
import * as swaggerUi from "swagger-ui-express";

export const swaggerRouter = Router();

swaggerRouter.use("/api-docs", swaggerUi.serve);
swaggerRouter.get("/api-docs", swaggerUi.setup(swaggerDocument));
