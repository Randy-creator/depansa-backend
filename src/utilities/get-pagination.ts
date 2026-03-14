import { PaginationResult } from "@clients";

export const getPagination = (page: number, pageSize: number, count: number): PaginationResult => {
  const decimalPageSize = count / pageSize;
  const totalPage = count % pageSize == 0 ? decimalPageSize : 1 + Math.round(decimalPageSize);

  return {
    hasNext: totalPage > page,
    hasPrev: page > 1,
    page,
    totalPage,
  };
};
