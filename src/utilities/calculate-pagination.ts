import { PrismaPaginationInfo } from "@/types";

export const calculatePagination = (prismaPaginationInfo: PrismaPaginationInfo) => {
  const { elementCount, page, pageSize } = prismaPaginationInfo;
  const totalPage = Math.max(1, Math.ceil(elementCount / pageSize));
  const currentPage = Math.min(Math.max(page, 1), totalPage);

  return {
    totalPage,
    page: currentPage,
    hasNext: currentPage < totalPage,
    hasPrev: currentPage > 1,
  };
};
